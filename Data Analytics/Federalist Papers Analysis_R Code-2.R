FedPapers <- read.csv("C:\\Users\\micha\\Documents\\IST707\\HW4 - fedPapers85.txt")

FedPapers

library(wordcloud)
library(proxy)
library(tidytext)
library(tm)
library(stringi)
library(Matrix)
library(factoextra)
library(plyr)
library(slam)
library(quanteda)
library(SnowballC)
library(arules)
library(cluster)
library(mclust)
library(ggplot2)
library(dplyr)

setwd("C:\\Users\\micha\\Documents\\IST707\\Fed Papers Zip")

CorpusPapers <- Corpus(DirSource("txt"))

CorpusPapers


(getTransformations())
## [1] "removeNumbers" "removePunctuation" "removeWords"
## [4] "stemDocument" "stripWhitespace"

(nCorpusPapers<-length(CorpusPapers))
## [1] 85



# set up some parameters around the papers to rule out very rare and very common words
### ignore extremely rare words i.e. terms that appear in less then 1% of the documents
#(MinFreq <- nCorpusPapers * 0.0003)
## [1] 0.0085
###Ignore overly common words i.e. terms that appear in more than 50% of the documents
#(MaxFreq <- nCorpusPapers * 1)



# create stop words to ignore
#(MyStopwords <- c("will","one","two", "may","less", "well","might","withou","small",
#"single", "several", "but", "very", "can", "must", "also", "any", "and", "are", 
#"however", "into", "almost", "can","for", "add" ))
#(STOPS <-stopwords('english'))

Papers_DTM <- DocumentTermMatrix(CorpusPapers,
                                 control = list(
                                   stopwords = FALSE,
                                   wordLengths=c(3, 15),
                                   removePunctuation = T,
                                   removeNumbers = T,
                                   tolower=T,
                                   stemming = T,
                                   remove_separators = T,
                                   #stopwords = MyStopwords,
                                   #removeWords(STOPS), # use the "built-in" STOP words
                                   #bounds = list(global = c(MinFreq, MaxFreq))
                                 ))

DTM <- as.matrix(Papers_DTM)
(DTM[1:11,1:10])

Disputed <- DTM[1:11,]
Hamilton <- DTM[12:62,]
HM <- DTM[63:65,]
Jay <- DTM[66:70,]
Madison <- DTM[70:85,]


WordFreq <- colSums(as.matrix(Papers_DTM))
(head(WordFreq))
(length(WordFreq))
ord <- order(WordFreq)
(WordFreq[head(ord)])
# these are the words that occur most frequently
(WordFreq[tail(ord)])

# attempt to barplot some of the most frequent words
barplot(WordFreq[tail(ord)])

# provides the 4900 most frequent words in the papers
Freq_Words<-findFreqTerms(Papers_DTM)

## Row Sums per Fed Papers
(Row_Sum_Per_doc <- rowSums((as.matrix(Papers_DTM))))

## Create a normalized version of Papers_DTM
Papers_M <- as.matrix(Papers_DTM)
Papers_M_N1 <- apply(Papers_M, 1, function(i) round(i/sum(i),3))
Papers_Matrix_Norm <- t(Papers_M_N1)
## Have a look at the original and the norm to make sure
(Papers_M[c(1:11),c(1000:1010)])
(Papers_Matrix_Norm[c(1:11),c(1000:1010)])
# upon is 4627
(Papers_Matrix_Norm[c(1:11),c(4620:4630)])


## From the line of code
(Row_Sum_Per_doc <- rowSums((as.matrix(PapersDTM))))
## above, we can see that dispt_fed_53.txt has a row sum of 1035
## So, we can confirm correctness. For word "curious" we should have
## 1/1035 = 0.001 rounded, which is what we have.

## Convert to matrix and view
Papers_dtm_matrix = as.matrix(Papers_DTM)
str(Papers_dtm_matrix)
(Papers_dtm_matrix[c(1:11),c(2:10)])

## Convert to a data frame
# creates 85 observations (for each article) for each word found of the 4900 words
Papers_DF <- as.data.frame(as.matrix(Papers_DTM))
str(Papers_DF)
(Papers_DF$abolit)
(nrow(Papers_DF)) ## Each row is Paper


#subset the papers in Disputed, Hamilton, Madison and Jay
#Disputed <- DTM[1:11,]
#Hamilton <- DTM[12:62,]
#HM <- DTM[63:65,]
#Jay <- DTM[66:70,]
#Madison <- DTM[70:85,]

