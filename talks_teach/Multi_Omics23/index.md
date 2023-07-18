
**Spatial analyses**  
**Marco Antônio Peixoto**  
**11-04-2022**


# 1. Introduction

Spatial analyses represents an optimal tool for post-hoc correction of field trials information. Heterogeneous factors that were not full corrected by the plotting techniques (i.e. soil fertility, diseases, and water holding capacity) can cause some disturbance in the prediction of BLUP values and, at the end, in the selection of the genotypes.

Below, we implement a set of models that is known as spatial analyses. In addition to demonstrate each step of the analysis, we also cover several parameters of interest for estimation/prediction purposes.

# 2. How to measure the best fit of a model to the data

The goodness-of-fit of a model to the data can be measured by different parameters. Below, we describe the most useful for spatial analyses. It is worth to mentioning that the spatial analyses' objective is to select the most accurately and parsimoniously model model that captures the spatial effects in the field. This will provides the most acurate and precise estimation of variance components and prediction of the genotypes values (Isik et al. 2018)

### Heritability ($h^2$)

The heritability represents how much of the phenotypic variation came from a genetic source. We can measure it based on the the variance components estimated by the model. The simplest representation of heritability ($h^2$) follows the equation:

$$
h^2 = \frac{\sigma^2_g}{\sigma^2_g + \sigma^2_{res}}
$$

where $\sigma^2_g$ is represents the genotypic variance and $\sigma^2_{res}$ represents the residual variance.

### Prediction accuracy ($r_{\tilde{g}g}$)

The prediction accuracy represents a measure of how close a prediction is to the real genotypic value of a genotype for a target trait. It can be estimated by:

$$
r_{\tilde{g}g} = cor(predicted.value,real.value)
$$

One simple way to get an estimation of accuracy is using the square root of the heritability:

$$
r_{\tilde{g}g} = {\sqrt{h^2}}
$$

In mixed models, one alternative is to estimated the heritability is to use the prediction error variance (PEV) from the prediction. It can be easily estimated by:

$$
PEV = std.error^2
$$

where the $std.error$ represents the standard error from the genotypes predictions. After, we can use the following equation (Mrode, 2014):

$$
r_{\tilde{g}g} = \sqrt{\frac{1-PEV}{\sigma^2_g}}
$$

The accuracy values can vary from 0 to 1. Values close to 1 represents the best accuracy from a prediction of a target trait.

### LRT test

The likelihood information test (LRT - Wilks, 1938) is indicated to compared models. However, the comparison take into account that the models share the same fixed effects and one model (reduced model) has a subset of the random effects of the other model (full model). The LRT formulae is given as follow:

$$
LRT = -2(logL_{full}-logL_{reduced})
$$
where $logL_{full}$ represents the log likelihood of the full model (i.e. all random effects), and $logL_{reduced}$ represents the log likelihood of the reduced model (i.e. missing one random effect). The difference in-between models should be higher than 3.84 ($\chi^2$ test, with 5% of probability and 1 degree of freedom). At this level (higher than 3.84) we consider that we have enough evidence to reject the null hypothesis, where the models are similar.


### Information criteria (AIC and BIC)

The most indicated parameters to measure the goodness-of-fit of one model to the data are Akaike Information Criteria (AIC - Akaike, 1974) and Schwarz's Bayesian Information Criteria (BIC - Schwarz, 1978). They are indicated for models that are not nested and share the same fixed effects. The formulae definition for AIC and BIC are the following:

$$
AIC = -2*logL + 2t
$$


$$
BIC = -2*logL + 2t*log(v)
$$

where LogL represents the log likelihood of a model, $t$ represents the number of covariance parameters in the model, $v$ is the residual degrees of freedom, where $v = n-p$, being $n$ the number of observations and $p$ the number of parameters in fixed effect factors. If the difference in-between two models is superior to 2, we can consider that the model with lower value of AIC/BIC is the best fit model to the data. In addition, if the difference is lower than 2, we should choose the most parsimoniously model, in other words, the model with lower number of parameters.

