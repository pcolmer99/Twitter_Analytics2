## This code reads the CSV file extracted from twitter analytics and 
##  calculates your most valueable tweets using the impressions and engagement
##  metrics.

## Paul Colmer 2016

## 2 hrs

## Must have Java installed to work as XLConnect and XLConnectJars are written in Java
## Installed Java V8 Update 71

## Setup Libraries

##Setup Working Directory
setwd("C:/Users/pcolmer/OneDrive for Business 1/R Studio/Twitter_Analytics2")

## Check to see the correct baseline file exists
x <- file.exists("tweet_activity_metrics_MusicComposer1.csv")
if(x == FALSE) {
  print("Metrics CSV File Missing or Incorrect Name: tweet_activity_metrics_MusicComposer1.csv")
  stop()
} else {
  print("Metrics CSV File GOOD")
  print("Press [enter] to continue")
  line <- readline()
}

## Load in the TWitter CSV file
mydata <- read.csv("tweet_activity_metrics_MusicComposer1.csv")

## Multiply impressions by engagements
new_data_engagements <- (mydata$retweets * 2) + (mydata$replies * 3) +
  (mydata$likes * 1) + (mydata$user.profile.clicks * 1.5) +
  (mydata$url.clicks * 1) + (mydata$hashtag.clicks * 1) +
  (mydata$detail.expands * 1) + (mydata$follows * 2) +
  (mydata$media.engagements * 1.5)
new_data <- mydata$impressions * new_data_engagements

## Add the new calculation as a column in the data
mydata <- cbind(mydata, new_data)

##  Sort the entire list using the new_data column
mydata_sorted <- mydata[order(-new_data),]

## Save data into the TWitter CSV file
write.csv(mydata_sorted, "Updated_TwitterAnalytics_MusicComposer1.csv")
