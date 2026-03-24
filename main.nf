nextflow.enable.dsl=2


process BUILD_INDEX {

    publishDir "${params.outdir}/index", mode: 'copy'

    input:
    path transcriptome

    output:
    path "salmon_index"

    script:
    """
    salmon index -t ${transcriptome} -i salmon_index
    """
}

process QUANT_STEP {

    publishDir "${params.outdir}/quant", mode: 'copy'

    input:
    path index_dir
    tuple val(sample_id), val(condition), path(read1), path(read2)

    output:
    path "${sample_id}_quant"

    script:
    """
    salmon quant \
        -i ${index_dir} \
        -l A \
        -r ${read1} \
        --validateMappings \
        --minAssignedFrags 1 \
        -o ${sample_id}_quant
    """
}

process QC_STEP {

    publishDir "${params.outdir}/qc", mode: 'copy'

    cpus 2
    memory '1 GB'

    input:
    tuple val(sample_id), val(condition), path(read1), path(read2)

    output:
    tuple val(sample_id), val(condition), path(read1), path(read2),
          path("*_fastqc.html"), path("*_fastqc.zip")

    script:
    """
    fastqc ${read1} ${read2}
    """
}

process ALIGN_STEP {

    publishDir "${params.outdir}/alignment", mode: 'copy'

    cpus 4
    memory '2 GB'

    input:
    tuple val(sample_id), val(condition),
          path(read1), path(read2)

    output:
    path "aligned_${sample_id}.txt"

    script:
    """
    echo "Alignment for ${sample_id}" > aligned_${sample_id}.txt
    echo "Condition: ${condition}" >> aligned_${sample_id}.txt
    echo "Reads: ${read1}, ${read2}" >> aligned_${sample_id}.txt
    """
}

workflow {

    samples_ch = Channel
        .fromPath(params.input)
        .splitCsv(header: true)
        .map { row ->
            tuple(
                row.sample,
                row.condition,
                file(row.read1),
                file(row.read2)
            )
        }

    // NEW: reference channel
    ref_ch = Channel.fromPath("transcripts.fa")

    // Build index
    index_ch = BUILD_INDEX(ref_ch)

    // QC
    QC_STEP(samples_ch)

    // ALIGN (optional)
    ALIGN_STEP(samples_ch)

    // QUANT (we will fix next)
    QUANT_STEP(index_ch, samples_ch)
}