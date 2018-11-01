library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
ckey = "mhfp2d8QvWuWNyoUG3n0pANj5"
skey = "q4lNn1AdfIYkByVXfTc6PxBxIcrdOcNKBdrxX6TdSczaYctLGM"
token = "1960454954-3b67ccv2ciB5V4x9jJ5FXo8BZsBafUNusdu52JE"
stoken ="M76ziZfDvdq2zDX9wYJ6p0jNkDHXcYKdinfy80UlY60mD"
setup_twitter_oauth(ckey, skey, token, stoken)
election.tweets <- searchTwitter('telanganaelections', n = 1000, lang = 'en')
election.text <- sapply(election.tweets, function(x) x$getText())
election.text <- iconv(election.text, 'UTF-8', 'ASCII')
election.corpus <- Corpus(VectorSource(election.text))
term.doc.matrix <- TermDocumentMatrix(election.corpus, control = list(removePunctuation= TRUE, 
                                                                      stopwords =c('elections', "telangana", 'https', stopwords('english')),
                                                                      removeNumbers= TRUE,
                                                                      tolower= TRUE))
term.doc.matrix <- as.matrix(term.doc.matrix)

word.freq <- sort(rowSums(term.doc.matrix), decreasing = T)
dm <- data.frame(word = names(word.freq), freq= word.freq)

wordcloud(dm$word, dm$freq, random.order = FALSE, colors = brewer.pal(8, 'Dark2'))
