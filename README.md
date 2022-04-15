# Snakemake-Tutorial

Welcome to this tutorial on Snakemake.

## Introduction

In this project, are stored the files to run a basic tutorial on Snakemake.
In this tutorial, you will learn:

- The files needed/used to run Snakemake

- How to write a simple Snakefile

- The usage of Snakemake, and, in particular, how to run a basic pipeline with Snakemake.

As example, you will run a pipeline using as input two lung cancer datasets. Each dataset contains survival information together with other clinico-pathological variables, and the step performed by the pipeline are:

- Data processing

- Analysis of patients' characteristics

- Survival analysis

The input data, the packages and the code used to run the pipeline are listed below.

## Project structure

```
├── README.md                             <- This file, basic overview of the project.
│
├── Miniconda3-latest-Linux-x86_64.sh     <- File to install Miniconda.
│
├── data /                                <- Folder containing input datasets.
│
├── src/                                  <- Folder containing source code.
│   ├── analyses_pipeline.Rmd             <- Rmd file showing analyses performed.
│   ├── patients_info.R                   <- Script to obtain patients information.
│   ├── processing.R                      <- Script to process datasets.
│   └── survival_analysis                 <- Script to perform survival analysis.
│
├── preprocessed_files/                   <- Intermediate folder produced by Snakemake, containing processed datasets (not tracked by git).
│
├── output/                               <- Output folder produced by Snakemake (not tracked by git).
│   ├── patients_info/                    <- Folder with patients information files (not tracked by git).
│   ├── reports/                          <- Folder with html reports (not tracked by git).
│   └── survival_analysis/                <- Folder with survival analysis files (not tracked by git).
│
├── Snakefile                             <- Snakemake file with rules for workflow managament.
├── config.yaml                           <- Snakemake configuration file.
└── snakemake.yaml                        <- Required packages.

```

## Run the pipeline

We will run this tutorial on Gitpod and we will also need to install conda to allow using a conda envirnoment (containng the packages used in the pipeline).

### Setting up

#### Start Gitpod

In the browser’s address bar, prefix the entire URL with `gitpod.io/#` and press `ENTER` (another option is to install Gitpod browser extension:

- Chrome: https://chrome.google.com/webstore/detail/gitpod-always-ready-to-co/dodmmooeoklaejobgleioelladacbeki

- Firefox: https://addons.mozilla.org/en-US/firefox/addon/gitpod/

After the installation, you’ll find a green button ‘Gitpod’ in the repository, press it to start Gitpod).

#### Install Miniconda

- Open the terminal in Gitpod

- Run in the terminal: ```bash Miniconda3-latest-Linux-x86_64.sh```

- Accept default settings, etc. by pressing `ENTER` or typing `yes`

- Close the terminal and open a new one

#### Install conda environment

Run in the terminal: 

```conda env create -f snakemake.yaml```

#### Activate conda environmnet

Run in the terminal: 

```conda activate snakemake```

You're ready to use Snakemake (finally)!!

### Run Snakemake

To run the complete pipeline:

- Set your working directory in this repository (the Snakefile has to be in the root folder)

- Run in the terminal: 

```
snakemake -c1
```

