###>>>---------------------------
###> 1. Creating the base genome
###>>>---------------------------

founderpop = runMacs(nInd=nParents*2,
                     nChr=10,
                     segSites=nQtl+nSnp,
                     inbred=TRUE,
                     split=30,
                     species="MAIZE")

###>>>---------------------------
###> 2. Setting traits characteristics
###>>>---------------------------

SP = SimParam$new(founderpop)
SP$restrSegSites(nQtl,nSnp)$
  addSnpChip(nSnp)$
  addTraitADG(nQtl,
               mean=MeanG,var=VarG,
               varGxE=VarGE,
               meanDD=ddMean,varDD=ddVar)$
 setVarE(varE=varE)$
 setTrackPed(TRUE)


###>>>---------------------------
###> 3. Creating the initial population
###>>>---------------------------

# Split the parents into heterotic pools
FemaleParents = newPop(founderpop[1:nParents])
MaleParents = newPop(founderpop[(nParents+1):(nParents*2)])

#Set hybrid parents for later yield trials
MaleElite = selectInd(MaleParents,nElite,use="gv")
FemaleElite = selectInd(FemaleParents,nElite,use="gv")

#Reverse order to keep best parent in longer
MaleElite = MaleElite[nElite:1]
FemaleElite = FemaleElite[nElite:1]

#Set initial testers for testcross trials
MaleTester1 = MaleElite[1:nTester1]
FemaleTester1 = FemaleElite[1:nTester1]
MaleTester2 = MaleElite[1:nTester2]
FemaleTester2 = FemaleElite[1:nTester2]


