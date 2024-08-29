library(shiny)
library(shiny.router)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinyBS)
library(usmap)

source("INFO 201 Viz Code.R")

intro_page <- tabPanel(
  "Introduction", 
  titlePanel("Introduction"),
  img(src = "https://cdn.pixabay.com/photo/2020/06/21/00/43/teacher-5322850_1280.jpg", width = "400px", height = "300px"),
  p(""),
  p("Hi, and welcome to our final deliverable, where we present our data-driven analysis on the \"Impact of High School Teachers on the Geographic Relative Population IQ.\" This project delves into the correlation between the number of high school teachers and the average Intelligence Quotient (IQ) across different states in the United States. By exploring datasets from reputable sources such as the World Population Review and the National Center for Education Statistics (NCES), we, as a team, aim to shed light on the relationship between education and cognitive abilities at a geographic level."),
  p("Through this project, we strive to uncover valuable insights with real-world implications. By analyzing the data, we aim to understand the impact of education on cognitive abilities, identify trends in regional IQ levels, and assess the effectiveness of teachers in different states. The findings from our analysis can inform education policy decisions, guide the allocation of resources, and contribute to the ongoing efforts to enhance teaching quality and educational outcomes."),
  p("In this final deliverable, we have developed a Shiny app that serves as a platform for interactive data exploration and storytelling. The app comprises multiple pages, each offering a unique perspective on the data and presenting key insights through carefully crafted visualizations and interactive elements. We invite you to journey with us through the app, engage with the data, and discover the fascinating relationship between high school teachers, population IQ, and educational landscapes in the United States."),
)

page_one <- tabPanel(
  "Visualization 1", # label for the tab in the navbar
  titlePanel("Visualization 1"), # show with a displayed title
  
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      bsTooltip("iq_range", "This will change the graph by showing only the distribution of the selected IQ group.", placement = "right"),
      selectInput(
        inputId = "iq_range", 
        label = "Select the IQ Group", 
        list("all","high","mid","low"),
        textOutput("result")
      ),
      selectInput(
        inputId = "state1", 
        label = "Select State For Info Table 1", 
        state_names, 
        textOutput("result1")
      ),
      selectInput(
        inputId = "state2", 
        label = "Select State For Info Table 2", 
        state_names, 
        textOutput("result2")
      ),
      sliderInput(
        inputId = "density",
        label = "Filter by Population Density Per Mile", 
        min = 1.28449, 
        max = 1258.55820, 
        value = 1258.55820
      )
    ),
    mainPanel(
      h4("Graph"),
      plotOutput("plot1"),
      p(""),
      h4("Tables For Comparison"),
      tableOutput("table1"),
      tableOutput("table2"),
      p(""),
      h4("Analysis"),
      p("The visualization above showcases the growth rate of the average IQ of the general population in the United States from 2010 to 2023. With the Average IQ on the Y-axis and the population growth rate on the X-axis, the scatter plot reveals a slight positive correlation, indicating that as the population grows, there is a corresponding increase in average IQ. This insight emphasizes the importance of education and population growth in maintaining and improving IQ levels within the population."),
      p("Our first visualization offers interactive features to explore the growth rate of the average IQ across different states in the United States. The first button, labeled Average IQ, allows users to select the IQ group, ranging from 94 to 104, thereby adjusting the displayed data on the graph. By modifying this variable, users can observe how the growth rate of the average IQ corresponds to different IQ levels. Additionally, the second button and third button, labeled “Select State for Table 1” and “Select State for Table 2”  enables users to choose a specific state, resulting in the display of the corresponding growth rate of the average IQ in a tabular format. This feature allows for a detailed examination of IQ trends within individual states. Lastly, an optional number line is available to adjust the population density, further enhancing the analysis.")
    )
  )
)

# Define content for the second page
page_two <- tabPanel(
  "Visualization 2",
  titlePanel("Visualization 2"), 
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "year",
        label = "Select the Year of the Graph", 
        choices = year_num, 
        textOutput("result")
      ),
      selectInput(
        inputId = "stateName", 
        label = "Select State For Its Location", 
        state_names, 
        textOutput("result1")
      ), 
      radioButtons(
        inputId = "coast",
        label = "Data from Which Coast?", 
        choices = list("all","east","west","central")
      ), 
    ),
    mainPanel(
      h4("Graph"),
      plotlyOutput("plot2"),
      p(""),
      h4("Analysis"),
      p("This visualization showcases the evolving relationship between the number of high school students and the teacher-student ratio over time. It reveals a notable shift in the scatter plot, transitioning from a clustered distribution in 2008 to a logarithmic-shaped distribution, indicating an increasing ratio of students per teacher. This trend raises concerns about the potential impact on academic achievement as teachers become responsible for larger groups of students, potentially diminishing their ability to provide individualized support."),
      p("The interactive tool on Shiny for the second visualization offers users the ability to modify the graph by selecting the year (2010-2023), state, and region (west, east, central, or all) within the United States. These interactive features enhance the exploration of the relationship between the number of high school students and the teacher-student ratio, enabling users to analyze the data based on specific time periods, geographical locations, and regions of interest.")
    )
  )
)

