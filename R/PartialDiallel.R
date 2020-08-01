#' @name   PartialDiallel
#' @aliases PartialDiallel
#' @title Analysis for Partial Diallel
#' @description Analysis of Partial Diallel
#' @param y Numeric Response Vector
#' @param Rep  Replicate as factor
#' @param Cross1 Cross 1 as factor
#' @param Cross2 Cross 2 as factor
#' @param data A \code{data.frame}
#' @return Means Means
#' @return ANOVA Analysis of Variance (ANOVA) table
#' @return Genetic.Components Genetic Components
#' @return General General
#' @return Specific Specific
#'
#' @author
#' \enumerate{
#' \item Pedro A. M. Barbosa (\email{pedro.barbosa@usp.br})
#' \item Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'  }
#'
#' @seealso
#'    \code{\link{PartialDiallelData}}
#'  , \code{\link{Griffing}}
#'  , \code{\link{Hayman}}
#'  , \code{\link{GriffingData1}}
#'  , \code{\link{GriffingData2}}
#'  , \code{\link{GriffingData3}}
#'  , \code{\link{GriffingData4}}
#'
#' @import stats
#' @export
#'
#' @examples
#'
#' data(PartialDiallelData)
#' fm1 <-
#'   PartialDiallel(
#'       y      = y
#'     , Rep    = Rep
#'     , Cross1 = Cross1
#'     , Cross2 = Cross2
#'     , data   = PartialDiallelData
#'   )
#'
#' fm1

PartialDiallel <-
  function(y, Rep, Cross1, Cross2, data) {
    data$Trt <- as.factor(paste(data[["Cross1"]], data[["Cross2"]], sep="-"))

    Simple.ANOVA<-summary(aov(y~Rep + Trt, data))[[1]]
    data[["y"]]
    Means<- tapply(X=data[["y"]],INDEX=list(data[["Cross1"]],data[["Cross2"]]),FUN=mean)
    Means1 <- Means
    n<- length(levels(as.factor(data[["Cross1"]])))
    m<- length(levels(as.factor(data[["Cross2"]])))
    r<- length(levels(as.factor(data[["Rep"]])))

    dimnames(Means) <- list(paste0("Cross", 1:n), paste0("Cross", n+1:m))

    SS.gca1 <- r*((sum(rowSums(Means)^2)/m)-(((sum(rowSums(Means)))^2)/(m*n)))
    SS.gca2 <- r*((sum(colSums(Means)^2)/n)-(((sum(colSums(Means)))^2)/(m*n)))
    SS.sca <- r*((sum(Means^2))-
                   ((sum(rowSums(Means)^2))/m)-
                   ((sum(colSums(Means)^2))/n)+
                   (((sum(colSums(Means)))^2)/(m*n)))
    SS.Treat <- r*((sum(Means^2)) - (((sum(colSums(Means)))^2)/(m*n)))

    #-----------------------------------------------------------------------------
    # ANOVA Table
    #-----------------------------------------------------------------------------
    df <-
      c(
        (n*m)-1,
        n-1,
        m-1,
        (n-1)*(m-1),
        Simple.ANOVA["Residuals","Df"]
      )

    sum(data[["y"]]^2)-((sum(data[["y"]])^2)/(m*n*r))

    SS <-
      c(
        SS.Treat,
        SS.gca1,
        SS.gca2,
        SS.sca,
        Simple.ANOVA["Residuals", "Sum Sq"]/r
      )
    MS<- SS/df

    F.Test<-c(MS[-5]/MS[5], NA)
    P.Value <- c(pf(F.Test[-5], df[-5], df[5], lower.tail = FALSE, log.p = FALSE), NA)
    ANOVA <- data.frame("Df" =  df, "Sum Sq" = SS, "Mean Sq" = MS,
                        "F value" = F.Test, "Pr(>F)" = P.Value, check.names = FALSE)
    rownames(ANOVA) <-
      c(
        "Treat",
        "GCA I",
        "GCA II",
        "SCA",
        "Error"
      )
    class(ANOVA) <- c("anova", "data.frame")
    #-----------------------------------------------------------------------------
    # Genetic Components
    #-----------------------------------------------------------------------------
    gcaI.v <- (MS[2]-MS[5])
    gcaII.v <- (MS[3]-MS[5])
    sca.v <- (MS[4]-MS[5])
    v.tot<-sum(gcaI.v,gcaII.v,sca.v)
    var.perc<-c(gcaI.v/v.tot,gcaII.v/v.tot,sca.v/v.tot)

    Genetic.Components <- data.frame("Components"=c(gcaI.v, gcaII.v, sca.v),"Percent"=var.perc,
                                     row.names=list("GCA I", "GCA II", "SCA"))
    #-----------------------------------------------------------------------------
    # General Combining Ability (gca) Effects
    #-----------------------------------------------------------------------------
    G.I <- rowMeans(Means-mean(Means))
    G.II <- colMeans(Means-mean(Means))
    General<-c(G.I,G.II)
    #-----------------------------------------------------------------------------
    # Specific Combining Ability (sca) Effects
    #-----------------------------------------------------------------------------
    S <- matrix(NA, nrow=n, ncol=m, byrow=TRUE)

    for(i in 1:n)
    {
      for(j in (n+1):(n+m))
      {
        S[i, (j-n)] <- (Means1[i,j-n]-mean(Means))-(rowMeans(Means1)[i]-mean(Means))-(colMeans(Means1)[j-n]-mean(Means))
      }
    }

    dimnames(S)<- dimnames(Means)
    Specific<-S

    list(
      Means              = Means
      , ANOVA              = ANOVA
      , Genetic.Components = Genetic.Components
      , General            = General
      , Specific           = Specific
    )}
