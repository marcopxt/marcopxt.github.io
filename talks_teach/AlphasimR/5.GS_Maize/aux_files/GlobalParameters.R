# Global parameters for the simulation
#

burninYears = 15 #Length of common burnin
futureYears = 20 #Length of testing period

# Crossing->DH ------------------------------------------------------------

#Initial parents per heterotic pool
nParents = 20

#Number of crosses
nCrosses = 20

#DH lines produced per F1
nDH = 25

# Selection on GCA --------------------------------------------------------

#Number of inbreds per heterotic pool per stage
nInbred1 = nCrosses*nDH #Do not change
nInbred2 = 100
nInbred3 = 20

#Number of testers per heterotic pool per stage
#Values must be smaller than nElite
nTester1 = 1
nTester2 = 3

#Yield trial entries
nYT1 = nInbred1*nTester1 #Do not change
nYT2 = nInbred2*nTester2 #Do not change

# Selection on SCA --------------------------------------------------------

#Elite parents per heterotic pool
nElite = 5

#Elite YT size
nYT3 = nInbred3*nElite #Do not change
nYT4 = 20
nYT5 = 4


# Genetic and error terms -------------------------------------------------

#Number of QTL per chromosome
nQtl = 100

#Number of SNP per pair of chromosome
nSnp = 25

#Heterotic pool split
nGenSplit = 100

#Initial inbred mean
MeanG = 70

#Initial inbred variances, bushels per acre
VarG = 20 # Genetic
VarGE = 40 # Genotype-by-year interaction

#Degree of dominance
ddMean = 0.92 # Mean
ddVar = 0.3 # Variance


#Yield trial error variance, bushels per acre
varE = 270


#Yield trial effective replications for calculating error
#Roughly related to the number of locations relative to YT_1
repYT1 = 6
repYT2 = 12
repYT3 = 24
repYT4 = 48
repYT5 = 600


#--- Genomic selection parameters ---------------------------------------------
#Start the training population historical records (3 years)
startTrainPop <- 13
