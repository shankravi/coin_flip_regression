library(caret) #http://topepo.github.io/caret/index.html
library(data.table)
library(Metrics)

set.seed(77)

setwd("C:/Users/Shashank/Desktop/Personal Data/Penn State/Classes/Semester 8/Stat 380/coin_flip-project2/coin_flip")
train<-fread('./project/volume/data/raw/train_file.csv')
test<-fread('./project/volume/data/raw/test_file.csv')

train_y<-train$result
test$result = 0.5
test_y<-test$result


dummies <- dummyVars(result~V1+V2+V3+V4+V5+V6+V7+V8+V9+V10, data = train)
train<-predict(dummies, newdata = train)
test<-predict(dummies, newdata = test)

#train = group_by(train[,.(id,V1,V2,V3,V4,V5,V6,V7,V8,V9,V10)])
#test =group_by(test[,.(id,V1,V2,V3,V4,V5,V6,V7,V8,V9,V10)])

#reformat after dummyVars and add back response Var

train<-data.table(train)
train$result<-train_y
test<-data.table(test)


#fit a linear model
glm_model<-glm(result~V1+V2+V3+V4+V5+V6+V7+V8+V9+V10,family=binomial,data=train)


#assess model
summary(glm_model)

coef(glm_model)

#save model
saveRDS(dummies,"./project/volume/models/coin_result_lm.dummies")
saveRDS(glm_model,"./project/volume/models/coin_lm.model")

test$result<-predict(glm_model,newdata = test,type="response")

#our file needs to follow the example submission file format. So we need to only have the Id and saleprice column and
#we also need the rows to be in the correct order

submit<-test[,.(id,result)]

#now we can write out a submission
fwrite(submit,"./project/volume/data/processed/submit_glm.csv")
mean(ll(test_y,test$result))