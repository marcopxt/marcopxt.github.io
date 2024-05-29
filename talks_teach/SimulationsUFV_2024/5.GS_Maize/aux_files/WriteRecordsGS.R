cat(" Writing records \n")
# NOTE: Training records are collected with a sliding-window process.
# Cumulation of the records starts in the burn-in year 'startTrainPop'.
# Once the burn-in period is over, the sliding-window process removes the oldest
# records.


if(year >= startTrainPop){
  
  ######------------------------------------------------
  ##>>>>>  pull the snps from male heterotic group
  ######------------------------------------------------
  
  if (year == 13) {
    male_yt = MaleYT1
    male_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt)))
    
    trainPop = male_yt
    
  } else if (year == 14 | year == 15 ) {
    male_yt = MaleYT1
    male_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt)))
    
    trainPop = c(trainPop, male_yt)
    
  } else {
    male_yt = MaleYT1
    male_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt)))
    
    trainPop <- trainPop[-c(1:(male_yt@nInd))]
    trainPop = c(trainPop, male_yt)
    
  }
  
  ######--------------------------------------------
  ##>>>>>  pull the snps from female heterotic group
  ######-------------------------------------------
  
  
  if (year == 13) {
    female_yt = FemaleYT1
    female_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt)))
    
    trainPopF = female_yt
    
  } else if (year == 14 | year == 15 ) {
    female_yt = FemaleYT1
    female_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt)))
    
    trainPopF = c(trainPopF,female_yt)
    
  } else {
    female_yt = FemaleYT1
    female_yt@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt)))

    trainPopF <- trainPopF[-c(1:(female_yt@nInd))]
    trainPopF = c(trainPopF, female_yt)
    
  }
  
}





