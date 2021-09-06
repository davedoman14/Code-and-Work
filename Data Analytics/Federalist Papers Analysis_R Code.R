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
install.packages("cluster")
library(cluster)


setwd("C:\\Users\\micha\\Documents\\IST707\\Fed Papers Zip")

CorpusPapers <- Corpus(DirSource("txt"))

CorpusPapers


(getTransformations())


(nCorpusPapers<-length(CorpusPapers))



(MinFreq <- nCorpusPapers * 0.0001)

(MaxFreq <- nCorpusPapers * 1)



(MyStopwords <- c("will","one","two", "may","less", "well","might","withou","small",
                  "single", "several", "but", "very", "can", "must", "also", "any", 
                  "however", "into", "almost", "can","for", "add" ))
(STOPS <-stopwords('english'))

Papers_DTMM <- DocumentTermMatrix(CorpusPapers,
                                 control = list(
                                   stopwords = TRUE,
                                   wordLengths=c(3, 13),
                                   removePunctuation = T,
                                   removeNumbers = T,
                                   tolower=T,
                                   stemming = T,
                                   remove_separators = T,
                                   stopwords = MyStopwords,
                                   bounds = list(global = c(MinFreq, MaxFreq))
                                 ))

DTMatrix <- as.matrix(Papers_DTMM)
(DTMatrix[1:11,1:10])
DTMatrix
Papers_DTMM
Unknown <- DTMatrix[1:11,]
Hamilton <- DTMatrix[12:62,]
HamiltonMadison <- DTMatrix[63:65,]
Jay <- DTMatrix[66:70,]
Madison <- DTMatrix[70:85,]


wordFrequency <- colSums(as.matrix(Papers_DTMM))
(head(wordFrequency))
(length(wordFrequency))
ord <- order(wordFrequency)
(wordFrequency[head(ord)])

(wordFrequency[tail(ord)])


barplot(wordFrequency[tail(ord)])


MostFrequent<-findFreqTerms(Papers_DTMM)


(RowSum <- rowSums((as.matrix(Papers_DTMM))))

Papers
Papers <- as.matrix(Papers_DTMM)
Papers1 <- apply(Papers, 1, function(i) round(i/sum(i),3))
NormalizedPapers <- t(Papers1)

(Papers[c(1:11),c(1000:1010)])
(NormalizedPapers[c(1:11),c(1000:1010)])

(NormalizedPapers[c(1:11),c(4500:4510)])



(RowSum <- rowSums((as.matrix(Papers_DTMM))))



DTMMMatrix = as.matrix(Papers_DTMM)
str(DTMMMatrix)
(DTMMMatrix[c(1:11),c(2:10)])


DFPapers <- as.data.frame(as.matrix(Papers_DTMM))
str(DFPapers)
(DFPapers$abolit)
(nrow(DFPapers)) 
DFPapers


DTMMMatrix
str(DTMMMatrix)

UnknownPaperswordcloud<- wordcloud(colnames(DTMMMatrix), DTMMMatrix[1:11, ])

HamiltonPaperswordcloud <- wordcloud(colnames(DTMMMatrix), DTMMMatrix[12:62, ])
HamiltonMadisonPaperswordcloud <- wordcloud(colnames(DTMMMatrix), DTMMMatrix[63:65,])
JayPaperswordcloud <- wordcloud(colnames(DTMMMatrix), DTMMMatrix[66:70,])
MadisonPaperswordcloud <- wordcloud(colnames(DTMMMatrix), DTMMMatrix[70:85, ])


D <- DTMMMatrix
Dnorm <- NormalizedPapers
(Dnorm[c(1:11),c(4615:4628)])



distMatrixEuclidean <- dist(D, method="euclidean")
print(distMatrixEuclidean)
distMatrixManhattan <- dist(D, method="manhattan")
print(distMatrixManhattan)
distMatrixCosine <- dist(D, method="cosine")
print(distMatrixCosine)
distMatrixNormalizedCosine <- dist(Dnorm, method="cosine")
print(distMatrixNormalizedCosine)

distance1 <- get_dist(X,method = "euclidean")
fviz_dist(distance1, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
distance2 <- get_dist(X,method = "manhattan")
fviz_dist(distance2, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

EuclideanDendrogram <- hclust(distMatrixEuclidean,method="ward.D")
plot(EuclideanDendrogram, cex=0.5, font=24, hang=-1, main = "HAC Cluster Dendrogram - Euclidean Similarity")
rect.hclust(EuclideanDendrogram, k=2)


ManhattanDendrogram <- hclust(distMatrixManhattan,method="ward.D")
plot(ManhattanDendrogram, cex=0.5, font=22, hang=-1, main = "HAC Cluster Dendrogram - Manhattan Similarity")
rect.hclust(ManhattanDendrogram, k=2)


CosineDendrogram <- hclust(distMatrixCosine,method="ward.D")
plot(CosineDendrogram, cex=0.5,font=22, hang=-1,main = "HAC Cluster Dendrogram - Cosine Similarity")
rect.hclust(CosineDendrogram, k=2)


NormalizedCosineDendrogram <- hclust(distMatrixNormalizedCosine,method="ward.D")
plot(NormalizedCosineDendrogram, cex=0.5, font=22, hang=-1, main = "HAC Cluster Dendrogram - Cosine Similarity Normalized Matrix")
rect.hclust(NormalizedCosineDendrogram, k=2)


X <- Dnorm
Dnorm
sse <- (nrow(X)-1)*sum(apply(X,2,var))
for (i in 2:15) sse[i] <- sum(kmeans(X,
                                     centers=i)$withinss)
plot(1:15, sse, type="b", xlab="Number of Clusters",
     ylab="Sum of Squares")



kmeansFIT1<-kmeans(X,3)
(kmeansFIT1$cluster)
kmeansTable<-table(rownames(NormalizedPapers),kmeansFIT1$cluster)
kmeansTable


