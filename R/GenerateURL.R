GenerateURL <- function(file, Task = 3, Profile = 2,
                        Randomized = TRUE,
                        DefaultURL = "http://www.jaysong.net/Qualtrics/SimpleConjoint/SimpleConjoint.php"){

  df <- read.csv(file, header = FALSE, stringsAsFactors = FALSE)
  nA <- ncol(df)
  nL <- c()
  A  <- c()
  L  <- c()

  j  <- 1

  for (i in 1:nA) {
    Temp.vec <- df[, i]
    A[i]  <- gsub("&", "%26", Temp.vec[1], fixed = TRUE)
    A[i]  <- gsub("?", "%3F", Temp.vec[1], fixed = TRUE)
    nL[i] <- sum(Temp.vec != "") - 1
    L[j:(j + nL[i] - 1)] <- gsub("&", "%26", Temp.vec[2:(nL[i] + 1)], fixed = TRUE)
    L[j:(j + nL[i] - 1)] <- gsub("?", "%3F", Temp.vec[2:(nL[i] + 1)], fixed = TRUE)
    j <- j + nL[i]
  }

  nA.R <- paste0("nA=", nA)
  nL.R <- paste0("nL[]=", paste(nL, collapse = "&nL[]="))
  A.R  <- paste0("A[]=", paste(A, collapse = "&A[]="))
  L.R  <- paste0("L[]=", paste(L, collapse = "&L[]="))
  nPro <- paste0("nProfile=", Profile)
  nTas <- paste0("nTask=", Task)
  Rand <- paste0("AttrRand=", as.numeric(Randomized))

  result <- paste0(DefaultURL, "?",
                   paste(c(nTas, nPro, Rand, nA.R, nL.R, A.R, L.R),
                         collapse = "&"))

  return(result)
}
