# Snakemake-Tutorial

Tutorial on Snakemake

## Introduction

In this project, are stored the files to run a basic tutorial on Snakemake.
In this tutorial, you will learn:

- the files needed/used to run Snakemake

- how to write a simple Snakefile

- the usage of Snakemake, and, in particular, how to run a basic pipeline with Snakemake.

As example, you will run a pipeline using as input two lung cancer datasets. Each dataset contains survival information together with other clinico-pathological variables, and the step performed by the pipeline are:

- Data processing

- Analysis of patients' characteristics

- Survival analysis

The input data, the packages and the code used to run the pipeline are listed below.

## Project structure

```
├── README.md                       <- This file, basic overview of the project.
│
├── data                            <- Datasets.
│
├── src/                            <- Source code.
│   ├── analyses_pipeline.Rmd       <- Rmd file showing analyses performed.
│   ├── patients_info.R             <- Script to obtain patients information.
│   ├── processing.R                <- Script to process datasets.
│   └── survival_analysis           <- Script to perform survival analysis.
│
├── preprocessed_files/             <- Intermediate folder produced by Snakemake, containing processed datasets (not tracked by git).
│
├── output/                         <- Output folder produced by Snakemake (not tracked by git).
│   ├── patients_info/              <- Folder with patients information files (not tracked by git).
│   ├── reports/                    <- Folder with html reports (not tracked by git).
│   └── survival_analysis/          <- Folder with survival analysis files (not tracked by git).
│
├── Snakefile                       <- Rules for the Snakemake workflow managament system.
├── config.yaml                     <- Snakemake configuration file.
└── snakemake.yaml                  <- Required packages.

```

## Run the pipeline

### Installing required packages

As first step, the required packages, listed in snakemake.yml, can be installed by installing a conda environment from the terminal (to do so, conda has to be previously installed).

```
conda env create -f snakemake.yml
```

### Run Snakemake

To run the complete pipeline:

- check to set your working directory in this repository (the Snakefile has to be in the root folder)

- execute the following line of code in the terminal:

```
snakemake -c1
```

