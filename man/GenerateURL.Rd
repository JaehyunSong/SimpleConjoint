\name{GenerateURL}
\alias{GenerateURL}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
コンジョイントのためのURLを生成
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GenerateURL(file, Taks = 3, Profile = 2, Randomized = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file}{属性名が1行目、2行目から各属性の水準が記入されたcsvファイル}
  \item{Task}{試行回数}
  \item{Profile}{プロフィールの数}
  \item{Randomized}{TRUEの場合、属性の順番はランダム化され、FALSEの場合、csvに記入された順番で表示されます。}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
URLが返還されます。URLをコピーし、QualtricsのWeb Serviceに貼り付けます。
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Jaehyun Song (Waseda University)
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# サンプルcsvの中身を確認するためには
# read.csv("http://www.jaysong.net/Qualtrics/SimpleConjoint/ExampleDesign2.csv")

# 上記の属性と水準で試行回数5回、プロフィール数2つ、属性のランダム化
GenerateURL("http://www.jaysong.net/Qualtrics/SimpleConjoint/ExampleDesign2.csv", Task = 5, Profile = 2, Randomized = TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Conjoint Analysis}% use one of  RShowDoc("KEYWORDS")
