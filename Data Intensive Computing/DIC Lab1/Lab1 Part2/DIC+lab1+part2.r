###########################################################################
## M Likhith Kumar
## Partner: Rahul Mallu
## Created: mar 02,2018
###########################################################################



setwd('C:/Users/bunny/Desktop/DIC') ### setting current directory

library(ggplot2)
library(reshape2)
library(scales)
library(ggmap)
library(maptools)

####################################################################################################################################

cdc1<-read.csv('C:/Users/bunny/Desktop/DIC/Influenza national summary yellow green graph.CSV')  # choosing file

total<-melt(data = cdc1, id.vars = "Week", measure.vars = c("Total.A", "Total.B")) 
# melting into a data frame which has only three variables
# it has redundant values of week 
total

df1<-subset(cdc1,select=c('Percent.Positive.A','Percent.Positive.B','Total.Tested','Percent.Positive'))
# creating datframe with only these columns

df2<-subset(cdc1,select=c('Percent.Positive.A','Percent.Positive.B','Total.Tested','Percent.Positive'))
# Create the same dataframe again

df3<-rbind(df1,df2)
# Add those dataframe vertically so every column has redundant values

df4<-cbind(total,df3) # combines two dataframes by adding every column into df4

df4$Week <- factor(as.factor(df4$Week))

p<-ggplot(data=df4, aes(Week)) +
  geom_bar(aes(y=value,fill=variable),stat="identity")+ xlab("WEEK") + ylab("Number of positive specimen")+
theme(axis.text.x = element_text(angle = 90, hjust = 1))+
 ggtitle("Influenza positive tests reported to CDC by U.S clinical Laboratories,National Summary, 2017-2018 Season")+
scale_fill_manual(values=c('yellow','darkgreen'))+
    geom_line(aes(y=Percent.Positive.A*700,group=1,colour="yellow"),linetype = "dashed")+
    geom_line(aes(y=Percent.Positive.B*700,group=1,colour="darkgreen"),linetype = "dashed")+
    geom_line(aes(y=Percent.Positive*700,group=1,colour="black"))+
    scale_y_continuous(sec.axis = sec_axis(~./700, name = "Percent.Positive"))+
    scale_color_discrete(name = "", labels = c("Percent Positive", "% Positive flu B","% Positive flu  A"))+theme_minimal()

p

##############################################################################################################################

cdc2<-read.csv("C:/Users/bunny/Desktop/DIC/positive_2 7 colors graph.CSV")

#cdc2

cdc2 <- setNames(cdc2, c("Week","H3N2v","AH1N1pdm09","AH3","A(unabletosubtype)","A(subtypingnf)","B(lineagenf)","BVIC","BYAM","posit"))

total5<-melt(data = cdc2, id.vars = "Week", measure.vars = c("A(subtypingnf)","AH1N1pdm09", "AH3","H3N2v","B(lineagenf)", "BVIC","BYAM")) 

total5$Week <- factor(as.factor(total5$Week))

ggplot(data=total5, aes(Week)) +
  geom_bar(aes(y=value,fill=variable),stat="identity")+ xlab("WEEK") + ylab("Number of positive specimens")+ 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
 ggtitle("Influenza positive tests reported to CDC by U.S clinical Laboratories,National Summary, 2017-2018 Season")+
scale_fill_manual(values=c('yellow','orange','red','violet','darkgreen','lightgreen','green'))

###############################################################################################################################

ageseason<-read.csv("C:/Users/bunny/Desktop/DIC/2_2 age view by season.CSV")

colnames(ageseason)

influage2<-melt(data = ageseason, id.vars = "Age.Group", measure.vars = c("A..H1N1.pdm09", "A..H3.","B..Lineage.Unspecified.","B..Victoria.Lineage.","B..Yamagata.Lineage."))

