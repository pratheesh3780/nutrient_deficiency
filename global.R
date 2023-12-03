library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(dplyr)
library(ggthemes)
library(fontawesome)
library(shinyjs)
library(formattable)


base_data<-read.csv("base_table.csv")
##Source pointer
source("dir/coco_ui.R")
source("dir/coco_server.R")