# Define content for the third page
page_three <- tabPanel(
  "Visualization 3",
  titlePanel("Visualization 3"), 
  
  sidebarLayout(
    sidebarPanel(
      bsTooltip("iq_status", "This will change the graph by showing the shades of the states in a particular IQ status group.", placement = "right"),
      selectInput(
        inputId = "iq_status", 
        label = "Select the IQ Group", 
        list("all","high","mid","low"),
        textOutput("result")
      ),
      radioButtons(
        inputId = "violin",
        label = "Show Violin Plot or Not?", 
        choices = list("Yes","No")
      ),
      h3("Summary Table For the Selected IQ Group"),
      tableOutput("table3")
    ),
    mainPanel(
      h4("Graph 1"),
      plotOutput("plot3"),
      h4("Sub Plot 1"),
      plotOutput("subplot3"),
      p(""),
      h4("Analysis"),
      p("The third visualization illustrates the distribution of IQ status across all states in the United States, showcasing the percentage change in IQ levels. For this particular visualization we have included two forms of plots, a choropleth map and a violin plot. The choropleth map employs various color gradients to depict the varying IQ levels in each state, highlighting the visual representation of the IQ disparities. The violin plot portrays the variability in IQ status among individuals, categorized into high, medium, and low average IQ states. By selecting various IQ groups and therefore toggling the display of the violin and choropleth plot, users can explore various distribution patterns. Additionally, a numerical summary table provides key statistics such as minimum, maximum, median, and interquartile range (IQR) for each IQ group. Overall, this visualization offers valuable insights into the contrast in IQ statuses across states, highlighting the impact of population change and education quality on IQ levels."),
      p("The visualization reveals a distinct contrast in IQ statuses among states in the US, with higher average IQ states experiencing a greater percentage change in IQ over time. Conversely, states with relatively lower IQ levels tend to exhibit lower percentage changes, which underscores the primary importance of population change and its impact on education quality, as was reflected directly in the plots. Additionally, we found it quite coincidental that the graph highlights regional differences, with northern states showing higher IQ levels, central/eastern states displaying mid-level IQ levels, and southern states such as Texas exhibiting relatively low IQ levels.")
    )
  )
)

conclude_page <- tabPanel(
  "About", 
  titlePanel("About this Project"), 
  p("Our project aimed to analyze and visualize the interplay between population change, teacher-student ratios, IQ levels, and education quality in the United States. Through our visualizations, we were able to provide valuable insights for policymakers, educators, and researchers. By highlighting the positive correlation between population growth and average IQ, the changing teacher-student ratios, and the regional disparities in IQ levels, the project displayed the challenges and opportunities within the education system. Our findings underscore the true importance of considering these dynamics in educational planning and promoting equal access to quality education for all students."),
  p("Our analysis of the visualizations has provided key insights into the relationship between population change, teacher-student ratios, IQ levels, and education quality in the United States. The data-driven stories revealed important patterns and trends that shed light on the challenges and opportunities within the education system.By using various interactive tools, graphs, and data-driven stories, we have attempted to provide a comprehensive understanding of the dynamics shaping education in the United States. We hope that our insights contribute to ongoing discussions and efforts to improve educational outcomes and promote equitable access to quality education for all students."),
  p("Our study utilizes two distinct datasets covering the period from January 2001 to December 2019. The first dataset provides information on the count of teachers and high school students for each state in the United States, enabling us to examine the teacher-student ratio and identify patterns in education systems across different states and years. The second dataset presents population data and the average IQ of each state, allowing us to explore the cognitive abilities of different regions within the country. "),
  h4("Group Members: Haechan (Tristan) Choi, Udith Sreejith, Rishi Victor")
)

# Pass each page to a multi-page layout (`navbarPage`)
ui <- navbarPage(
  "INFO 201 Final Project", # application title
  intro_page,
  page_one,         # include the first page content
  page_two,         # include the second page content
  page_three,       # include the third page content
  conclude_page 
)


