# Lab 2 Script: Loading data and the grammar of graphics (ggplot2)
# The University of Texas at San Antonio
# URP-5393: Urban Planning Methods II


#---- Objectives ----
# In this Lab you will learn to:

# 1. Load datasets into your R session -> open the `Lab2_script.R` to go over in class.
# 2. Learn about the different ways `R` can plot information
# 3. Learn about the usage of the `ggplot2` package

#test
#---- Part 1: Loading data ----

# Data can be loaded in a variety of ways. As always is best to learn how to load using base functions that will likely remain in time so you can go back and retrace your steps. 
# This time we will load two data sets in three ways.


## ---- Part 1.1: Loading data from R pre-loaded packages ----

data() # shows all preloaded data available in R in the datasets package

help(package="datasets") #In the Help tab on the right side, this pulls up all the documentation for all of the datasets availabele in R.

#Let's us the Violent Crime Rates by US State data 

help("USArrests") #in the Help tab on the right side, this pulls up the documentations for the dataset of Violent Crime Rates by US State. This dataset is already available in R. 

# Step 1. Load the data in you session by creating an object

usa_arrests<-datasets::USArrests #The "datasets::"pulls the dataset "USAArrests" that is already available in R. With the "usa_arrests <-" we assigned that dataset to a new object with the name of "usa_arrests" in which we can look at that data. 

class(usa_arrests) #the class() function tells us what kind of object is within the parenthesis. In this case, its the data.frame that we had just made in the previous step. It's essentially a table of data with rows and columns.
names(usa_arrests) #the names() function tells us the names of the columns in the dataset/data.frame within the parenthesis. The names of the columns in the data.frame usa_arrests are "Murder", "Assault", "UrbanPop", and "Rape". 
dim(usa_arrests) #the dim() function gives us the dimensions of the dataset/data.frame in parenthesis. It tells us how many rows and how many columns there are. in this case, it returned the answer "50  4" because there are 50 rows and 4 columns.
head(usa_arrests) #the head() function shows the first 6 rows of data from the dataset/data.frame in parenthesis, in this case for the data.frame "usa_arrests". It gives us an idea of what the data in the dataset/data.frame looks like. 
tail(usa_arrests) #the tail() function shows the last 6 rows of data from the dataset/data.frame in parenthesis, in this case for the data.frame "usa_arrests". It gives us an idea of what the data in the dataset/data.frame looks like, especially at the end so we can have an idea without scrolling to the very bottom of the table. 

## ---- Part 1.2: Loading data from your computer directory ----
# We will use the Building Permits data from the city of San Antonio open data portal
# Source: https://data.sanantonio.gov/dataset/building-permits/resource/c21106f9-3ef5-4f3a-8604-f992b4db7512

building_permits_sa<-read.csv(file = "datasets/accelaissuedpermitsextract.csv",header = T) #in the Files tab to the right, we have the folder datasets which contains the csv file named "accelaissuedpermitsextract". The "file =" directs R to look for it in the Files tab, and the "datasets/" in the name tells it to look for it in that folder. The "read.csv()" allows us to load that data within the csv file and then we assigned that dataset to a new object with the name of "building_permits_sa" in which we can look at that data. Finally, with the "header = T" part, we have told R that the first row in the csv file contains all the column names. 

names(building_permits_sa) #the names() function tells us the names of the columns in the dataset/data.frame within the parenthesis. The names of the columns in the data.frame "building_permits_sa" are all listed in order in the console below. 

View(building_permits_sa) #the view() opens the dataset/data.frame within the parenthesis into a new tab. It's essentially the same thing as double-clicking on the data/frame in the Environment box. 

class(building_permits_sa) #the class() function tells us what kind of object is within the parenthesis. In this case, its the data.frame that we had just made in the previous step. It's essentially a table of data with rows and columns.

dim(building_permits_sa) #the dim() function gives us the dimensions of the dataset/data.frame in parenthesis. It tells us how many rows and how many columns there are. In this case, it returned the answer "5232  16" because there are 5232 rows and 16 columns.

