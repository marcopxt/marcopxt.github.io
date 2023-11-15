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
    male_yt1 = MaleYT1
    male_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt1)))
    
    male_yt2 = MaleYT2
    male_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(male_yt2)))
    
    trainPop = c(male_yt1, male_yt2)
    
  } else if (year == 14 | year == 15 ) {
    male_yt1 = MaleYT1
    male_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt1)))
    
    male_yt2 = MaleYT2
    male_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(male_yt2)))
    
    trainPop = c(trainPop,male_yt1, male_yt2)
    
  } else {
    male_yt1 = MaleYT1
    male_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(male_yt1)))
    
    male_yt2 = MaleYT2
    male_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(male_yt2)))
    
    trainPop <- trainPop[-c(1:(male_yt1@nInd+male_yt2@nInd))]
    trainPop = c(trainPop, male_yt1, male_yt2)
    
  }
  
  ######--------------------------------------------
  ##>>>>>  pull the snps from female heterotic group
  ######-------------------------------------------
  
  
  if (year == 13) {
    female_yt1 = FemaleYT1
    female_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt1)))
    
    female_yt2 = FemaleYT2
    female_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(female_yt2)))
    
    trainPopF = c(female_yt1, female_yt2)
    
  } else if (year == 14 | year == 15 ) {
    female_yt1 = FemaleYT1
    female_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt1)))
    
    female_yt2 = FemaleYT2
    female_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(female_yt2)))
    
    trainPopF = c(trainPopF,female_yt1, female_yt2)
    
  } else {
    female_yt1 = FemaleYT1
    female_yt1@fixEff <- as.integer(rep(paste0(year,1L),nInd(female_yt1)))
    
    female_yt2 = FemaleYT2
    female_yt2@fixEff <- as.integer(rep(paste0(year,3L),nInd(female_yt2)))
    
    trainPopF <- trainPopF[-c(1:(female_yt1@nInd+female_yt2@nInd))]
    trainPopF = c(trainPopF, female_yt1, female_yt2)
    
  }
  
}