# 3. Dataset

#### Packages

```{r, message=FALSE}
require(asreml)
require(dplyr)
rm(list=ls())
```

#### Dataset

```{r}
data = read.table("../data/data_spatial.txt", h=TRUE)
```

This dataset refers to an evaluation of 78 maize genotypes, in one location, and the trait measured was Yield.

| Factor    | Levels |
|-----------|--------|
| Location  | One    |
| Genotypes | 78     |
| Checks    | 6      |
| Blocks    | 3      |
| Ranges    | 18     |
| Rows      | 14     |

```{r}
 # Setting as factors
 
 data$Row = data$Row %>% as.factor()
 data$Range = data$Range %>% as.factor()
 data$Block = data$Block %>% as.factor()
 data$Genotype = data$Genotype %>% as.factor()
 data$Check  = data$Check %>% as.factor()
 
```

Exploring the data set by graphs

```{r}

boxplot(Yield~Block,
data=data,
main="Trait performance over Blocks",
xlab="Block Number",
ylab="Yield (kg/ha)",
col="orange",
border="brown"
)


```

Exploring the data set by graphs

```{r}

boxplot(Yield~Range,
data=data,
main="Trait performance over ranges",
xlab="Range Number",
ylab="Yield (kg/ha)",
col="orange",
border="brown"
)

```

Exploring the data set by graphs

```{r}

boxplot(Yield~Row,
data=data,
main="Trait performance over rows",
xlab="Row number",
ylab="Yield (kg/ha)",
col="orange",
border="brown"
)

```

# 4. Model implementation

For the spatial analyses we list in table below the possible models for spatial analyses. We implemented each one of the models below. We used the before mentioned parameters to choose the best model (AIC, BIC, accuracy, heritability). The given model is as follow:

$$
y = Xb + Zg + e
$$


where $y$ is the vector of phenotypic data; $b$ is the vector of block-check combination (assumed to be fixed), which comprises the effects of block and checks within the blocks; $g$ is the vector of genotype effects (assumed to be random), where $g ~ N(0,\sigma^2_g)$; and $e$ is the vector of residuals (random), where $e ~ N(0,\sigma^2_{res})$. The letters $X$ and $Z$ refers to the incidence matrices for $b$ and $g$, respectively.



| Model | Action                                      | Fitted model for residual                   |
|---------------|--------------------------|--------------------------------|
| Mod1  | Only residual effect                        | $\sigma^2_{res}I_r⊗I_c$                          |
| Mod2  | Includes AR1 for row                          | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗I_c$                  |
| Mod3  | Includes AR1 for range                        | $\sigma^2_{𝜉}I_r⊗∑_c(𝞺_c)$                  |
| Mod4  | Includes AR1 for row/range                   | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$             |
| Mod5  | Includes AR1 for row/range and nugget effect | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c), \sigma^2_𝜼$ |

: Models fitted for spatial analyses

## Model 1: No spatial structures

```{r}
# Toy model
fm = asreml(fixed = Yield ~ Block + at(Check):Block,
              random = ~ Genotype,
              na.action = na.method(x = "include"),
              data = data)

fm1 = asreml(fixed = Yield ~ Block + Check:Block,
              random = ~ Genotype,
              na.action = na.method(x = "include"),
              data = data)

summary(fm)$varcomp

plot(fm)

```

```{r}
# Model 1 Same model, but with structure
mod1 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~id(Row):id(Range),
              data = data)


summary(mod1)$varcomp

plot(varioGram(mod1))

```

Model outcomes

```{r}
#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod1,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod1)$varcomp

# Traditional definition
(H2.mod1<-vpredict(mod1,H2~V1/(V1+V2)))   


# Model accuracy

# Estimation via heritability
(Acc.mod1 = sqrt(H2.mod1$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod1)$varcomp[1,1]
(Acc.PEV.mod1<-sqrt(1-mean.PEV/sigma2g))

# Akaike information criterion
aic.mod1 = summary(mod1)$aic[1]

# Bayesian information criterion
bic.mod1 = summary(mod1)$bic[1]

```

