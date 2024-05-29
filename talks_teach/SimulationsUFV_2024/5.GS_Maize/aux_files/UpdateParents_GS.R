#Sets new parents for inbreds
MaleYT2 = setEBV(MaleYT2, gsmodel)
FemaleYT2 = setEBV(FemaleYT2, gsmodelF)

# Male heterotic group
MaleParents = selectInd(MaleYT2,nParents, use = 'ebv')


# Female heterotic group
FemaleParents = selectInd(FemaleYT2,nParents, use = 'ebv')

