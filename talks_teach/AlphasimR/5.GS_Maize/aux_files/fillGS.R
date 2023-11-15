
####>>>>>-------------- Year 1
MaleF1 = randCross(MaleParents, nCrosses)
FemaleF1 = randCross(FemaleParents, nCrosses)

MaleDH = makeDH(MaleF1,nDH)
FemaleDH = makeDH(FemaleF1,nDH)

# ###GS model
gsmodel = RRBLUP(trainPop, use = 'pheno', useReps = TRUE)
gsmodelF = RRBLUP(trainPopF, use = 'pheno', useReps = TRUE)

####>>>>>-------------- Year 2
MaleYT1 = setPhenoGCA(MaleDH,FemaleTester1,reps=repYT1,inbred=T,p=p,varE = varE)
FemaleYT1 = setPhenoGCA(FemaleDH,MaleTester1,reps=repYT1,inbred=T,p=p,varE = varE)


####>>>>>-------------- Year 3
MaleYT1ebv = setEBV(MaleYT1, gsmodel)
FemaleYT1ebv = setEBV(FemaleYT1, gsmodelF)

MaleYT2 = selectInd(MaleYT1ebv, nInbred2, use = 'ebv')
FemaleYT2 = selectInd(FemaleYT1ebv, nInbred2, use = 'ebv')

MaleYT2 = setPhenoGCA(MaleYT2,FemaleTester2,reps=repYT2,inbred=T,p=p,varE = varE)
FemaleYT2 = setPhenoGCA(FemaleYT2,MaleTester2,reps=repYT2,inbred=T,p=p,varE = varE)

####>>>>>-------------- Year 4
MaleYT2 = setEBV(MaleYT2, gsmodel)
FemaleYT2 = setEBV(FemaleYT2, gsmodelF)

MaleInbredYT3 = selectInd(MaleYT2,nInbred3, use = 'ebv')
FemaleInbredYT3 = selectInd(FemaleYT2,nInbred3, use = 'ebv')

MaleHybridYT3 = hybridCross(MaleInbredYT3,FemaleElite)
FemaleHybridYT3 = hybridCross(FemaleInbredYT3,MaleElite)

MaleHybridYT3 = setPheno(MaleHybridYT3,reps=repYT3,p=p,varE = varE)
FemaleHybridYT3 = setPheno(FemaleHybridYT3,reps=repYT3,p=p,varE = varE)

