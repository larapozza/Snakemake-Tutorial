#----------- Load libraries ------------#

library(argparser)
library(dplyr)
library(survminer)
library(survival)

#----------- Functions ------------#

parse.arguments <- function(){
  
  parser <- arg_parser(description = 'Survival analysis for lung datasets.')
  parser <- add_argument(parser, 'dataset.fn',
                         help = 'Filename of input dataset.')
  parser <- add_argument(parser, 'stratification', type = 'character',
                         help = 'Stratification type.')
  parser <- add_argument(parser, 'km.curves.pdf.fn',
                         help = 'Filename for KM curves output, PDF file.')
  parse_args(parser)
  
}

adjust_cols <- function(ds){
  
  num.vars <- c("time", "status")
  ds[, num.vars] <- lapply(ds[, num.vars], as.numeric)
  
  ds$sex <- as.character(ds$sex)
  
  ds
}

#----------- Main ------------#

main <- function(){
  
  # parse arguments
  args <- parse.arguments()
  
  # Read dataset
  dataset <- read.table(args$dataset.fn, header = T, sep=",")
  
  # Select columns
  dataset <- dataset %>% select(c("time", "status", "sex"))
  
  # Adjust columns
  dataset <- adjust_cols(dataset)
  
  # Determine stratification
  if (args$stratification == 'sexStratif'){
    fit <- survfit(Surv(time, status) ~ sex, data = dataset)
    title <- paste0('KM curves of ', unlist(strsplit(args$dataset.fn, '[/.]'))[[2]], ' sex-stratified')
  } else{
    fit <- survfit(Surv(time, status) ~ 1, data = dataset)
    title <- paste0('KM curve of ', unlist(strsplit(args$dataset.fn, '[/.]'))[[2]])
  }
  
  # Survival analysis
  p <- ggsurvplot(
    fit = fit,
    data = dataset,
    xlab = "Days", 
    ylab = "Overall survival probability",
    risk.table =T,
    title = title )
  
  # Save KM curves in PDF file
  pdf(args$km.curves.pdf.fn, width = 8, height = 8, onefile=F)
  print(p)
  dev.off()
  
}

main()