
UniversalBank <- 
  read.table("C:/Users/micha/Documents/SCM 651/Homework 4 Data Set - Universal Bank.csv",
   header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
names(UniversalBank)
scatterplot(PersonalLoan~Income, regLine=FALSE, smooth=FALSE, 
  boxplots=FALSE, data=UniversalBank)
GLM.1 <- glm(PersonalLoan ~ Age + Income + Family + CCAvg, 
  family=binomial(logit), data=UniversalBank)
summary(GLM.1)
exp(coef(GLM.1))  # Exponentiated coefficients ("odds ratios")
cor(UniversalBank[,c("Age","CCAvg","CDAccount","CreditCard","CustomerID",
  "Education","Experience","Family","Income","Mortgage","Online",
  "PersonalLoan","SecuritiesAccount","ZIP.Code")], use="complete")
vif(GLM.1)
round(cov2cor(vcov(GLM.1)), 3) # Correlations of parameter estimates
vif(GLM.1)
round(cov2cor(vcov(GLM.1)), 3) # Correlations of parameter estimates
GLM.2 <- glm(PersonalLoan ~ Age + CCAvg + CDAccount + CreditCard + CustomerID + Education + Experience + Family + Income + Mortgage + Online + SecuritiesAccount + ZIP.Code, 
  family=binomial(logit), data=UniversalBank)
summary(GLM.2)
exp(coef(GLM.2))  # Exponentiated coefficients ("odds ratios")
GLM.3 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Experience + Family + Income + Mortgage + Online + SecuritiesAccount + ZIP.Code, 
  family=binomial(logit), data=UniversalBank)
summary(GLM.3)
exp(coef(GLM.3))  # Exponentiated coefficients ("odds ratios")
GLM.4 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Experience + Family + Income + Online + SecuritiesAccount, family=binomial(logit), 
  data=UniversalBank)
summary(GLM.4)
exp(coef(GLM.4))  # Exponentiated coefficients ("odds ratios")
GLM.5 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount, family=binomial(logit), data=UniversalBank)
summary(GLM.5)
exp(coef(GLM.5))  # Exponentiated coefficients ("odds ratios")
GLM.6 <- glm(PersonalLoan ~ CCAvg + CreditCard + Education + Family + Income + Online + SecuritiesAccount, family=binomial(logit), data=UniversalBank)
summary(GLM.6)
exp(coef(GLM.6))  # Exponentiated coefficients ("odds ratios")
GLM.7 <- glm(PersonalLoan ~ CCAvg + CreditCard + Education + Family + Income + Online + SecuritiesAccount + CDAccount, family=binomial(logit), data=UniversalBank)
summary(GLM.7)
exp(coef(GLM.7))  # Exponentiated coefficients ("odds ratios")
GLM.8 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount, family=binomial(logit), data=UniversalBank)
summary(GLM.8)
exp(coef(GLM.8))  # Exponentiated coefficients ("odds ratios")
vif(GLM.8)
round(cov2cor(vcov(GLM.8)), 3) # Correlations of parameter estimates
GLM.9 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount, family=binomial(probit), data=UniversalBank)
summary(GLM.9)
GLM.10 <- glm(PersonalLoan ~ (CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount)^2, family=binomial(logit), data=UniversalBank)
summary(GLM.10)
exp(coef(GLM.10))  # Exponentiated coefficients ("odds ratios")
GLM.11 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CDAccount*Family) + (CreditCard*Online) + 
  (Education*Family) +(Education*Income) + (Family*Income) + (Family*Online) + (Family*SecuritiesAccount) + (Online*SecuritiesAccount), family=binomial(logit), 
  data=UniversalBank)
summary(GLM.11)
exp(coef(GLM.11))  # Exponentiated coefficients ("odds ratios")
GLM.12 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CDAccount * Family) + (CreditCard * Online) + 
  (Education * Family) + (Education * Income) + (Family * Income) + (Family * SecuritiesAccount) + (Online * SecuritiesAccount), family=binomial(logit), data=UniversalBank)
summary(GLM.12)
exp(coef(GLM.12))  # Exponentiated coefficients ("odds ratios")
GLM.13 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CreditCard * Online) + (Education * Family) + 
  (Education * Income) + (Family * Income) + (Family * SecuritiesAccount) + (Online * SecuritiesAccount), family=binomial(logit), data=UniversalBank)
summary(GLM.13)
exp(coef(GLM.13))  # Exponentiated coefficients ("odds ratios")
GLM.14 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CreditCard * Online) + (Education * Family) + 
  (Education * Income) + (Family * Income) + (Online * SecuritiesAccount), family=binomial(logit), data=UniversalBank)
summary(GLM.14)
exp(coef(GLM.14))  # Exponentiated coefficients ("odds ratios")
GLM.15 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CCAvg*Education) + (CCAvg*Family) + (CCAvg*Income) 
  + (CDAccount*Family) + (CreditCard * Online) + (Education * Family) + (Education * Income) + (Family * Income) + (Family*Online) + (Family*SecuritiesAccount) + (Online * 
  SecuritiesAccount), family=binomial(logit), data=UniversalBank)
summary(GLM.15)
exp(coef(GLM.15))  # Exponentiated coefficients ("odds ratios")
GLM.16 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * 
  Income) + (CDAccount * Family) + (CreditCard * Online) + (Education * Family) + (Education * Income) + (Family * Income) + (Family * SecuritiesAccount), 
  family=binomial(logit), data=UniversalBank)
