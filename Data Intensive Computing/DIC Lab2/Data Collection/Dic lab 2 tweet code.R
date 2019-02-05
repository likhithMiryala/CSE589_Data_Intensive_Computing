###########################################################################
## M Likhith Kumar 
## Created: March 27
###########################################################################
setwd("/Users/bunny/Desktop")  #setting current work directory

library(twitteR)
library(maptools)
library(ggmap)
library(stringr)


setup_twitter_oauth("5hEQ0vaM78DV6yWgnPTuxhgyJ", "MY0rER6QasTfFmhgDNXvc7Kc4tu9xdOkVBWoFZP6xHxDkr4h4Y", "127494066-zYIAyfFga5jYBeWxra2wsmImVUR8PlTcwDnDH4NJ", "HEy4C1fE77vnKHVsO7owv6N33MlvKAUfyI2gtJISkxz0x")

tweets1 <- searchTwitter('WhiteHouse', n=50)

tweets_strip1 <- strip_retweets(tweets1, strip_manual = TRUE, strip_mt = TRUE)
tweets_strip_df1 <- twListToDF(tweets_strip1)

dim(tweets_strip_df1)
#tweets_df<-rbind(tweets_strip_df,tweets_strip_df1)

write.csv(tweets_strip_df1$text, "apr_8_whiteh.txt")

clean_tweet = gsub("&amp", "",tweets_df$text )
clean_tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweets_df$text)
clean_tweet = gsub("@\\w+", "", tweets_df$text)
clean_tweet = gsub("[[:punct:]]", "", tweets_df$text)
clean_tweet = gsub("[[:digit:]]", "", tweets_df$text)
clean_tweet = gsub("http\\w+", "", tweets_df$text)
clean_tweet = gsub("[ \t]{2,}", "", tweets_df$text)
clean_tweet = gsub("^\\s+|\\s+$", "", tweets_df$text)
clean_tweet=gsub(" ?(f|ht)tp(s?)://(.*)[.][a-z]+", "", tweets_df$text)

#get rid of unnecessary spaces
clean_tweet <- str_replace_all(clean_tweet," "," ")
# Take out retweet header, there is only one
clean_tweet <- str_replace(clean_tweet,"RT @[a-z,A-Z]*: ","")
# Get rid of hashtags
clean_tweet <- str_replace_all(clean_tweet,"#[a-z,A-Z]*","")
# Get rid of references to other screennames
clean_tweet <- str_replace_all(clean_tweet,"@[a-z,A-Z]*","")

clean_tweet<-data.frame(clean_tweet)

clean_tweet<-clean_tweet[,c(1)]

head(clean_tweet,1)

write.csv(clean_tweet,"final_r_data.txt",row.names=F)
