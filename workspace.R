library(tercen)
library(dplyr)
library(reticulate)

options("tercen.workflowId" = "686a2e2bba117e0c118bcb715300b5d3")
options("tercen.stepId"     = "52110340-a9c9-49fd-ba1e-a9b0cc4639b4")

getOption("tercen.workflowId")
getOption("tercen.stepId")

reticulate::source_python("main.py")

df <- (ctx <- tercenCtx()) %>%
  select() %>% run_py_script()

df %>%
  ctx$addNamespace() %>%
  ctx$save()
