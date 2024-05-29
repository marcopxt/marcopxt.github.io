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

Designing a breeding program is a complex task. It requires simultaneously considering multiple interdependent breeding objectives (costs, size, target traits, etc.). Towards this aim, simulations have been demonstrated as a powerful tool for generating data-driven evidence for breeding decisions. One among several tools in simulations is the **AlphaSimR** package (Gaynor et al. 2021). The package uses stochastic simulations for the design and optimization of breeding programs. It offers a fast, simple, and inexpensive way to test alternative breeding programs.  
In addition, genomic selection is a tool that has been shown as a game changer in animal and plant breeding. It has been used to optimize several steps of a breeding program, such as advancements, early selections, hybrid prediction, parent selection, cross-selection, and trait introgression, among others.  
Here, we will use both tools together (simulations and genomic selection) to guide discussions on how to optimize breeding programs.  

# **Recommended literature**

We recommend reading the following papers:

- Paper 1: Gaynor CR, Gorjanc G, and Hickey JM (2021). AlphaSimR: an R package for breeding program simulations. G3. https://doi.org/10.1093/g3journal/jkaa017
- Paper 2: Werner, CR et al. (2023). Genomic selection strategies for clonally propagated crops. Theoretical and Applied Genetics. https://doi.org/10.1007/s00122-023-04300-6
- Paper 3: Meuwissen et al (2001). Prediction of Total Genetic Value Using Genome-Wide Dense Marker Maps. https://doi.org/10.1093/genetics/157.4.1819
- Paper 4: Bancic et al. (2024) Plant breeding simulations with AlphaSimR. https://doi.org/10.1101/2023.12.30.573724

***

# **Tentative program**

| Subject                                                  | Sections  | Time  |
|----------------------------------------------------------|-----------|-------|
|**AlphasimR: Base population and Global parameters**      |  Block 1  |  4 hr |
| -Genetic basis of base populations                       |                | 
| -Trait characteristics                                   |                 |
| -QTL (and SNPs) for traits                               |                |
| -Non-additive effects                                    |                 |
| -Population characteristics                              |                |
| -Functions for modeling a breeding program               |           |       |
| **Simulating Breeding pipelines**                        | Block 2   | 3 hr  |
| -From crosses to the release of varieties                 |           |       |
| -Recurrent Selection breeding program                     |           |       |
| -Reciprocal Recurrent Selection breeding program          |           |       |
| **How to deploy Genomic selection**          | Block 3   | 5 hr  |
| -The genome and phenotypes                                |            |      |
| -Mixed models and genomic models                          |           |       |
| -Models and predictions into AlphaSimR                    |           |       |
| -Factors affecting prediction accuracy                    |           |       |
| -Training populations and model deployment                |           |       |
| -Using external packages for predictions                  |           |       |
|-----------------------------------------------------------|-----------|-------|

***

<br>

# Topics and Content

## **I. AlphasimR: Base population and Global parameters**  

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/1.BasePopTraits.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/1.BasePopTraits.Rmd)

**Importing external data**
- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/1.2.ImportDataExt.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/1.2.ImportDataExt.Rmd)
- Data [[externalData]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/External_Data.RData)


## **II. Simulating Breeding pipelines** 

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/2.AlphaSimR_Functions.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/2.AlphaSimR_Functions.Rmd)


**Genetic trends over generations**
- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/3.AlphaSimR_Results.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/3.AlphaSimR_Results.Rmd)

**Line breeding pipeline**
- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/4.1.WheatBreeding.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/4.1.WheatBreeding.Rmd)

**Maize breeding pipeline**
- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/4.2.MaizeBreeding.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/4.2.MaizeBreeding.Rmd)

## **III. How to deploy Genomic selection**   

- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/5.Intro2GS.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/5.Intro2GS.Rmd)



**Maize breeding pipeline II (with GS now)**
- Content [[html]](https://htmlpreview.github.io/?https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/5.GS_Maize/5.Practical_ImplementationGS.html)
- Script [[rmd]](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/marcopxt/marcopxt.github.io/blob/master/talks_teach/SimulationsUFV_2024/5.GS_Maize/5.Practical_ImplementationGS.Rmd)

