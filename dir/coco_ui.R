coco_ui <- function(){
  fluidRow(
    column(width = 7,
           ################### first box of n, p, k....
           box(
             title = HTML('<p><span style="font-weight: bold; color: #b06000;">Select the nutrient you want to test!,</span></p>
                          <span style="font-weight: bold; color: #b06000; font-size: 10px;">(അറിയേണ്ട പോഷകം തിരഞ്ഞെടുക്കുക)</span>'),
             width = NULL, solidHeader = TRUE,
               useShinyjs(),
               
               tags$head(
                 tags$style(HTML("
            .btn {
                color: black;
            }
            .item {
                background-color: lightblue;
            }
            .myactive {
                background-color: #f2c48d !important;
            }
        "))
               ),
               tags$style(
                 HTML("
      /* Define the bold text class */
      .bold-text {
        font-weight: bold; /* Set font weight to bold */
      }
    ")
               ),
               
               div(id = "buttons",
                   lapply(1:(nrow(base_data)-1), function(i) {
                     actionButton(
                       inputId = paste0("button_",i),
                       label = paste("", base_data[i, 1]),
                       style = "border-radius: 30%; width: 70px; height: 70px; margin: 5px;",
                       class = "bold-text" # Add a CSS class to the actionButton
                     )
                   })
               ),
               
               tags$br(),
             h3(style = "color: #aeb1b5; font-weight: bold; font-size: 10px;", "The data entered below will appear in the box to the top right (താഴെ രേഖപ്പെടുത്തുന്ന അളവുകൾ വലതു വശത്തു മുകളിൽ കാണാം  )")
           ),
           ################################ box 2 input box
           tags$style(HTML("
      .numeric-input-box {
        width: 28%; /* Adjust the width of the box */
        margin: 10px; /* Add margin between boxes */
      }
    ")),
           box( uiOutput("display_message1"),
             title = HTML('<p><span style="font-weight: bold; color: #b06000;">Enter the observed value for each Nutrient here :-</span></p> 
                          <span style="font-weight: bold; color: #b06000; font-size: 10px;">പോഷകത്തിന്റെ അളവ് ഇവടെ രേഖപ്പെടുത്തുക </span>'),
             width = NULL,
             div(
               style = "display: flex; flex-wrap: wrap;",
               lapply(
                 1:(nrow(base_data) - 1),
                 function(i) {
                   div(
                     class = "numeric-input-box col-md-4",
                     numericInput(
                       inputId = paste0("numeric_", i),
                       label = paste0("Enter data for ", base_data[i, 1]),
                       value = default_values_coco[i],
                       min = 0
                     )
                   )
                 }
               )
             )
           
            
           ),
           
           
     ############################################################ 
     
     
     ########################################### Box 3 display box
          
    ),
    column(width = 5,
           box(width = NULL, status = "warning",
               div(
                 style = "display: flex; justify-content: center;",  # Center content horizontally
               tableOutput("display_table"),
               tags$style(  type="text/css", "#display_table th,td {border: medium solid #000000;text-align:center}"),
               tags$style(  type="text/css", "#display_table td {border: medium solid #000000;text-align:center}"),
               tags$style(
                 type = "text/css",
                 HTML("#display_table { margin: 0 auto; text-align: center; }")
               ),
               tags$style(
                 HTML(".display_table th:first-child, .display_table td:first-child { font-weight: bold; }")
               ),
               tags$br()
               ),
             
               div(
                 style = "display: flex; justify-content: center;",  # Center content horizontally   
               
                 useShinyjs(),
                 
                 tags$head(
                   tags$style(HTML(
                     "@keyframes glowing {
         0% { background-color: #fcfcfc; box-shadow: 0 0 5px #0795ab; }
         50% { background-color: #e8f0fc; box-shadow: 0 0 20px #43b0d1; }
         100% { background-color: #fcfcfc; box-shadow: 0 0 5px #0795ab; }
       }"
                   ))
                 ),
                 
              uiOutput("action_button"),
               tags$br(),
               tags$br()
           )
           )
      
    ),
    
   ################################## result box 
    column(width = 5,
           box( title = HTML('<p><span style="font-weight: bold; color: #b06000;">Analysis result will appear here:-</span></p> 
                          <span style="font-weight: bold; color: #b06000; font-size: 10px;">വിശകലന ഫലം ഇവടെ കാണാം </span>'),
                width = NULL,
                formattableOutput("result_table"),
                tags$br(),
                tags$style(HTML("
        .large-blinking-text {
          font-size: 20px; /* Change the font size as desired */
          animation: blinker 1s linear infinite;
        }
        
        @keyframes blinker {
          0% { opacity: 1.0; }
          50% { opacity: 0.0; }
          100% { opacity: 1.0; }
        }
      ")),
                tags$div(
                  style = "display: flex; justify-content: center;",  
                  class = "large-blinking-text",
                  htmlOutput("htmlout")
                )
          
           )                                                                                                                                                     
           
           )
  )
}