str(building_permits_sa) #the str() function shows the structure of the object/data.frame within the parenthesis. It essentially shows us the class (it's a data.frame), the dimensions (5232 rows and 16 columns), and what kind of data is in each column - numeric, or character (text), or integers, or logical. Besides what kind of data, it also tells us the first few examples of actual data in each. 

summary(building_permits_sa) #the the summary () function provides a summary of the dataset/data.frame within the parenthesis. It shows the various columns and gives a quick summary of each - listing the number of rows, the class of the objects, and in some cases the mode or, for numeric values, the mean, median, and 1st and 3rd quartile info. 


## ---- Part 1.3: Loading data directly from the internet ----
# We will use the Building Permits data from the city of San Antonio open data portal
# Source: https://data.sanantonio.gov/dataset/building-permits/resource/c21106f9-3ef5-4f3a-8604-f992b4db7512

building_permits_sa2 <- read.csv("https://data.sanantonio.gov/dataset/05012dcb-ba1b-4ade-b5f3-7403bc7f52eb/resource/c21106f9-3ef5-4f3a-8604-f992b4db7512/download/accelaissuedpermitsextract.csv",header = T) #the "read.csv()" function allows us to load that data within the csv file identified within. In this case, we are pulling the csv file from a website and so we list the specific link needed to access it. We then assigned that dataset to a new object with the name of "building_permits_sa2" in which we can look at that data. Finally, with the "header = T" part, we have told R that the first row in the csv file contains all the column names. 




## ---- Part 1.4: Loading data using a package + API ----
#install.packages("tidycensus")
#install.packages("tigris")
help(package="tidycensus") #this displays in the Help tab all the documentation for the tidycensus package.
library(tidycensus) #the library() function loadas the package within into R. in this case, it is loading the "tidycensus" package which allows you to access data from the U.S. Census Bureau.
library(tigris) #the library() function loadas the package within into R. in this case, it is loading the "tigris" package which allows you to use US Census data in various ways.


#type ?census_api_key to get your Census API for full access.
?census_api_key

age10 <- get_decennial(geography = "state", 
                       variables = "P013001", 
                       year = 2010) #this created the data.frame called "age10" which retrieved data from the US Census Bureau by using  the "get_decennial()" function. We have specified that we want the data level of analysis to be at the state level, that the specific data we want to pull from the census is the one labelled "P013001", and that the specific census data we want is from the 2010 census. 

head(age10) #the head() function shows the first 6 rows of data from the dataset/data.frame in parenthesis, in this case for the data.frame "age10". It gives us an idea of what the data in the dataset/data.frame looks like. 


bexar_medincome <- get_acs(geography = "tract", variables = "B19013_001",
                           state = "TX", county = "Bexar", geometry = TRUE) #this created the data.frame called "bexar_medincome" which retrieved data from the American Community Survey (ACS) by using  the "get_acs()" function. We have specified that we want the data level of analysis to be at the census tract level, that the specific data we want to pull from the census is the one labelled "B19013_001", and that we want it specifically for the state of Texas and only the county of Bexar. The "geometry = True" means it should include the geometric data. 


View(bexar_medincome) #the view() opens the dataset/data.frame within the parenthesis into a new tab. It's essentially the same thing as double-clicking on the data/frame in the Environment box. 

class(bexar_medincome) #the class() function tells us what kind of object is within the parenthesis. In this case, it tells us "sf", meaning simple feature which is spatial or geographic data, and "data.frame" because its the data.frame that we had just made in the previous step. It's essentially a table of data with rows and columns.

#---- Part 2: Visualizing the data ----
#install.packages('ggplot2')

library(ggplot2)  #the library() function loads the package within into R. in this case, it is loading the "ggplot2" package which is used for visualizing data with different kinds of plots/graphs.



## ---- Part 2.1: Visualizing the 'usa_arrests' data ----

ggplot() #the ggplot () function is used to create a plot. in this case, the  plot tab opens on the right side but just displays a blank field because we did not specify any data within the parenthesis.

