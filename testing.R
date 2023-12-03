


drops <- c("nutrient", "SD","mean","V", "Value")
data_cal[, !(names(data_cal) %in% drops)]
# Filter out rows where 'Value' column is non-zero