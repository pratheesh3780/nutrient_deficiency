ui <- dashboardPage(
  skin = "green",
  dashboardHeader(
    title = div(
      tags$img(src = "logo.png", height = "33px", style = "margin-top: -5px; margin-right: 10px; float: left;"),
      "GDIGIprobe",
      style = "display: flex; align-items: center;"
    )
  ),


  dashboardSidebar( # Sidebarmenu
    ### changing theme
    sidebarMenu(
      menuItem("Home", tabName = "Home", icon = icon("home")),
      menuItem("Perennials",
        tabName = "bp", icon = icon("align-left"),
        menuItem("Coconut",
          tabName = "coconut", icon = icon("fas fa-island-tropical")
        )
      ),
      tags$br(),
      tags$br(),
      h5(
        tags$div(
          tags$br(),
          "Developed by:",
          tags$br(),
          tags$b("Neeshma N."),
          tags$br(),
          tags$b("MSc Scholar"),
          tags$br(),
          tags$b("Department of SSAC"),
          tags$br(),
          tags$br(),
          "Guided by:",
          tags$br(),
          tags$b("Dr Kiran Karthik Raj"),
          tags$br(),
          tags$b("Assistant Professor (SSAC)"),
          tags$br(),
          tags$b("College of Agriculture, Vellayani"),
          tags$br(),
          tags$b("Kerala Agricultural University"),
          tags$br(),
          tags$br(),
          "Post your queries at: kiran.kr@kau.in",
          style = "color:#e6e0d1; margin-left: 9px;"
        )
      ),
      tags$br(),
      tags$br(),
      tags$br(),
      div(
        style = "display: flex; justify-content: center;",
        img(
          src = "logo.png", align = "center",
          width = "150", height = "150"
        )
      ),
      tags$br(),
      tags$br(),
      h6(
        tags$div(
      tags$b("Website designed and developed by:"),
      tags$br(),
      tags$br(),
      tags$b("Department of Agricultural Statistics"),
      tags$br(),
      tags$br(),
      tags$b("GNU General Public License V3"),
      tags$br(),
      tags$br(),
      a(href = "https://www.gnu.org/licenses/gpl-3.0",
        img(src = "https://img.shields.io/badge/License-GPLv3-blue.svg", alt = "License: GPL v3", height = "20px")
      ),
      tags$br(),
      tags$br(),
      tags$b("Version:"),
      tags$br(),
      tags$br(),
      # Version badge
      img(src = "https://img.shields.io/badge/version-0.0.1-blue.svg", alt = "Version: 1.0", height = "20px"),
      style = "color:#e6e0d1; margin-left: 10px;")
      )
    )
  ),
  dashboardBody(
    tabItems(
      # coconut content
      tabItem(tabName = "coconut", coco_ui()),

      # home tab content
      tabItem(
        tabName = "Home",
        tags$h3(
          HTML("<b style='color: #a86b32'>Introduction to G-DIGIprobe</b>")
        ),
        tags$p(
          HTML("<p style='text-align: justify;'>Introduction
Several strategies were developed for identification of nutrient imbalance in crop
plants. Among them, compositional nutrient diagnosis (CND) norms are recognised as the
most powerful and scientific approach. As compared to other diagnostic tools, CND offers a
generic tactics to profile the nutrient imbalance based on the diagnostic standards developed
using a survey database. The CND norms discriminates connotations between a specific
nutrient with other nutrients under consideration through multivariate analysis. Hence, offers
the highest diagnostic sensitivity and can be considered as the best way to express balance
between plant nutrients.
Background</p>")
        ),
        tags$h3(
          HTML("<b style='color: #a86b32'>Background</b>")
        ),
        tags$p(
          HTML("
                                  
<p style='text-align: justify;'>In CND approach, through an innovative and iterative procedure, nutrient imbalance
assessment will be carried out to diagnose the most limiting nutrient. For which, nutrient
diagnostic standards are developed as per the procedure by Parent and Dafir (1992). Simplex
will be constructed based on percent nutrient content in plants, after appropriate
transformation. Owing to the flexibility, the CND approach permits assessment of nutrient
imbalance in independent plants and dynamic adjustments of fertilization programs for crop
plants. It contemplates the association between a given nutrient and the geometric means of
concentration, on a dry matter basis, recorded for other nutrients. Provisions are also included
for further refinement of this package for fertilizer recommendation based on fertilizer
response trials for various crop plants.</p>")
        ),
        tags$h3(
          HTML("<b style='color: #a86b32'>Instructions</b>")
        ),
        tags$p(
          HTML("
  <ul>
    <li>Enter nutrient content in per cent in respective boxes</li>
    <li>Select ok.</li>
    <li>View result.</li>
  </ul>
  ")
        ),
        tags$div(
          class = "marquee-title",
          HTML("<div style='font-size: 32px; color: #ab802b;white-space: nowrap; animation: marquee 10s linear infinite;'><b>G-DIGIprobe:</b> Geospatial & Digital Identification of Problems in Crops</div>
  <style>
    @keyframes marquee {
      0% { transform: translateX(100%); }
      100% { transform: translateX(-100%); }
    }
  </style>")
        ),
        tags$br(),
        div(
          style = "display: flex; justify-content: center;",
        img(
          src = "logo.png", align = "center",
          width = "200", height = "200"
        )
        ),
        tags$br(),
      )
    )
  )
)