#scatter plot - relationship between two continuous variables
ggplot(data = usa_arrests,mapping = aes(x=Assault,y=Murder)) +
  geom_point() #this creates a plot by using the ggplot() function and specifically a scatter plot by using the geompoint() function. The data we are using is the "usa_arrests" data.frame that we created earlier. We have specified in the the "mapping = aes (x=Assault, y=Murder) that the column "Assault" should be plotted on the x-axis and the column "Murder" should be plotted on the y-axis. 

ggplot() +
  geom_point(data = usa_arrests,mapping = aes(x=Assault,y=Murder)) #this is exatly the same as above, in which we have created a scatter plot with the data from "usa_arrests" and plotting the column "Assault" should be plotted on the x-axis and the column "Murder" should be plotted on the y-axis. The only difference between this code and the previous one is the here we have specified the data and aesthetics of the scatter plot wihtin the geom_point() function instead of within the ggplot() function. 


#bar plot - compare levels across observations
usa_arrests$state<-rownames(usa_arrests) #in the data.frame "usa_arrests", this created a new column named "state" which has the name of each row in it. 

ggplot(data = usa_arrests,aes(x=state,y=Murder))+
  geom_bar(stat = 'identity') #the geom_bar() function combined with ggplot() creates a bar graph using the data.frame "usa_arrests" in which the x-axis is the "state" column (the new column we just made in the previous step) and the y-axis is set to the "Murder" column. We have specifice in stat= identity to use the number in the Murder y-axis for each bar.

ggplot(data = usa_arrests,aes(x=reorder(state,Murder),y=Murder))+
  geom_bar(stat = 'identity')+
  coord_flip() #this made a bargraph as in the previous step, but the coord_flip() made it a horizontal bar graph as opposed to vertical. The "x=reorder(state,Murder) means the y-axis should be organized based on the "Murder" column as opposed to the order in which it originally was (alhpabetical). 

# adding color # would murder arrests be related to the percentage of urban population in the state?
ggplot(data = usa_arrests,aes(x=reorder(state,Murder),y=Murder,fill=UrbanPop))+
  geom_bar(stat = 'identity')+
  coord_flip() #this has created the horizontal bar graph that was outlined above but now uses the a color scale is using the number in the "UrbanPop" column. The color of the bar is now lighter in color the higher the number in the "UrbanPop" color. 

# adding size
ggplot(data = usa_arrests,aes(x=Assault,y=Murder, size=UrbanPop)) +
  geom_point() #as we did a few lines of code previously, this creates a plot by using the ggplot() function and specifically a scatter plot by using the geompoint() function. The data we are using is the "usa_arrests" data.frame that we created earlier. We have specified in the the "mapping = aes (x=Assault, y=Murder) that the column "Assault" should be plotted on the x-axis and the column "Murder" should be plotted on the y-axis. Here, we have now directed R that the size of the dot is based on the number in the "UrbanPop" column. So the larger the number in the column, the larger the dot.


# plotting by south-east and everyone else 

usa_arrests$southeast<-as.numeric(usa_arrests$state%in%c("Florida","Georgia","Mississippi","Lousiana","South Carolina")) #we have created a new column in the "usa_arrests" data.frame by using the "$" and named the new column "southeast". We have then designated it to have the condition that it assign the number 1 (in other words a "1" if the condition is TRUE) only to those that have in the "state" column the specific names of "Florida","Georgia","Mississippi","Lousiana","South Carolina"


ggplot(data = usa_arrests,aes(x=Assault,y=Murder, size=UrbanPop, color=southeast)) +
  geom_point() #this creates a plot by using the ggplot() function and specifically a scatter plot by using the geompoint() function. The data we are using is the "usa_arrests" data.frame that we created earlier. We have specified in the the "mapping = aes (x=Assault, y=Murder) that the column "Assault" should be plotted on the x-axis and the column "Murder" should be plotted on the y-axis. Here, we have now directed R that the size of the dot is based on the number in the "UrbanPop" column. So the larger the number in the column, the larger the dot. We have now added one extra step that the color of the dot be based on the southeast column. As the states are either marked "1" if the are in the southeast or a "0" if they are not, all the states wil be one of two colors. 