ggplot() +
  geom_bar(data=influage2, aes(x=variable,y=value/sum(value),fill=Age.Group),position="fill",stat="identity",width=0.6)+
  coord_flip()+xlab("")+ylab("")+
 # geom_text(size = 10, position = position_stack(vjust = 0.5))+
  #geom_text(aes(label = value))+
  ggtitle("Influenza positive tests reported to CDC by U.S Public Health Laboratories,\n Age Groups by Type and Subtype, 2017-2018 Season")+
scale_fill_manual(values=c('0-4 yr'='darkgreen','5-24 yr'='blue','25-64 yr'='darkblue','65+ yr'='Purple'),breaks=c('0-4 yr','5-24 yr','25-64 yr','65+ yr'))+
theme(plot.title = element_text(size = 12, face = "bold"))+ 
scale_y_continuous(labels=percent)


##################################################################################################################################
Death_week<-read.csv("C:/Users/bunny/Desktop/DIC/stacked bar_5 graph green.CSV")

mix_death<-melt(data = Death_week, id.vars = "WEEK.NUMBER", measure.vars = c("CURRENT.WEEK.DEATHS", "PREVIOUS.WEEKS.DEATHS"))

mix_death$WEEK.NUMBER<-factor(mix_death$WEEK.NUMBER)

a<-aggregate(Death_week$PREVIOUS.WEEKS.DEATHS, by=list(SEASON=Death_week$SEASON), FUN=sum)

num<- as.vector(a['x'])

typeof(num)
num[[1]][1]

options(repr.plot.width=30, repr.plot.height=8)
ggplot(data=Death_week) + 
  geom_bar(data=mix_death,aes(x=WEEK.NUMBER,y=value,fill=mix_death$variable),stat="identity") + ylab("Number Of deaths")+xlab("Week of death")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
ggtitle("Number of Influenza-Associated Pediatric deaths by Week of Death: 2014-2015 season to present")+
  scale_fill_manual(values=c('skyblue','darkgreen'))+
  theme(plot.title = element_text(size = 10, face = "bold"))+
  annotate("text", label = paste("2014-2015 Number of deaths",num[[1]][1]), x = 19.5, y = 20, color = "black")+
  annotate("text", label = paste("2015-2016 Number of deaths",num[[1]][2]), x = 74.5, y = 20, color = "black")+
  annotate("text", label = paste("2016-2017 Number of deaths",num[[1]][3]), x = 128, y = 20, color = "black")+
  annotate("text", label = paste("2017-2018 Number of deaths",num[[1]][4]), x = 170, y = 20, color = "black")



###################################################################################################################################
heat<-read.csv("C:/Users/bunny/Desktop/DIC/StateDataforMap_2017-18week7 heatmap.CSV")


heat_sub<-subset(heat , select=c("STATENAME","ACTIVITY.LEVEL","ACTIVITY.LEVEL.LABEL"))

colnames(heat)
heat$STATENAME<-tolower(heat$STATENAME)

heat$ACTIVITY.LEVEL<-substr(heat$ACTIVITY.LEVEL,6,9)
#map.df$ACTIVITY.LEVEL<-substr(map.df$ACTIVITY.LEVEL,6,9)

states <- map_data("state")
heat1<-heat
heat1$STATENAME<-tolower(heat1$STATENAME)

colnames(states)

#heat_sub$region<-tolower(heat_sub$STATENAME)
#map.df<-merge(states,heat_sub,by='region',all.heat_sub=T)
#map.df <- map.df[order(map.df$order),]

options(repr.plot.width=15, repr.plot.height=8)

heat$ACTIVITY.LEVEL<-as.character(as.numeric(heat$ACTIVITY.LEVEL)+81)

ggplot(data=states,aes(map_id=region)) + 
geom_map(data=heat,colour="purple",map=states,aes(fill=ACTIVITY.LEVEL,map_id=STATENAME))+
scale_fill_manual(labels=c('minimal','minimal','minimal','Low','Low','Moderate','Moderate','High','High','High'),
                    values=c("green4","green3","green2","green","yellow","yellow2","yellow3","orange","red2","red3","FireBrick")) +
  expand_limits(x = states$long, y = states$lat)


