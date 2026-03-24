# RNA-seq Pipeline (Nextflow + Docker)

## Overview
A modular RNA-seq analysis pipeline built using Nextflow with Docker-based reproducibility.

## Requirements
- Nextflow
- Docker

## Features
- Metadata-driven sample processing
- Parallel execution
- FastQC quality control
- Salmon-based transcript quantification
- Containerized execution (Docker)
- Resume and caching support

## Workflow
FASTQ → QC → Indexing → Quantification → TPM output

## Tools Used
- Nextflow
- Docker
- FastQC
- Salmon

## Key Features
- Modular Nextflow pipeline (DSL2)
- Docker-based reproducibility
- Multi-container execution (FastQC, Salmon, BWA)
- Parallel sample processing
- Resume and caching support

## Example Output
- QC reports
- Salmon quantification (quant.sf)

## Use Case
Transcriptomics analysis for gene expression quantification

## Run
```bash
nextflow run main.nf -with-docker