## Model 2: Inclusion of AR1 for row

```{r}
# Model 2 - Trends in Rows
mod2 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):id(Range),
              data = data)

plot(varioGram.asreml(mod2))

```

Model outcomes

```{r}

#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod2,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod2)$varcomp

# Traditional definition
(H2.mod2<-vpredict(mod2,H2~V1/(V1+V2)))   


# Model accuracy

# Estimation via heritability
(Acc.mod2 = sqrt(H2.mod2$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod2)$varcomp[1,1]
(Acc.PEV.mod2<-sqrt(1-mean.PEV/sigma2g))

# Akaike information criterion
aic.mod2 = summary(mod2)$aic[1]

# Bayesian information criterion
bic.mod2 = summary(mod2)$bic[1]

```

## Model 3: inclusion of AR1 for range

```{r}
# Model 3
mod3 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~Row:ar1(Range),
              data = data)

plot(varioGram(mod3))

```

Model output

```{r}

#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod3,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod3)$varcomp

# Traditional definition
(H2.mod3<-vpredict(mod3,H2~V1/(V1+V2)))   


# Model accuracy

# Estimation via heritability
(Acc.mod3 = sqrt(H2.mod3$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod3)$varcomp[1,1]
(Acc.PEV.mod3<-sqrt(1-mean.PEV/sigma2g))

# Akaike information criterion
aic.mod3 = summary(mod3)$aic[1]

# Bayesian information criterion
bic.mod3 = summary(mod3)$bic[1]

```

## Model 4: Inclusion of AR1 for row and range

```{r}
# Model 4
mod4 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)

plot(varioGram(mod4))


```

```{r}

#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod4,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod4)$varcomp

# Traditional definition
(H2.mod4<-vpredict(mod4,H2~V1/(V1+V2)))   


# Model accuracy

# Estimation via heritability
(Acc.mod4 = sqrt(H2.mod4$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod4)$varcomp[1,1]
(Acc.PEV.mod4<-sqrt(1-mean.PEV/sigma2g))

# Akaike information criterion
aic.mod4 = summary(mod4)$aic[1]

# Bayesian information criterion
bic.mod4 = summary(mod4)$bic[1]


```

## Model 5: Inclusion of nugget effect

```{r}
# Model 5
mod5 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype + idv(units),
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)


plot(varioGram(mod5))


```

Model output

```{r}

#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod5,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod5)$varcomp

# Traditional definition
(H2.mod5<-vpredict(mod5,H2~V1/(V1+V2+V3)))   


# Model accuracy

# Estimation via heritability
(Acc.mod5 = sqrt(H2.mod5$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod5)$varcomp[1,1]
(Acc.PEV.mod5<-sqrt(1-mean.PEV/sigma2g))

# Akaike information criterion
aic.mod5 = summary(mod5)$aic[1]

# Bayesian information criterion
bic.mod5 = summary(mod5)$bic[1]


```

# 5. Model comparision

## Heritabilities

```{r}
h2 = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                h2 = c(H2.mod1$Estimate[1],H2.mod2$Estimate[1],H2.mod3$Estimate[1],H2.mod4$Estimate[1],H2.mod5$Estimate[1]))

h2
  
```

## Accuracy via heritability

```{r}
Acc.h2 = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                Acc.h2 = c(Acc.mod1,Acc.mod2,Acc.mod3,Acc.mod4,Acc.mod5))

Acc.h2
  
```

## Accuracy via PEV

```{r}
Acc.PEV = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                Acc.PEV = c(Acc.PEV.mod1,Acc.PEV.mod2,Acc.PEV.mod3,Acc.PEV.mod4,Acc.PEV.mod5))

Acc.PEV
  
```

## AIC

```{r}
mod.AIC = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                AIC = c(aic.mod1,aic.mod2,aic.mod3,aic.mod4,aic.mod5))

mod.AIC
  
```

## BIC

