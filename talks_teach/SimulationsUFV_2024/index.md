**Summer/2024**
![FL](../../assets/images/UF.jpg){:width="20%" align="right"}  

***

# Optimization of breeding programs via Simulations and Genomic Selection

Marco Antonio Peixoto  

Federal University of Vicosa  
27-29/May/2024

**Schedule**  
Monday (05/27) - 5:00 pm - 9:00 pm  
Tuesday (05/28) - 5:00 pm - 9:00 pm  
Wednesday (05/29) - 5:00 pm - 9:00 pm 

***

# **Introduction**

![Imputation](../../assets/images/Picture1.png){:width="45%" align="right"}  

Designing a breeding program is a complex task. It requires simultaneously considering multiple interdependent breeding objectives (costs, size, target traits, etc.). Towards this aim, simulations have been demonstrated as a powerful tool for auxiliary breeding decisions. One among several tools in simulations is the **AlphaSimR** package (Gaynor et al. 2021). The package uses stochastic simulations for the design and optimization of breeding programs. It offers a fast, simple, and inexpensive way to test alternative breeding programs.  
In addition, genomic selection is a tool that has been shown as a game changer in plant breeding. It has been used to optimize several steps of a breeding program, such as advancements, early selections, in-situ hybrid prediction, parent selection, cross-selection, and trait introgression, among others.  
Here, we gonna use both tools together (simulations and genomic selection) to guide discussions on how to optimize breeding programs.  

# **Recommended literature**

We recommend reading the following papers:

- Paper 1: Gaynor CR, Gorjanc G, and Hickey JM (2021). AlphaSimR: an R package for breeding program simulations. G3. https://doi.org/10.1093/g3journal/jkaa017
- Paper 2: Werner, CR et al. (2023). Genomic selection strategies for clonally propagated crops. Theoretical and Applied Genetics. https://doi.org/10.1007/s00122-023-04300-6
- Paper 3: Meuwissen et al (2001). Prediction of Total Genetic Value Using Genome-Wide Dense Marker Maps.
- Video: Genomic selection - David Habier (https://www.youtube.com/watch?v=UJd_SAgLKh0)


# **Tentative program**

| Subject                                                  | Sections  | Time  |
|----------------------------------------------------------|-----------|-------|
|**AlphasimR: Base population and Global parameters**      |  Block 1  |  4 hr |
| -Genetic basis of base populations                       |                | 
| -Trait characteristics                                   |                 |
| -QTL (and SNPs) for traits                                      |                |
| -Non-additive effects                                    |                 |
| -Population characteristics                              |                |
| -Functions for modeling a breeding program               |           |       |
| **Breeding pipeline**                                     | Block 2   | 4 hr  |
| -From crosses to the release of varieties                     |           |       |
| -Recurrent Selection breeding program                     |           |       |
| -Reciprocal Recurrent Selection breeding program          |           |       |
| -Clonal breeding program                                  |           |       |
| **How to deploy Genomic selection in AlphaSimR**          | Block 2   | 2 hr  |
| -The genome and phenotypes                                |            |      |
| -Models and predictions into AlphaSimR                |           |       |
| -RRBLUP, RRBLUP_D, RRBLUP_GCA, RRBLUP_SCA             |           |       |
| -Using external packages for predictions            |           |       |
| **Practical implementation GS**                          | Block 3   | 2 hr  |
| -Training populations                                 |           |       |
| -Comparison                                           |           |       |

***

# Topics

## 1. Base population and Global parameters

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/1.BasePopTraits.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/1.BasePopTraits.Rmd)
- Data [[externalData]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/External_Data.RData)

## 2. Functions in AlphaSimR 

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/2.AlphaSimR_Functions.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/2.AlphaSimR_Functions(RMD).Rmd)

## 3. Breeding Pipeline

- Content - Recurrent selection program [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/3.WheatBreeding.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/tree/master/talks_teach/AlphasimR/3.Wheat)

- Content - Reciprocal recurrent selection program [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/3.MaizeBreeding.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/tree/master/talks_teach/AlphasimR/3.Maize)


## 4. How to deploy Genomic selection in AlphaSimR

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/4.DeployingGS.html)

- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/4.DeployingGS.Rmd)

  
## 5. Practical implementation GS

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/AlphasimR/5.Practical_ImplementationGS.html)

- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/tree/master/talks_teach/AlphasimR/5.GS_Maize)

