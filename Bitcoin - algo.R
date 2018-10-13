# Setup twitter R
require(twitteR)

requrl<-"https://api.twitter.com/oauth/request_token"
accessurl<-"https://api.twitter.com/oauth/access_token"
authurl<-"https://api.twitter.com/oauth/authorize"

apiKey<-"03Zte4KUac9Iky2sC47qL2Ac1"
apiSecret<-"JKgiZA90y0AccH5ZYy8neFcfZuBji2Dx9YDNEfFsiKpuv8uz8m"
access_token<-"1358864064-BMn1TCmqj30DXA41lnRBw2r2DftGdj3JhslSJxM"
access_token_secret<-"IRi2JChiXdaKcUS99TytxrpQ2xp6fUU5DTc15BahW7Ev6"

setup_twitter_oauth(apiKey,
                    apiSecret,
                    access_token,
                    access_token_secret)

# install.packages("twitteR")
query.string<-"#bitcoin"
number.of.tweets<-3200
language<-"en"
since<-"2018-10-13"
until<-"2018-10-10"

query.results<-searchTwitteR(query.string,
                             n=number.of.tweets,
                             lang=language,
                             since=since,
                             until=until)

#Inspect the resulting object
class(query.results)

#Extract items from a list
query.results[[1]]$text
query.results[[1]]$created

#install.packages("SentimentAnalysis")
require(SentimentAnalysis)

Harvard.IV<-loadDictionaryGI()

QDAP<-loadDictionaryQDAP()
str(QDAP)

x<-"this is a good resturant"
y<-"this resturant is neither good nor bad"

output<-analyzeSentiment(c(x,y))
View(output)

#create a data frame
query.results.df<-data.frame(
  tweet.date<-as.Date(character()),
  tweet.text<-as.character(),
  sentiment.score<-numeric(),
  stringsAsFactors = F
)



for (i in 1:length(query.results)){
  query.results.df[i,"tweet.date"]<-query.results[[i]]$created
  tweet.text<-iconv(query.results[[i]]$text,to="utf-8",sub="")
  query.results.df[i,"tweet.text"]<-tweet.text
  sentiment<-analyzeSentiment(tweet.text)
  query.results.df[i,"sentiment.score"]<-sentiment$SentimentGI
}

load("tweets.lufthansa.Rdata")
View(tweets.lufthansa)

# Format date column as date in format year-month-day
tweets.lufthansa$date<-as.Date(tweets.lufthansa$date,"%Y-%m-%d")

#Add new column for week
tweets.lufthansa$week<-format(tweets.lufthansa$date,"%y-%W")

plot(table(tweets.lufthansa$week))
View(tweets.lufthansa)

weeks<-sort(unique(tweets.lufthansa$week))
weeks
for (i in 1:length(tweets.lufthansa$week)){
  sentriment[i]
}
