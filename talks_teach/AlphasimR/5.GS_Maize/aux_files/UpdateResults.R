#####-----------------------------------------------
#Track population, hybrid and parents performances
#####-----------------------------------------------
require(AGHmatrix)

###>>>----- Population
popname = c(MaleParents, FemaleParents)
genPa = genParam(popname)

###>>>-------- 1. Paramenters
MeanG_pop[year] = genPa$mu
Accuracy[year]  = cor(gv(popname), pheno(popname), use = "pairwise.complete.obs")
MeanA_pop[year] = mean(genPa$gv_a)
VarG_pop[year]  = genPa$varG