```{r}
mod.BIC = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                BIC = c(bic.mod1,bic.mod2,bic.mod3,bic.mod4,bic.mod5))

mod.BIC
  
```

## All information for the residual effect modelling

```{r}
out = data.frame(Model = c("Mod1","Mod2", "Mod3", "Mod4","Mod5"),
                 h2 = h2$h2,
                 Acc.h2 = Acc.h2$Acc.h2,
                 Acc.PEV = Acc.PEV$Acc.PEV,
                 AIC = mod.AIC$AIC,
                 BIC = mod.BIC$BIC)
out

```

Based on AIC and BIC from those models, we can conclude that the goodness-of-fit came from the model 4, where we modeled AR1 for rows and AR1 for columns. The following comparisons will be based on this model.



# 6. Modelling the global effects

After the modelling of the effects of spatial correlated errors, we can include the information of row and range as an covariate in the model using the function $lin()$. In this case, we are accounting for an single linear trend for range and another for row effect. In addition, we check the possibility of inclusion of the row and range effects as random effects in the model. We described the models below:

| Model | Global/Extraneous                                       | Natural                                     | Random parameter | Fixed parameter |
|---------------|---------------|---------------|---------------|---------------|
| Mod5  |                                                         | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$| 4            | 21            |
| Mod6  | $\beta_r × R$                                           | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$ | 4             | 22            |
| Mod7  | $\beta_r × R,\beta_c × C$                               | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$ | 4              | 23            |
| Mod8  | $\beta_r × R,\beta_c × C, \sigma^2_rI_r$                | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$ | 5              | 23            |
| Mod9  | $\beta_r × R,\beta_c × C, \sigma^2_rI_r, \sigma^2_cI_c$ | $\sigma^2_{𝜉}∑_r(𝞺_r)⊗∑_c(𝞺_c)$ | 6              | 23            |

## Verbyla information

For the models above mentioned, we face an specific situation where the number of fixed effects vary among models. In this case, we are not allowed to use the AIC/BIC, as proposed. For such, we can incorporate a correction proposed by Verbyla (2019). With this correction, we will be able to compare those models. The calculation of the information criteria is an adaption of the code supplied in File S1 of Verbyla (2019). The log-likelihood is calculated as:

$$
         {loglik = log(REML) - log(|C|)/2}, 
$$

