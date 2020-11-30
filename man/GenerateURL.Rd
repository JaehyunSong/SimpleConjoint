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
GenerateURL(data, Task = 3, Profile = 2, Randomized = TRUE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php",
            ShortURL = FALSE,
            Design = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{data.frame、list、または属性名が1行目、2行目から各属性の水準が記入されたcsvファイルの経路（URL可）}
  \item{Task}{試行回数}
  \item{Profile}{プロフィールの数}
  \item{Randomized}{TRUEの場合、属性の順番はランダム化され、FALSEの場合、csvに記入された順番で表示されます。}
  \item{DefaultURL}{SimpleConjoint.phpのURLを指定します。指定がない場合、宋のサーバーのURLとなります。自分のサーバーを用いる場合は指定して下さい。宋のサーバーが可愛そうです。}
  \item{ShortURL}{TRUEの場合、https://is.gd/経由で圧縮されたURLを返します。そのままQualtricsに埋め込めます。インターネット接続が必要です。}
  \item{Design}{cjointパッケージで分析を行う際に必要なデザインリストを返します。このオプションがTRUEの場合、URLは返還されません。}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
* DesignパラメーターがFALSEの場合、URLが返還されます。URLをコピーし、QualtricsのWeb Serviceに貼り付けます。

* DesignパラメーターがTRUEの場合、リストが返還されます。cjointパッケージでそのまま利用できます。
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Jaehyun Song (Doshisha University) <tintstyle@gmail.com / https://www.jaysong.net>
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
GenerateURL(data = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv",
            Task = 5)

# data.frameを使用する場合
## デザインdata.frameの作成
## 余るセルは欠損値でなく空character（""）で補完
DesignData <- data.frame(性別 = c("男性", "女性", "", "", ""),
                         年齢 = c("20", "30", "40", "50", ""),
                         学歴 = c("高校", "大学", "大学院", "", ""),
                         年収 = c("0", "300万", "500万", "700万", "1000万"))

## 試行回数4回、プロフィール2個、属性の順番ランダム化、短縮URL出力
GenerateURL(data = DesignData,
            Task = 4, Profile = 2, Randomized = TRUE, ShortURL = TRUE)

# listを使用する場合
## デザインdata.frameの作成
## 余るセルは欠損値でなく空character（""）で補完
DesignData <- list(性別 = c("男性", "女性"),
                   年齢 = c("20", "30", "40", "50"),
                   学歴 = c("高校", "大学", "大学院"),
                   年収 = c("0", "300万", "500万", "700万", "1000万"))

## 試行回数5回、プロフィール3個、属性の順番ランダム化なし、短縮URL出力
GenerateURL(data = DesignData,
            Task = 5, Profile = 3, Randomized = FALSE, ShortURL = TRUE)

# デザインリストを取得する場合
DesignList <- GenerateURL("http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv",
                          Design = TRUE)
print(DesignList)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Conjoint Analysis}% use one of  RShowDoc("KEYWORDS")
