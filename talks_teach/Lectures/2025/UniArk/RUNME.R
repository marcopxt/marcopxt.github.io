################################################################################
### Genomic selection, cross prediction and optimization
###
### author: Marco Antonio Peixoto, Associate researcher at University of Florida
### 12-01-2025
### deamorimpeixotom@ufl.edu
###


#-------------------------------------------------------------------------------   
## 1. Introduction
#-------------------------------------------------------------------------------  

### Loading the packages

#install.packages("bWGR")
library(bWGR)
#devtools::install_github("Resende-Lab/SimpleMating")
library(SimpleMating)
#install.packages("AGHmatrix")
library(AGHmatrix)

#-------------------------------------------------------------------------------  
## 2. Genomic selection model
#-------------------------------------------------------------------------------  
### Loading the data

# Download the data from here
url <- "https://raw.githubusercontent.com/marcopxt/marcopxt.github.io/master/talks_teach/Lectures/2025/UniArk/dataGS.RData"

dest <- "dataGS.RData"

download.file(url, destfile = dest, mode = "wb")


# Load the dataset
load("dataGS.RData", verbose = TRUE)

# Phenotypes
head(Pheno)

# Genotypes
table(Geno)
Geno[1:10,1:10]


### Using  genomic model to prediction individuals performance


# Model for markers
Model = wgr(y = Pheno$Trait1, # Phenotypes
            X = as.matrix(Geno)) # Genotypes

# Prediction to all individuals
plot(Model$hat, Pheno$Trait1)

# Preparing the outcomes
parents <- data.frame(id = rownames(Geno),
                      blup = Model$hat)


#-------------------------------------------------------------------------------  
## 3. Using *SimpleMating* for cross prediction and optimization
#-------------------------------------------------------------------------------  

### Using the mid-parental value (capturing only additivity)

# Creating a potential crosses
PlanCross <- SimpleMating::planCross(TargetPop = parents$id, MateDesign = 'half')

# Relationship matrix
relMat = AGHmatrix::Gmatrix(Geno)

# Mid-parental value
MPV_pop <- SimpleMating::getMPV(MatePlan = PlanCross,
                                Criterion = parents,
                                K = relMat)

head(MPV_pop)



### Optimization algorithm to generate the Mating Plan

# Optimization
MatingPLan <- SimpleMating::selectCrosses(data = MPV_pop,
                                          n.cross = 20, 
                                          max.cross = 4, 
                                          culling.pairwise.k = 0 )
# stats
MatingPLan[[1]]

# Mating Plan
MatingPLan[[2]]

# Plot
MatingPLan[[3]]
