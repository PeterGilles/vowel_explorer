library(tidyverse)
library(ggplot2)
library(ggiraph)

data <- readRDS("data.rds")
                       
shinyServer(function(input, output, session) {
  
  # get clicked point
  selected_point <- reactive({
    if( is.null(input$plot_selected)){
      character(0)
    } else input$plot_selected
  })
  
  output$plot <- renderGirafe({
    p <- ggplot(data = data) +
      # using ggiraph's 'geom_text_interactive' instead of ggplot's 'geom_text' allows to add onClick events in Shiny
      geom_text_interactive(
        aes(
          x = T2,
          y = T1,
          label = labels,
          col = next_label,
          data_id = word,
          tooltip = word,
          onclick = onclick
        )
      ) +
      theme_minimal(base_family = "sans", base_size = 14) +
      theme(legend.text = element_text(size = 14, family = "Roboto")) +
      scale_y_reverse(breaks = seq(from = 3, to = 6, by = 1),
                      minor_breaks = NULL) +
      scale_x_reverse(breaks = seq(from = 7, to = 14, by = 1),
                      minor_breaks = NULL) +
      labs(x = "F2 (Bark)", y = "F1 (Bark)", col = "next sound")
    
    girafe(
      ggobj = p,
      fonts = list(sans = "Roboto"),
      width_svg = 13,
      height_svg = 8,
      options = list(
        opts_zoom(max = 5),
        opts_hover(css = "fill:black;cursor:pointer;font-weight:bold;font-size:larger;"),
        opts_selection(type = "single", css = "fill:black;cursor:pointer;font-size:larger;font-weight:bold;")
      )
    )
  })
  
  output$selpoint <- renderUI({
    value <- selected_point()
    if( !isTruthy(value) )
      value <- "<none>"
    tags$div(
      tags$caption("Selected point is:"),
      tags$strong(value)
    )
    
  })
  # render data table
  # searchable by onclick
    output$dt <- DT::renderDataTable({
     data %>% 
        # select columns to apply function, here more complicated for round due to %>%
        mutate_at(c("T1", "T2", "T3", "times_rel"), funs(round(., digits = 2))) %>%
        select(word, labels, next_label, T1, T2, T3, times_rel)
    })
})
