setwd("D:/Data Science/Dr Vinod online classes/Class 6-Text Mining/TM190519")
getwd()
readLines('periyar.txt')


# paste function and collapse

a <- c('Hello','World','my','fist','handshake','through','R')
a
b <- paste(a,collapse = ' ')#withgap
b
c <- paste(a,collapse='')  #withoutgap
c

#read
chunk_2 <- readLines('periyar.txt')

chunk_pasted_2 <-paste(chunk_2,collapse=' ')
head(chunk_pasted_2)

#----cleaning data-----
clean_data1 <- tolower(chunk_pasted_2)
head(clean_data1)

clean_data2 <- gsub(pattern = '\\W',replacement = ' ', clean_data1)#capital W is must, small is for without text.
head(clean_data2)

clean_data3 <- gsub(pattern = '\\d',replacement = ' ',clean_data2)
head(clean_data3)

library(tm)
stopwords()

clean_data4 <- removeWords(clean_data3,stopwords())
head(clean_data4)
head(clean_data2)

clean_data5 <- gsub(pattern='\\b[A-z]\\b{1}', replacement = '',clean_data4)
clean_data5

clean_data6 <- stripWhitespace(clean_data5)
head(clean_data6)

clean_data7 <- strsplit(clean_data6,' ')
head(clean_data7)

word_freq1 <- table(clean_data7)
head(word_freq1)
word_freq2 <- cbind(names(word_freq1),as.integer(word_freq1))
head(word_freq2)

write.csv(word_freq2,"WordFrequncyperiyar.csv")


#----Wordcloud----

library(RColorBrewer)
library(wordcloud)
library(wordcloud2)

class(clean_data7)

unlist_data <- unlist(clean_data7)

#wordcloud(unlist_data)
#wordcloud(unlist_data,min.freq = 3)
#wordcloud(unlist_data,min.freq = 3,random.order = F)
#wordcloud(unlist_data,min.freq = 2,random.order = T,scale = c(2,.1))
?brewer.pal
?wordcloud
wordcloud(unlist_data,min.freq = 10,random.order = F,scale = c(4,.25),rot.per = .5,
          colors = brewer.pal(6,'Set1'))


head(w)
f <- read.csv('D:/Data Science/Dr Vinod online classes/Class 6-Text Mining/TM190519/WordFrequncyperiyar.csv')
str(f)
head(f)
f15 <- subset(f,V2>15)
f15 <- f15[,-1]
str(f15)
head(f15)

set.seed(123)
wordcloud2(f15,size = 0.3,shape='circle')
letterCloud(data=f15,'A')

#----sentiment analysis----
#getting bags of positive and negative words

positive <- scan('positive.txt',
                 what = 'character',
                 comment.char = ';')
head(positive)

negative <- scan('negative.txt',
                 what = 'character',
                 comment.char = ';')
head(negative)

#sent analysis

unlist_data <- unlist(clean_data7)

match(unlist_data,positive)
match(unlist_data,negative)

p_score <- sum(!(is.na(match(unlist_data,positive))))
p_score              


n_score <- sum(!(is.na(match(unlist_data,negative))))
n_score 

sent_score <- p_score - n_score
sent_score