str(Papers_dtm_matrix)
# start visualizations
#Wordcloud Visualization Hamilton, Madison and Disputed Papers
DisputedPapersWC<- wordcloud(colnames(Papers_dtm_matrix), Papers_dtm_matrix[1:11, ])
#(head(sort(as.matrix(Papers_DTM)[11,], decreasing = TRUE), n=50))
HamiltonPapersWC <- wordcloud(colnames(Papers_dtm_matrix), Papers_dtm_matrix[12:62, ])
HMPapersWC <- wordcloud(colnames(Papers_dtm_matrix), Papers_dtm_matrix[63:65,])
JayPapersWC <- wordcloud(colnames(Papers_dtm_matrix), Papers_dtm_matrix[66:70,])
MadisonPapersHW <- wordcloud(colnames(Papers_dtm_matrix), Papers_dtm_matrix[70:85, ])

# Analysis
# Distance Metrics
###Distance Measure
m <- Papers_dtm_matrix
m_norm <- Papers_Matrix_Norm
(m_norm[c(1:11),c(4626:4628)])


distCos

#m <- [1:2, 1:3]
distMatrix_E <- dist(m, method="euclidean")
print(distMatrix_E)
distMatrix_M <- dist(m, method="manhattan")
print(distMatrix_M)
distMatrix_C <- dist(m, method="cosine")
print(distMatrix_C)
distMatrix_C_norm <- dist(m_norm, method="cosine")
print(distMatrix_C_norm)
##Cosine similarity works the best. Norm and not norm is about
## the same because the size of the Papers are not sig diff.

##Clustering
##Below are some HAC results. Which does best??? Why?
###Clustering Methods:
## HAC: Hierarchical Algorithm Clustering Method
## Euclidean
groups_E <- hclust(distMatrix_E,method="ward.D")
plot(groups_E, cex=0.5, font=22, hang=-1, main = "HAC Cluster Dendrogram with Euclidean Similarity")
rect.hclust(groups_E, k=2)

# Clustering with Manhattan
groups_M <- hclust(distMatrix_M,method="ward.D")
plot(groups_M, cex=0.5, font=22, hang=-1, main = "HAC Cluster Dendrogram with Manhattan Similarity")
rect.hclust(groups_M, k=2)

## Cosine Similarity
groups_C <- hclust(distMatrix_C,method="ward.D")
plot(groups_C, cex=0.5,font=22, hang=-1,main = "HAC Cluster Dendrogram with Cosine Similarity")
rect.hclust(groups_C, k=2)

## Cosine Similarity for Normalized Matrix
groups_C_n <- hclust(distMatrix_C_norm,method="ward.D")
plot(groups_C_n, cex=0.5, font=22, hang=-1, main = "HAC Cluster Dendrogram with Cosine Similarity Normalized Matrix")
rect.hclust(groups_C_n, k=2)

# Determine number of clusters
X <- m_norm

wss <- (nrow(X)-1)*sum(apply(X,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(X,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

# K-Means Cluster Analysis
fit <- kmeans(X, 5) # 5 cluster solution
fit
# get cluster means
aggregate(X,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(X, fit$cluster) 


## k means clustering Methods
X <- m_norm
k2 <- kmeans(X, centers = 2, nstart = 100, iter.max = 50)
str(k2)

k3 <- kmeans(X, centers = 8, nstart = 50, iter.max= 50)
str(k3)

# print the centroids
k3$centers
cluster_assignment <- data.frame(X, k3$cluster)
View(cluster_assignment)
cluster_assignment

## k means visualization results!
distance1 <- get_dist(X,method = "manhattan")
fviz_dist(distance1, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
distance2 <- get_dist(X,method = "euclidean")
fviz_dist(distance2, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
distance3 <- get_dist(X,method = "spearman")
fviz_dist(distance3, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07", title= "Distance Matrix Visualization, Spearman Method"))
str(X)


# visualize
#plot(X$type ~ jitter(model_r$cluster, 1), pch=21, col=as.factor(zooDF$milk))
#
#clusplot(unlabel_zooDF, model_r$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)clusplot(unlabel_zooDF, model_r$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

## k means
kmeansFIT_1 <- kmeans(X, centers = 4)
#(kmeansFIT1)
summary(kmeansFIT_1)

#(kmeansFIT_1$cluster)
#fviz_cluster(kmeansFIT_1, data = X)
kmeansFIT_2 <- kmeans(X, centers = 3)
#(kmeansFIT2)
summary(kmeansFIT_2)

(kmeansFIT_2$cluster)
#fviz_cluster(kmeansFIT_2, data = X)