where **C** is log.determinant $(LogDet((X'H^{-1X})^{-1}))$ .

The AIC and BIC are calculated as:

$$
AIC = {- 2 * loglik + 2 * (rand.par + fixed.par)}
$$
$$
BIC = {- 2 * loglik + (fixed.par + rand.par) * log(n - r + fixed.par)}, 
$$

where **rand.par** represents the number of variances estimated by the full model , **fixed.par** represents the fixed degrees of freedom estimated by the full model, **n** is the number of observations, and **r** is the rank of the fixed effects design matrix.

## Model 4: Ar1xAr1

For comparison purposes, we will borrow the best residual model from the previous step to be the baseline structure for the next step. Therefore, we use the **Model 4** and we will fit it again to calculate the corrected AIC/BIC.

```{r}
# Model
mod4 = asreml(fixed = Yield~Block+at(Check):Block,
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)



#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod4,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod4)$varcomp

# Traditional definition
(H2.mod4<-vpredict(mod4,H2~V1/(V1+V2)))   


# Model accuracy

# Estimation via heritability
(Acc.mod4 = sqrt(H2.mod4$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod4)$varcomp[1,1]
(Acc.PEV.mod4<-sqrt(1-mean.PEV/sigma2g))

# Information criteria (Based on Verbyla (2019))
log.det = 267.6646
logL = summary(mod4)$loglik
rand.par = 4
fixed.par = 21
df = summary(mod4)$nedf

# Akaike information criterion
(aic.mod4 = (-2*(logL-(0.5*log.det)))+(2*(rand.par+fixed.par)))

# Bayesian information criterion
(bic.mod4 = (-2*(logL-(0.5*log.det)))+((rand.par+fixed.par)*log(df)))


```

## Model 6: Linear effect of row

```{r}
# Model 6
mod6 = asreml(fixed = Yield~Block+at(Check):Block+lin(Row),
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)


#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod6,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod6)$varcomp

# Traditional definition
(H2.mod6<-vpredict(mod6,H2~V1/(V1+V2)))   

# Model accuracy

# Estimation via heritability
(Acc.mod6 = sqrt(H2.mod6$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod6)$varcomp[1,1]
(Acc.PEV.mod6<-sqrt(1-mean.PEV/sigma2g))

# Information criterion (Based on Verbyla (2019))
log.det = 271.634
logL = summary(mod6)$loglik
rand.par = 4
fixed.par = 22
df = summary(mod6)$nedf

# Akaike information criterion
(aic.mod6 = (-2*(logL-(0.5*log.det)))+(2*(rand.par+fixed.par)))

# Bayesian information criterion
(bic.mod6 = (-2*(logL-(0.5*log.det)))+((rand.par+fixed.par)*log(df)))


```

## Model 7: Linear effect of row and range

```{r}

# Model 7
mod7 = asreml(fixed = Yield~Block+at(Check):Block+lin(Row)+lin(Range),
              random = ~Genotype,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)



#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod7,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[1:78,])

# variance components
summary(mod7)$varcomp

# Traditional definition
(H2.mod7<-vpredict(mod7,H2~V1/(V1+V2)))   

# Model accuracy

# Estimation via heritability
(Acc.mod7 = sqrt(H2.mod7$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod7)$varcomp[1,1]
(Acc.PEV.mod7<-sqrt(1-mean.PEV/sigma2g))

# Information criterion
log.det = 278.967179871277 
logL = summary(mod7)$loglik
rand.par = 4
fixed.par = 23
df = summary(mod7)$nedf

# Akaike information criterion
(aic.mod7 = (-2*(logL-(0.5*log.det)))+(2*(rand.par+fixed.par)))

# Bayesian information criterion
(bic.mod7 = (-2*(logL-(0.5*log.det)))+((rand.par+fixed.par)*log(df)))


```

## Model 8: Linear effect of row/range + random effect for row

```{r}
# Model
mod8 = asreml(fixed = Yield~Block+at(Check):Block+lin(Row)+lin(Range),
              random = ~Genotype + Row,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)


#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod8,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[15:(78+14),])

# variance components
summary(mod8)$varcomp

# Traditional definition
(H2.mod8<-vpredict(mod8,H2~V2/(V1+V2+V3)))   

# Model accuracy

# Estimation via heritability
(Acc.mod8 = sqrt(H2.mod8$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod8)$varcomp[2,1]
(Acc.PEV.mod8<-sqrt(1-mean.PEV/sigma2g))

# Information criterion
log.det = 278.9775
logL = summary(mod8)$loglik
rand.par = 5
fixed.par = 23
df = summary(mod8)$nedf

# Akaike information criterion
(aic.mod8 = (-2*(logL-(0.5*log.det)))+(2*(rand.par+fixed.par)))

# Bayesian information criterion
(bic.mod8 = (-2*(logL-(0.5*log.det)))+((rand.par+fixed.par)*log(df)))


```

## Model 9: Linear effect of row/range + random for row/range

```{r}
# Model
mod9 = asreml(fixed = Yield~Block+at(Check):Block+lin(Row)+lin(Range),
              random = ~Genotype + Row + Range,
              na.action = na.method(x = "include"),
              residual = ~ar1(Row):ar1(Range),
              data = data)


#---- Outcomes
# BLUPs for the genotypes
BLUPs<-summary(mod9,coef=T)$coef.random
BLUP.geno<-as.matrix(BLUPs[33:110,])

# variance components
summary(mod9)$varcomp

# Traditional definition
(H2.mod9<-vpredict(mod9,H2~V3/(V1+V2+V3+V4)))   


# Model accuracy

# Estimation via heritability
(Acc.mod9 = sqrt(H2.mod9$Estimate[1]))

# Definition via PEV (Predicted error variance)
mean.PEV<-mean(BLUP.geno[,2]^2)
sigma2g<-summary(mod9)$varcomp[3,1]
(Acc.PEV.mod9<-sqrt(1-mean.PEV/sigma2g))

# Information criterion
log.det = 278.97809
logL = summary(mod9)$loglik
rand.par = 6
fixed.par = 23
df = summary(mod9)$nedf

# Akaike information criterion
(aic.mod9 = (-2*(logL-(0.5*log.det)))+(2*(rand.par+fixed.par)))

# Bayesian information criterion
(bic.mod9 = (-2*(logL-(0.5*log.det)))+((rand.par+fixed.par)*log(df)))


```

# 7. Model Comparision

## Heritabilities

```{r}
h2 = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                h2 = c(H2.mod4$Estimate[1],H2.mod6$Estimate[1],H2.mod7$Estimate[1],
                       H2.mod8$Estimate[1],H2.mod9$Estimate[1]))

h2
  
```

## Accuracy via heritabilities

```{r}
Acc.h2 = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                Acc.h2 = c(Acc.mod4,Acc.mod6,Acc.mod7,Acc.mod8,Acc.mod9))

Acc.h2
  
```

## Accuracy via PEV

```{r}
Acc.PEV = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                Acc.PEV = c(Acc.PEV.mod4,Acc.PEV.mod6,Acc.PEV.mod7,Acc.PEV.mod8,Acc.PEV.mod9))

Acc.PEV
  
```

## AIC

```{r}
mod.AIC = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                AIC = c(aic.mod4,aic.mod6,aic.mod7,aic.mod8,aic.mod9))

mod.AIC
  
```

## BIC

```{r}
mod.BIC = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                BIC = c(bic.mod4,bic.mod6,bic.mod7,bic.mod8,bic.mod9))

mod.BIC
  
```

## All information for the fixed/random terms

```{r}
output = data.frame(Model = c("Mod4","Mod6","Mod7", "Mod8", "Mod9"),
                 h2 = round(h2$h2,3),
                 Acc.h2 = round(Acc.h2$Acc.h2,3),
                 Acc.PEV = round(Acc.PEV$Acc.PEV,3),
                 AIC = mod.AIC$AIC,
                 BIC = mod.BIC$BIC)


output

```


# References

Akaike H (1974) A new look at the statistical model identification. IEEE Trans Automat Contr 19:716–723. https://doi.org/10.1109/TAC.1974.1100705

Coelho, I., Peixoto, M. A., Marcal, T. D. S., Bernardeli, A., Alves, R., Lima, R. O., & Bhering, L. L. (2021). Accounting for spatial trends in multi-environment diallel analysis in maize breeding. PloS one, 16(10), e0258473.

Cullis, B.R., A.B. Smith, and N.E. Coombes. 2006. On the design of early generation variety trials with correlated data. J. Agric. Biol. Environ. Stat. 11(4): 381–393. doi: 
10.1198/108571106X15444

Gilmour, A.R.,Cullis,  B.R.  & Verbyla, A.P.  (1997). Accounting  for  natural  and  extraneous  variationin the analysis of field experiments.Journal of Agricultural, Biological and Environmental Statistics2,269–293

Isik et al., 2017. Genetic Data Analysis for Plant and Animal Breeding.

Mrode, R. A. (2014). Linear models for the prediction of animal breeding values. Cabi.

Schwarz G. Estimating the dimension of a model. Ann Stat. 1978; 6: 461–464.

Verbyla, A. P. (2019). A note on model selection using information criteria for general linear models estimated using REML. Australian & New Zealand Journal of Statistics, 61, 39--50. doi: 10.1111/anzs.12254.

Wilks SS. The Large-Sample Distribution of the Likelihood Ratio for Testing Composite Hypotheses. Ann Math Stat. 1938; 9: 60–62. https://doi.org/10.1214/aoms/1177732360