usa_arrests$southeast<-factor(usa_arrests$southeast,levels = c(1,0),labels = c("South-east state",'other')) #in the "usa_arrests" data.frame, we have replaced  the numeric "1" or "0" in the "southeast" column to the factor variables "South-east" and "other" respectively. 

ggplot(data = usa_arrests,aes(x=Assault,y=Murder, size=UrbanPop)) +
  geom_point()+
  facet_wrap(southeast~ .) #this creates a scatter plot based on the data.frame "usa_arrests" in which the Assault column is plotted on the x-axis and the Murder column is plotted on the y-axis. Additionally, we specified that the size of the dot represent the number in the UrbanPop colum. However, the the "facet_wrap(southeast~ .)" function splits the plot into two plots based on the "southeast" column, meaning that if the state has "South-east state"  in that column, then it will be on the left plot while all the other states will be in the "other" column. 


ggplot(data = usa_arrests,aes(x=Assault,y=Murder, size=UrbanPop)) +
  geom_point()+
  facet_grid(southeast ~ .) #this creates a scatter plot based on the data.frame "usa_arrests" in which the Assault column is plotted on the x-axis and the Murder column is plotted on the y-axis. Additionally, we specified that the size of the dot represent the number in the UrbanPop colum. The "facet_grid(southeast ~ .)  splits the data into two plots based on the "southeast" column, but it specifically make it a row-oriented plot when compared with the previous example. 


## ---- Part 3: Visualizing the spatial data ----
# Administrative boundaries


library(leaflet)
library(tigris)

bexar_county <- counties(state = "TX",cb=T)
bexar_tracts<- tracts(state = "TX", county = "Bexar",cb=T)
bexar_blockgps <- block_groups(state = "TX", county = "Bexar",cb=T)
#bexar_blocks <- blocks(state = "TX", county = "Bexar") #takes lots of time


# incremental visualization (static)

ggplot()+
  geom_sf(data = bexar_county)

ggplot()+
  geom_sf(data = bexar_county[bexar_county$NAME=="Bexar",])

ggplot()+
  geom_sf(data = bexar_county[bexar_county$NAME=="Bexar",])+
  geom_sf(data = bexar_tracts)

p1<-ggplot()+
  geom_sf(data = bexar_county[bexar_county$NAME=="Bexar",],color='blue',fill=NA)+
  geom_sf(data = bexar_tracts,color='black',fill=NA)+
  geom_sf(data = bexar_blockgps,color='red',fill=NA)

ggsave(filename = "02_lab/plots/01_static_map.pdf",plot = p1) #saves the plot as a pdf



# incremental visualization (interactive)

#install.packages("mapview")
library(mapview)

mapview(bexar_county)

mapview(bexar_county[bexar_county$NAME=="Bexar",])+
  mapview(bexar_tracts)

mapview(bexar_county[bexar_county$NAME=="Bexar",])+
  mapview(bexar_tracts)+
  mapview(bexar_blockgps)


#another way to vizualize this
leaflet(bexar_county) %>%
  addTiles() %>%
  addPolygons()

names(table(bexar_county$NAME))

leaflet(bexar_county[bexar_county$NAME=="Bexar",]) %>%
  addTiles() %>%
  addPolygons()

leaflet(bexar_county[bexar_county$NAME=="Bexar",]) %>%
  addTiles() %>%
  addPolygons(group="county")%>%
  addPolygons(data=bexar_tracts,group="tracts") %>%
  addPolygons(data=bexar_blockgps,color = "#444444", weight = 1,group="block groups")

leaflet(bexar_county[bexar_county$NAME=="Bexar",]) %>%
  addTiles() %>%
  addPolygons(group="county")%>%
  addPolygons(data=bexar_tracts,group="tracts") %>%
  addPolygons(data=bexar_blockgps,color = "#444444", weight = 1,group="block groups") %>%
  addLayersControl(
    overlayGroups = c("county", "tracts","block groups"),
    options = layersControlOptions(collapsed = FALSE)
  )



