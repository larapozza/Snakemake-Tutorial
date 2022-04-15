#----------- Load libraries ------------#

library(dplyr)
library(gtsummary)
library(webshot)

#----------- Functions ------------#

adjust_cols <- function(ds){
  
  num.vars <- c("inst", "age", "ph.ecog", "meal.cal", "wt.loss")
  ds[, num.vars] <- lapply(ds[, num.vars], as.numeric)
  
  ds$ph.ecog <- ifelse(ds$ph.ecog == 0, 'Asymptomatic',
                       ifelse(ds$ph.ecog == 1, "Symptomatic and ambulatory",
                              ifelse(ds$ph.ecog == 2, "In bed <50% of the day",
                                     ifelse(ds$ph.ecog == 3, "In bed >50% of the day (not bedbound)", "Bedbound"))))
  
  num.vars <- c("inst", "age", "ph.ecog", "ph.karno", "pat.karno", "meal.cal", "wt.loss")
  cat.vars <- c("inst","sex", "ph.ecog", "ph.karno", "pat.karno")
  
  ds[, cat.vars] <- lapply(ds[, cat.vars], as.factor)
  
  ds
}

#----------- Main ------------#

main <- function(){
  
  # Get input file from snakemake
  dataset.fn <- snakemake@input[['dataset']]
  
  # Read file
  dataset <- read.table(dataset.fn, header = T, sep=",")
  
  # Select columns
  dataset <- dataset %>% select(-c("time", "status"))
  
  # Adjust columns
  dataset <- adjust_cols(dataset)
  
  # Get patients statistics
  pats.stats <- dataset %>%
    tbl_summary(
      label = list(inst ~ "Institution",
                   age ~ "Age",
                   sex ~ "Sex",
                   ph.ecog ~ "ECOG performance, physician",
                   ph.karno ~ "Karnofsky performance, physician",
                   pat.karno ~ "Karnofsky performance, patient",
                   meal.cal ~ "Calories consumed at meals",
                   wt.loss ~ "Weight loss (pounds)"),
      missing_text = "Unknown"
    ) %>%
    modify_caption(paste0("**Table 1. Patient Characteristics ", unlist(strsplit(dataset.fn, '[/.]'))[[2]], "**")) %>%
    bold_labels()
  
  # Save table into Word document
  pats.stats %>%
    as_flex_table() %>%
    flextable::save_as_docx(path = snakemake@output[[1]])
  
  # Save table into Pdf document
  pats.stats %>%
    as_flex_table() %>%
    flextable::save_as_image(path = snakemake@output[[2]])
  
}

main()