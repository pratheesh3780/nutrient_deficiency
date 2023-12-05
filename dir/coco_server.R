coco_server <- function(input, output,session) {
  #############[1] create buttons click colours
  observe({
    lapply(1:(nrow(base_data)-1), function(i) {
      click_count <- input[[paste0("button_",i)]]
      if (click_count %% 2 == 1) {
        runjs(paste0("$('#button_", i, "').addClass('myactive');"))
      } else {
        runjs(paste0("$('#button_", i, "').removeClass('myactive');"))
      }
    })
  })

  observe({
    lapply(1:(nrow(base_data)-1), function(i) {
      click_count <- input[[paste0("button_", i)]]
      if (click_count %% 2 == 1) {
        shinyjs::show(paste0("numeric_", i))
      } else {
        shinyjs::hide(paste0("numeric_", i))
      }
    })
  }) 
  
 
  
  observe({
    any_odd_click <- any(sapply(1:(nrow(base_data) - 1), function(i) {
      click_count <- input[[paste0("button_", i)]]
      click_count %% 2 == 1
    }))
    
    if (any_odd_click) {
      # Render nothing if any button has an odd click count
      output$display_message1 <- renderUI({
        NULL
      })
      
      # Create a reactive output to display the entered values
      output$display_table <- renderTable({
        result_df <- data.frame(
          Value = sapply(1:nrow(base_data), function(i) {
            if (!is.null(input[[paste0("numeric_", i)]])) {
              input[[paste0("numeric_", i)]]
            } else {
              NA
            }
          })
        )
        row.names(result_df) <- base_data[,1]
        colnames(result_df) <- c("value entered")
        sum_values <- sum(result_df$`value entered`, na.rm = TRUE)
        result_df[nrow(result_df), "value entered"] <- 100 - sum_values
        
        # Filter rows based on any_odd_click
        any_odd_click_values <- sapply(1:(nrow(base_data) - 1), function(i) {
          click_count <- input[[paste0("button_", i)]]
          click_count %% 2 == 1
        })
        result_df$click <- c(any_odd_click_values, NA)
        # Filter result_df based on any_odd_click
        filtered_result_df <- subset(result_df, click == TRUE | is.na(click))
        filtered_result_df <- filtered_result_df %>% select(-click)
        filtered_result_df
      }, rownames = TRUE, digits = 5)
      
      
      
      # RESULTS TABLE
     observeEvent(input$cal, {
       result_df <- data.frame(
         Value = sapply(1:nrow(base_data), function(i) {
           if (!is.null(input[[paste0("numeric_", i)]])) {
             input[[paste0("numeric_", i)]]
           } else {
             NA
           }
         })
       )
       # Filter rows based on any_odd_click
       any_odd_click_values <- sapply(1:(nrow(base_data) - 1), function(i) {
         click_count <- input[[paste0("button_", i)]]
         click_count %% 2 == 1
       })
       
       data_cal<-as.data.frame(cbind(base_data, result_df))
       data_cal$click <- c(any_odd_click_values, NA)
       #row.names
       rownames(data_cal) <- base_data[,1]
       data_cal <- subset(data_cal, click == TRUE | is.na(click))
       
       ### residual
       # Compute the sum of all rows except the last one
       sum_except_last_row <- sum(head(data_cal$Value, -1))
       
       # Set the last row value as 100 minus the sum of previous rows
       data_cal[nrow(data_cal), "Value"] <- 100 - sum_except_last_row
       
       ## Geometric mean
       non_zero_values <- data_cal$Value[data_cal$Value != 0]# Extract non-zero values
       non_zero_values_except_last <- non_zero_values[-length(non_zero_values)] # Exclude the last value
       gm <- exp(mean(log(non_zero_values_except_last), na.rm = TRUE))# Compute geometric mean
       
       data_cal$V<-log(data_cal$Value/gm)
       data_cal$V[data_cal$V == -Inf] <- 0
       data_cal$Index<-(data_cal$V-data_cal$mean)/data_cal$SD
       # Create the "status" column based on the Index values
       data_cal$Status <- ifelse(data_cal$Index > 0, "Balance", "Imbalance")
       data_cal <- data_cal %>%
         filter(Value != 0) %>%
         select(Index, Status) %>%
         slice(-n())
      output$result_table <- renderFormattable({
     
        # A formatter function to format "Balance" and "Imbalance" values
        status_formatter <- formatter(
          "span",
          style = x ~ style(
            font.weight = "bold",
            color = ifelse(x == "Balance", "forestgreen", ifelse(x == "Imbalance", "red", "black"))
          )
        )
       
        # Use formattable
        formattable(
         data_cal,
          list(
            Status = status_formatter
           
          )
        )
      })
      
      # Identifying Imbalance rows and creating blinking text
      imbalance_rows <- data_cal[data_cal$Status == "Imbalance", ]
      imbalance_row_names <- rownames(imbalance_rows)
      
      
      
      output$htmlout <- renderUI({
        HTML(paste("Nutrient Imbalance detected in: ",
                   paste0("<span style='color:red; font-weight:bold;'>", paste(imbalance_row_names, collapse = ", "), "</span>")))
      })
   
      })
      
      
      
      
      
      output$action_button <- renderUI({
        actionButton("cal", "calculate", 
                     style = "animation: glowing 1300ms infinite;")
      })
      
      
      
      
    } else {
      # Render HTML content if all button click counts are even
      output$display_message1 <- renderUI({
        HTML('<p><span style="font-weight: bold; color: #aeb1b5; font-size: 16px;">First select any one or more nutrient from above</span></p>
             <span style="font-weight: bold; color: #aeb1b5; font-size: 10px;">ആദ്യമായ് പോഷകം  മുകളിൽ നിന്ന് തിരഞ്ഞെടുക്കുക </span>
             
             ')
      })
      output$display_table <- renderTable({
        NULL
      })
      
     
   
    }
  })
  
  eventReactive(input$myButton, {
    runjs(paste0('$("#myButton").css("animation","")'))
  })



 
  
  
}