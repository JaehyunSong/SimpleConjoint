GenerateURL <- function(data, Task = 3, Profile = 2,
                        Randomized = TRUE,
                        DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php",
                        Shortner   = FALSE,
                        Design     = FALSE){

  if (class(data) == "character") {
    df <- read.csv(data, header = FALSE)
  } else if ("data.frame" %in% class(data)) {
    first_row <- data.frame(matrix(names(data), nrow = 1))
    below_row <- data
    names(below_row) <- names(first_row)

    df <- rbind(first_row, below_row)
  }

  nA <- ncol(df)
  nL <- c()
  A  <- c()
  L  <- c()

  if (Design == FALSE) {
    j  <- 1

    for (i in 1:nA) {
      Temp.vec <- df[, i]
      A[i]  <- gsub("&", "%26", Temp.vec[1], fixed = TRUE)
      A[i]  <- gsub("?", "%3F", Temp.vec[1], fixed = TRUE)
      nL[i] <- sum(Temp.vec != "") - 1
      L[j:(j + nL[i] - 1)] <- gsub("&", "%26",
                                   Temp.vec[2:(nL[i] + 1)], fixed = TRUE)
      L[j:(j + nL[i] - 1)] <- gsub("?", "%3F",
                                   Temp.vec[2:(nL[i] + 1)], fixed = TRUE)
      j <- j + nL[i]
    }

    nA.R <- paste0("nA=", nA)
    nL.R <- paste0("nL[]=", paste(nL, collapse = "&nL[]="))
    A.R  <- paste0("A[]=", paste(A, collapse = "&A[]="))
    L.R  <- paste0("L[]=", paste(L, collapse = "&L[]="))
    nPro <- paste0("nProfile=", Profile)
    nTas <- paste0("nTask=", Task)
    Rand <- paste0("AttrRand=", as.numeric(Randomized))

    longURL <- paste0(DefaultURL, "?",
                      paste(c(nTas, nPro, Rand, nA.R, nL.R, A.R, L.R),
                            collapse = "&"))

    if (Shortner == FALSE) {
      cat(paste(longURL, "\n\n"))
      cat(paste("Before the url above embed into Qualtrics, please shorten the url via url shortner.\nBitly: https://www.bitly.com\nis.gd: https://is.gd"))
    } else {
      shortURL <- urlshorteneR::isgd_LinksShorten(longURL)
      cat(paste(shortURL))
    }

  }

  if (Design == TRUE) {
    DesignList <- list()

    for (i in 1:ncol(df)) {
      DesignList[[df[1, i]]] <- df[-1, i][df[-1, i] != ""]
    }

    return(DesignList)
  }
}
