library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(dplyr)
library(ggthemes)
library(fontawesome)
library(shinyjs)
library(formattable)

default_values_coco <- c(1.688, 0.13,0.4,1.0442,0.1326,0.592,0.02692,0.0189,0.0052,0.00508,0.00188) 


base_data<-read.csv("base_table.csv")
##Source pointer
source("dir/coco_ui.R")
source("dir/coco_server.R")

