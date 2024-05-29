#Advance breeding program by 1 year

####>>>>>-------------- Year 6
MaleHybridYT5 = selectInd(MaleHybridYT4,nYT5)
FemaleHybridYT5 = selectInd(FemaleHybridYT4,nYT5)

MaleHybridYT5 = setPheno(MaleHybridYT5,reps=repYT5,p=p,varE = varE)
FemaleHybridYT5 = setPheno(FemaleHybridYT5,reps=repYT5,p=p,varE = varE)

MaleInbredYT5 = MaleInbredYT4[
  MaleInbredYT4@id%in%MaleHybridYT5@mother
]
FemaleInbredYT5 = FemaleInbredYT4[
  FemaleInbredYT4@id%in%FemaleHybridYT5@mother
]

####>>>>>-------------- Year 5
MaleHybridYT4 = selectInd(MaleHybridYT3,nYT4)
FemaleHybridYT4 = selectInd(FemaleHybridYT3,nYT4)

MaleHybridYT4 = setPheno(MaleHybridYT4,reps=repYT4,p=p,varE = varE)
FemaleHybridYT4 = setPheno(FemaleHybridYT4,reps=repYT4,p=p,varE = varE)

MaleInbredYT4 = MaleInbredYT3[
  MaleInbredYT3@id%in%MaleHybridYT4@mother
]
FemaleInbredYT4 = FemaleInbredYT3[
  FemaleInbredYT3@id%in%FemaleHybridYT4@mother
]

####>>>>>-------------- Year 4
MaleYT2 = setEBV(MaleYT2, gsmodel)
FemaleYT2 = setEBV(FemaleYT2, gsmodelF)

MaleInbredYT3 = selectInd(MaleYT2,nInbred3, use = 'ebv')
FemaleInbredYT3 = selectInd(FemaleYT2,nInbred3, use = 'ebv')

MaleHybridYT3 = hybridCross(MaleInbredYT3,FemaleElite)
FemaleHybridYT3 = hybridCross(FemaleInbredYT3,MaleElite)

MaleHybridYT3 = setPheno(MaleHybridYT3,reps=repYT3,p=p,varE = varE)
FemaleHybridYT3 = setPheno(FemaleHybridYT3,reps=repYT3,p=p,varE = varE)

####>>>>>-------------- Year 3

####>>>>>-------------- Year 2
MaleYT1 = setPheno(MaleDH,reps=repYT1,p=p,varE = varE)
FemaleYT1 = setPheno(FemaleDH,reps=repYT1,p=p,varE = varE)

MaleYT2 = selectInd(MaleYT1, nInbred1)
FemaleYT2 = selectInd(FemaleYT1, nInbred1)


####>>>>>-------------- Year 1
MaleF1 = randCross(MaleParents, nCrosses)
FemaleF1 = randCross(FemaleParents, nCrosses)

MaleDH = makeDH(MaleF1,nDH)
FemaleDH = makeDH(FemaleF1,nDH)

# ###GS model
gsmodel = RRBLUP(trainPop, use = 'pheno', useReps = TRUE)
gsmodelF = RRBLUP(trainPopF, use = 'pheno', useReps = TRUE)