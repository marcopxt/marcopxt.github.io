
# ###GS model
gsmodel = RRBLUP(trainPop, use = 'pheno', useReps = TRUE)
gsmodelF = RRBLUP(trainPopF, use = 'pheno', useReps = TRUE)


####>>>>>-------------- Year 3
MaleYT1ebv = setEBV(MaleYT1, gsmodel)
FemaleYT1ebv = setEBV(FemaleYT1, gsmodelF)

####>>>>>-------------- Year 4
MaleYT2 = setEBV(MaleYT2, gsmodel)
FemaleYT2 = setEBV(FemaleYT2, gsmodelF)

