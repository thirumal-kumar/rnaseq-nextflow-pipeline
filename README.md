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

## Run
```bash
nextflow run main.nf -with-docker


## Output
QC reports
Salmon quantification (quant.sf)
