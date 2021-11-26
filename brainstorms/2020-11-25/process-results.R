library(tidyverse)
library(readxl)
library(here)

# The original file isn't saved, but its not necessary.
here("brainstorms/2020-11-25/menti-results.xlsx") %>%
    read_xlsx(sheet = 1, skip = 2) %>%
    select(-Date, -Session, -Voter) %>%
    pivot_longer(everything(), names_to = "Question", values_to = "Responses") %>%
    filter(!is.na(Responses)) %>%
    mutate(Question = str_remove(Question, "<chr>") %>%
               str_remove("Add as many.*$"),
           Responses = str_to_sentence(Responses)) %>%
    arrange(Question, Responses) %>%
    write_csv(here("brainstorms/2020-11-25/responses.csv"))