# Define the overall server
server <- function(input, output) {
  # Server logic for the overall app
  output$plot1 <- renderPlot({
    # IQ range 
    choice_iq <- input$iq_range 
    if(choice_iq == "all") {
      filt_df_merged <- df_merged 
    }
    else {
      filt_df_merged <- filter(df_merged,IQ_status == choice_iq) 
    }
    
    # Density slider 
    density_pop <- input$density
    filt_df_merged <- filter(filt_df_merged, densityMi <= density_pop)
    
    
    viz1 <- ggplot(filt_df_merged, aes(x = growthSince2010, y = averageIQ)) + 
      geom_point(aes(size = densityMi), alpha = 0.7) +
      geom_smooth(method = lm, se = F) +
      scale_size_continuous(name = "Density of the Population Per Mile") + 
      theme_bw(base_size = 10) + 
      labs(title = "Growth Rate Since 2010 Vs Average IQ", 
           x = "Growth Rate Since 2010", y = "Average IQ ")
    
    return(viz1)
  })
  
  output$table1 <- renderTable({
    selected_state <- input$state1
    
    filtered_df <- filter(df_merged, state == selected_state)
    
    table_data <- filtered_df %>%
      select(state, growthSince2010, averageIQ, rank, densityMi) 
    
    table_data
    
  })
  
  output$table2 <- renderTable({
    selected_state2 <- input$state2
    
    filtered_df2 <- filter(df_merged, state == selected_state2)
    
    table_data2 <- filtered_df2 %>%
      select(state, growthSince2010, averageIQ, rank, densityMi) 
    
    table_data2
  })
  
  output$plot2 <- renderPlotly({
    
    # year input 
    num_year <- input$year
    filt_teachers_df <- filter(teachers_df, year == num_year)
    
    # state location input 
    location_state <- input$coast 
    if(location_state == "all") {
      filt_teachers_df <- filt_teachers_df 
    }
    else {
      filt_teachers_df <- filter(filt_teachers_df,coast == location_state) 
    }
    
    viz2 <-  ggplot(filt_teachers_df, aes(x = pupils, y = pupil_per_fte_teacher, label = state)) + 
      geom_point() +
      geom_text(data = subset(filt_teachers_df, state == state.abb[which(state.name == (input$stateName))]), vjust = 2)
    theme_bw(base_size = 8)
    
    viz2 <- ggplotly(viz2, tooltip = "text")
    
    
    viz2 <- layout(
      viz2, 
      title = list(text = "Number of Highschool Students & The Number of Higschool Students Per One Teacher",
                   font = list(size = 14)), 
      xaxis = list(title = list(text = "Number of Highschool Students", font = list(size = 12))), 
      yaxis = list(title = list(text = "Number of Highschool Students Per One Teachers", font = list(size = 12)))
    )
    
    return(viz2)
  })
  
  output$plot3 <- renderPlot({
    
    if (input$iq_status == "all") {
      filt_df_merged1 <- df_merged 
    } else  {
      filt_df_merged1 <- filter(df_merged,IQ_status == input$iq_status) 
    }
    
    viz3 <- plot_usmap(data = filt_df_merged1, values = "per_change_students",
                       color = "red") + 
      scale_fill_continuous(low = "white", high = "red", 
                            name = "Percent Change of the Students Between 2018 & 2019") + 
      theme(legend.position = "right") + 
      labs(title = "The Percent Change of the Students Between 2018 & 2019")
    
    return(viz3)
  })
  
  output$subplot3 <- renderPlot({
    
    if (input$iq_status == "all") {
      filt_df_merged2 <- df_merged 
    } else  {
      filt_df_merged2 <- filter(df_merged,IQ_status == input$iq_status) 
    }
    
    if(input$violin == "Yes") {
      subplot<-ggplot(data = filt_df_merged2, aes (x = IQ_status, y = per_change_students)) +
                        geom_violin(fill = "pink") +
                        theme_bw (base_size = 12) +
                        labs (title = "The Distribution of Percent Change by IQ Status of the State",
                              x = "IQ Status", y = "Percent Change")
    } 
    return(subplot)
  })
  
  output$table3 <- renderTable({
    
    if (input$iq_status == "all") {
      filtered_df3 <- df_merged 
    } else  {
      filtered_df3 <- filter(df_merged, IQ_status == input$iq_status)
    }
  
    table_data3 <- filtered_df3 %>% 
      group_by(IQ_status) %>% 
      summarize(Minimum = min(per_change_students), Maximum = max(per_change_students),Median = median(per_change_students), IQR = IQR(per_change_students)) %>% 
      arrange(IQ_status)
    
    print(table_data3)
  })
}


# Run the Shiny app
shinyApp(ui, server)