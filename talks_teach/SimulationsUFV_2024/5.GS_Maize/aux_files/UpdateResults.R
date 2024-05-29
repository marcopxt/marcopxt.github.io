#####-----------------------------------------------
#Track population, hybrid and parents performances
#####-----------------------------------------------

###>>>----- Population
popname = c(MaleParents, FemaleParents)
genPa = genParam(popname)

###>>>-------- 1. Parameters
MeanG_pop[year] = genPa$mu
MeanA_pop[year] = mean(genPa$gv_a)
VarG_pop[year]  = genPa$varG





