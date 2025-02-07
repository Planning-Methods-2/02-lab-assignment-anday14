# Lab 2 Assignment: Loading data and the grammar of graphics (ggplot2)
# The University of Texas at San Antonio
# URP-5393: Urban Planning Methods II


#---- Instructions ----

# 1. [40 points] Open the R file "Lab2_Script.R" comment each line of code with its purpose (with exception of Part 3)
# 2. [60 points] Open the R file "Lab2_Assignment.R" and answer the questions

#---- Q1. write the code to load the dataset "tract_covariates.csv" located under the "datasets" folder in your repository. Create an object called `opportunities` Use the data.table package to do this. ----

library(data.table)

opportunities<-fread(file = "datasets/tract_covariates.csv",header = T)



#---- Q2. On your browser, read and become familiar with the dataset metadata. Next write the code for the following:
# Link to metadata: https://opportunityinsights.org/wp-content/uploads/2019/07/Codebook-for-Table-9.pdf 



# what is the object class?
class(opportunities)
#it's a data.table and data.frame

# how can I know the variable names?

names(opportunities)

# What is the unit of analysis? 

str(opportunities) #the unit of analysis is the census tract

# Use the `summary` function to describe the data. What is the variable that provides more interest to you?

summary(opportunities) #the data is in 38 variables, mostly numeric values. the job_density_2013 variable is the most interesting to me, as it shows just how rural some parts of the country really are, and yet the mean is 2152.8 jobs per square mile in each tract. This shows the relative urbanity of the country (and that was 2013) 


# Create a new object called `sa_opportunities` that only contains the rows for the San Antonio area (hint: use the `czname` variable). 


sa_opportunities <- opportunities[opportunities$czname=="San Antonio",]




# Create a plot that shows the ranking of the top 10 census tracts by Annualized job growth rate (`ann_avg_job_growth_2004_2013` variable) by census tract (tract variable). Save the resulting plot as a pdf with the name 'githubusername_p1.pdf' # Hint: for ordering you could use the `setorderv()` or reorder() functions, and the ggsave() function to export the plot to pdf. 


library(data.table)
library(ggplot2)


Top_10_Tracts <- as.data.table(opportunities)

setorderv(Top_10_Tracts, "ann_avg_job_growth_2004_2013")

Top_10_Tracts <- tail(Top_10_Tracts, 10)

ggplot(data = Top_10_Tracts, mapping = aes(x= tract, y= ann_avg_job_growth_2004_2013)) +
  geom_point()

ggsave(filename ="Top_10_Ranking_Plot.pdf", )


# Create a plot that shows the relation between the `frac_coll_plus` and the `hhinc_mean2000` variables, what can you hypothesize from this relation? what is the causality direction? Save the resulting plot as a pdf with the name 'githubusername_p3.pdf'


ggplot(data = opportunities,aes(x= frac_coll_plus2000,y=hhinc_mean2000))+
  geom_point()

ggsave(filename ="githubusername_p3.pdf", )

#this scatter plot clearly shows the relationship between the percentage of the population with a college degree and the mean household income per census tract. The higher the percentage of people with university degrees, the higher the mean household income is in that census tract. The causality direction is clear skewed in the direction of university degrees.





# Investigate (on the internet) how to add a title,a subtitle and a caption to your last plot. Create a new plot with that and save it as 'githubusername_p_extra.pdf'


ggplot(data = opportunities,aes(x= frac_coll_plus2000,y=hhinc_mean2000))+
  geom_point() +
  labs(  title = "Relationship between University Degrees and Household Income",
         subtitle = "Data from the year 2000" ,
         caption = "Table 9: Neighborhood Characteristics by Census Tract"
  ) +
  theme(
    plot.title = element_text(size = 6),  
    plot.subtitle = element_text(size = 8),  
    plot.caption = element_text(size = 8) 
  )

ggsave(filename ="githubusername_p_extra.pdf",)

