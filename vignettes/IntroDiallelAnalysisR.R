## ---- echo=FALSE---------------------------------------------------------------------
out_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")

r = getOption("repos")
r["CRAN"] = "https://cran.rstudio.com/"
#r["CRAN"] = "https://cloud.r-project.org/"
#r["CRAN"] = "https://ftp.iitm.ac.in/cran/"
options(repos = r)

## ---- results='asis', echo=FALSE-----------------------------------------------------
switch(out_type,
    html = {cat("<p>1. Department of Mathematics and Statistics, University of Agriculture Faisalabad, Pakistan.</p>

<p>2.Department of Statistics, University of Nebraska Lincoln, NE, USA.</p>")},
    latex = cat("\\begin{center}
1. Department of Mathematics and Statistics, University of Agriculture Faisalabad, Pakistan.
2. Department of Statistics, University of Nebraska Lincoln, NE, USA

\\end{center}" )
)

## ----setup, include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      comment = "",
                      fig.cap = "")

## ------------------------------------------------------------------------------------
sessionInfo()