summary(GLM.16)
exp(coef(GLM.16))  # Exponentiated coefficients ("odds ratios")
GLM.17 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * 
  Income) + (CreditCard * Online) + (Education * Family) + (Education * Income) + (Family * Income), family=binomial(logit), data=UniversalBank)
summary(GLM.17)
exp(coef(GLM.17))  # Exponentiated coefficients ("odds ratios")
GLM.18 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + 
  Family + Income + Online + SecuritiesAccount + (CCAvg*Education) + 
  (CCAvg*Family) + (CCAvg*Income) + (CCAvg*Online) + (CDAccount*Family) + 
  (CreditCard * Online) + (Education * Family) + (Education * Income) + 
  (Family * Income) + (Family*Online) + (Family*SecuritiesAccount) + (Online 
  * SecuritiesAccount), family=binomial(logit), data=UniversalBank)
summary(GLM.18)
exp(coef(GLM.18))  # Exponentiated coefficients ("odds ratios")
GLM.19 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CCAvg * Online) + (CDAccount * Family) + (CreditCard * Online) + (Education * Family) 
  + (Education * Income) + (Family * Income) + (Family * SecuritiesAccount), 
  family=binomial(logit), data=UniversalBank)
summary(GLM.19)
exp(coef(GLM.19))  # Exponentiated coefficients ("odds ratios")
GLM.20 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CCAvg * Online) + (CreditCard * Online) + (Education * Family) + (Education * Income) 
  + (Family * Income) + (Family * SecuritiesAccount), family=binomial(logit), 
  data=UniversalBank)
summary(GLM.20)
exp(coef(GLM.20))  # Exponentiated coefficients ("odds ratios")
GLM.21 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CCAvg * Online) + (CreditCard * Online) + (Education * Family) + (Education * Income) 
  + (Family * Income), family=binomial(logit), data=UniversalBank)
summary(GLM.21)
exp(coef(GLM.21))  # Exponentiated coefficients ("odds ratios")
GLM.22 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CCAvg * Online) + (CreditCard * Online) + (Education * Family) + (Education * Income) 
  + (Family * Income), family=binomial(probit), data=UniversalBank)
summary(GLM.22)
GLM.23 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg*Education) + (CCAvg*Family) + (CCAvg*Income) + 
  (CDAccount*Family) + (CreditCard * Online) + (Education * Family) + (Education * Income) 
  + (Family * Income) + (Family*SecuritiesAccount), family=binomial(logit), 
  data=UniversalBank)
summary(GLM.23)
exp(coef(GLM.23))  # Exponentiated coefficients ("odds ratios")
GLM.24 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CreditCard * Online) + (Education * Family) + (Education * Income) + (Family * Income),
   family=binomial(logit), data=UniversalBank)
summary(GLM.24)
exp(coef(GLM.24))  # Exponentiated coefficients ("odds ratios")
GLM.25 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (Education * Family) + (Education * Income) + (Family * Income), family=binomial(logit),
   data=UniversalBank)
summary(GLM.25)
exp(coef(GLM.25))  # Exponentiated coefficients ("odds ratios")
GLM.26 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Income) + (Education * 
  Family) + (Education * Income) + (Family * Income), family=binomial(logit), 
  data=UniversalBank)
summary(GLM.26)
exp(coef(GLM.26))  # Exponentiated coefficients ("odds ratios")
GLM.27 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Income) + 
  (CreditCard*Online) + (Education * Family) + (Education * Income) + (Family * Income), 
  family=binomial(logit), data=UniversalBank)
summary(GLM.27)
exp(coef(GLM.27))  # Exponentiated coefficients ("odds ratios")
GLM.28 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Income) + (Education * 
  Family) + (Education * Income), family=binomial(logit), data=UniversalBank)
summary(GLM.28)
exp(coef(GLM.28))  # Exponentiated coefficients ("odds ratios")
GLM.29 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg*Education) + (CCAvg*Family) + (CCAvg*Income) + 
  (CCAvg*Online) + (CreditCard * Online) + (Education * Family) + (Education * Income) + 
  (Family * Income), family=binomial(logit), data=UniversalBank)
summary(GLM.29)
exp(coef(GLM.29))  # Exponentiated coefficients ("odds ratios")
GLM.30 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (CCAvg * Online) + (Education * Family) + (Education * Income) + (Family * Income), 
  family=binomial(logit), data=UniversalBank)
summary(GLM.30)
exp(coef(GLM.30))  # Exponentiated coefficients ("odds ratios")
GLM.31 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Family) + (CCAvg * Income) 
  + (Education * Family) + (Education * Income) + (Family * Income), family=binomial(logit),
   data=UniversalBank)
summary(GLM.31)
exp(coef(GLM.31))  # Exponentiated coefficients ("odds ratios")
GLM.32 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Income) + (Education * 
  Family) + (Education * Income), family=binomial(logit), data=UniversalBank)
summary(GLM.32)
exp(coef(GLM.32))  # Exponentiated coefficients ("odds ratios")
GLM.33 <- glm(PersonalLoan ~ CCAvg + CDAccount + CreditCard + Education + Family + Income 
  + Online + SecuritiesAccount + (CCAvg * Education) + (CCAvg * Income) + (Education * 
  Family) + (Education * Income), family=binomial(probit), data=UniversalBank)
summary(GLM.33)
data()

