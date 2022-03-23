#!/usr/bin/env Rscript

# Adapted for this jhudsl repository by Candace Savonen Mar 2022

# Run spell check and save results

library(magrittr)

# Find .git root directory
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

ottrpal::check_quizzes(quiz_dir = file.path(root_dir, 'quizzes'), write_report = TRUE, verbose = TRUE)

if (file.exists("question_error_report.tsv")) {
  quiz_errors <- readr::read_tsv("question_error_report.tsv")

  # Print out how many quiz check errors
  write(nrow(quiz_errors), stdout())
} else {
  quiz_errors <- data.frame()
  
  # Print out how many quiz check errors
  write("1", stdout())
}

if (nrow(quiz_errors) > 0) {
  if (!dir.exists("resources")) {
    dir.create("resources")
    }
  # Save question errors to file
  readr::write_tsv(quiz_errors, file.path("resources", "question_error_report.tsv"))
}