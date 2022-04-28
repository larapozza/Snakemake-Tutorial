configfile : 'config.yaml'

#------ Rule all ------#

rule all:
  input:
    'processed_files/lungDataset1.csv',
    'processed_files/lungDataset2.csv'

#------ Data Processing ------#

rule processing:
  input:
    script = 'src/processing.R',
    dataset = 'data/{dataset}.csv'
  output:
    processed_dataset = 'processed_files/{dataset}.csv'
  shell:
    'Rscript {input.script} {input.dataset} {output.processed_dataset}'
    
#------ Data Statistics ------#

rule patients_info:
  input:
    dataset = 'processed_files/{dataset}.csv'
  output:
    'output/patients_info/{dataset}.docx',
    'output/patients_info/{dataset}.pdf'
  script:
    'src/patients_info.R'
    
#------ Survival analysis ------#

rule survival_analysis:
  input:
    'src/survival_analysis.R',
    'processed_files/{dataset}.csv'
  output:
    'output/survival_analysis/{dataset}_{stratif}.pdf',
    'output/survival_analysis/{dataset}_{stratif}.rds'
  shell:
    'Rscript {input} {wildcards.stratif} {output}'
    
#------ Report of analyses ------#

rule report_analyses:
  input:
    patients_info = expand('output/patients_info/{dataset}.pdf', dataset = config['dataset']),
    surv_analysis = expand('output/survival_analysis/{dataset}_{stratif}.pdf', dataset = config['dataset'], stratif = config['stratification'])
  output:
    'output/reports/analyses_lung_cancer.html'
  script:
    'src/analyses_pipeline.Rmd'
