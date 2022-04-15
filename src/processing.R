#----------- Load libraries ------------#

library(argparser)

#----------- Functions ------------#

parse.arguments <- function(){
  
  parser <- arg_parser(description = 'Process lung datasets.')
  parser <- add_argument(parser, 'dataset.fn',
                         help = 'Filename of input dataset.')
  parser <- add_argument(parser, 'processed.dataset.fn',
                         help = 'Filename for saving processed dataset.')
  parse_args(parser)
  
}

processing <- function(ds){
  
  # Assign NA to missing age values
  if ('-' %in% ds[, 'age']){
    ds[which(ds[, 'age'] == '-'), 'age'] <- NA
  }
  
  ds[, 'sex'] <- as.character(ds[, 'sex'])
  # Make sex variable homogeneous
  if ('1' %in% ds[, 'sex']){
    ds[which(ds[, 'sex'] == 1), 'sex'] <- 'Male'
  }
  if ('2' %in% ds[, 'sex']){
    ds[which(ds[, 'sex'] == 2), 'sex'] <- 'Female'
  }
  
  ds
  
}

#----------- Main ------------#

main <- function(){
  
  # Parse arguments
  args <- parse.arguments()
  
  # Read dataset
  dataset <- read.table(args$dataset.fn, header = T, sep = "," )
  
  # Process dataset
  processed.dataset <- processing(dataset)
  
  # Save processed dataset
  write.csv(processed.dataset, args$processed.dataset.fn, row.names = F, fileEncoding = "UTF-8")
  
}

main()