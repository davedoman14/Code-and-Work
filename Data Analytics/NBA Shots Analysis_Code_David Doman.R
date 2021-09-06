NBAshots <- read.csv("C:\\Users\\micha\\Documents\\IST707\\NBAshots8302020.csv")

set.seed(1234)
sl_split<- createDataPartition(NBAshots$SHOT_RESULT, p=.75, list=F) 

training<- NBAshots[sl_split, ]
testing<- NBAshots[-sl_split, ]

set.seed(1234)


rpmodelShotResulta <- rpart(SHOT_RESULT ~ shotclockbucket + SHOT_DISTkbucket +	CLOSE_DEF_DISTkbucket + zoneRange, data=training,
                            control=rpart.control(minsplit=1, minbucket=1, cp=0.001, xval = 10),parms=list(split="gini"))
printcp(rpmodelShotResulta)
plotcp(rpmodelShotResulta)

fancyRpartPlot(rpmodelShotResulta)

rpresultsShotResultb <- rpart.predict(rpmodelShotResulta, newdata=testing, type=c("class"))

# Confusion Matrix
rpconfMat= table(rpresultsShotResultb, testing$SHOT_RESULT)
addmargins(rpconfMat)
rpaccuracy <- sum(diag(rpconfMat))/sum(rpconfMat)
rpaccuracy
t.error= 1-rpaccuracy
t.error
summary(rpresultsShotResultb)
summary(rpmodelShotResulta)
# Plots
rpart.plot::rpart.plot(rpmodelShotResulta,1)
rpart.plot::rpart.plot(rpmodelShotResulta)






rpmodelShotResult <- rpart(SHOT_RESULT ~ LOCATION + PERIOD + shotclock + DRIBBLES + 
                             TOUCH_TIME + SHOT_DIST + CLOSE_DEF_DIST + zoneRange, data=training,
                           control=rpart.control(minsplit=1, minbucket=1, cp=0.001, xval = 10),parms=list(split="gini"))
printcp(rpmodelShotResult)
plotcp(rpmodelShotResult)

fancyRpartPlot(rpmodelShotResult)


rpresultsShotResult2 <- rpart.predict(rpmodelShotResult, newdata=testing, type=c("class"))

# Confusion Matrix
rpconfMat= table(rpresultsShotResult2, testing$SHOT_RESULT)
addmargins(rpconfMat)
rpaccuracy <- sum(diag(rpconfMat))/sum(rpconfMat)
rpaccuracy
t.error= 1-rpaccuracy
t.error
summary(rpresultsShotResult2)
summary(rpmodelShotResult)
# Plots
rpart.plot::rpart.plot(rpmodelShotResult,1)
rpart.plot::rpart.plot(rpmodelShotResult)





rpmodelWinLoss <- rpart(W ~ LOCATION + opponent, data=training,
                        control=rpart.control(minsplit=1, minbucket=1, cp=0.001, xval = 10),parms=list(split="gini"))
printcp(rpmodelWinLoss)
plotcp(rpmodelWinLoss)

fancyRpartPlot(rpmodelWinLoss)


rpresultsWinLoss <- rpart.predict(rpmodelWinLoss, newdata=testing, type=c("class"))
# Confusion Matrix
rpconfMat= table(rpresultsWinLoss, testing$W)
addmargins(rpconfMat)
rpaccuracy <- sum(diag(rpconfMat))/sum(rpconfMat)
rpaccuracy
t.error= 1-rpaccuracy
t.error
summary(rpresultsWinLoss)
summary(rpmodelWinLoss)
# Plots
rpart.plot::rpart.plot(rpmodelWinLoss,1)
rpart.plot::rpart.plot(rpmodelWinLoss)