# DiallelAnalysisR
## Introduction

**DiallelAnalysisR** has functions to perform Diallel Analysis with R using Griffing's and Hayman's approaches. Four different Methods:

1. Method-I (Parents + F1's + reciprocals)
2. Method-II (Parents and one set of F1's)
3. Method-III (One set of F1's and reciprocals)
4. Method-IV (One set of F1's only)) 

and two Models:

1. Fixed Effects Model
2. Random Effects Model

can be applied using Griffing's approach.

## Installation

### Stable Version
Stable version of the package avialabe on [CRAN](https://cran.r-project.org/web/packages/DiallelAnalysisR/index.html) can be installed using:

```{r}
install.packages('DiallelAnalysisR')
```

### Development Version

Development version of the package avialabe on [Github](https://github.com/MYaseen208/DiallelAnalysisR) can be installed using:


```{r}
if(!require("devtools")) install.packages("devtools")
devtools::install_github('MYaseen208/DiallelAnalysisR', build_vignettes = TRUE)
```

## License
This package is free and open source software, licensed under GPL.
