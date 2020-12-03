# SimpleConjoint 0.1.1
URL Generator for Conjoint Experiments with Simple Designs

---

## 開発者情報
* Song Jaehyun（そん　じぇひょん）
* 同志社大学文化情報学部　助教
* https://www.jaysong.net
* jasong@mail.doshisha.ac.jp

## 履歴

* 2020/12/03: 外部サーバーと完全に独立した[SimpleConjoint.js](https://github.com/JaehyunSong/SimpleConjoint.js)のベータ版を公開しました。
* 2020/11/30: `data`の実引数としてlist型が使用可能になりました。
* 2020/11/23: 短縮URLを生成する`ShortURL`引数を追加しました。
* 2020/11/19: 既定URLを修正しました。
* 2019/02/06: [矢内勇生](https://yukiyanai.github.io)先生にご指摘いただきまして、php側の致命的なエラーを修正しました。矢内勇生先生に感謝申し上げます。
* 2019/01/29: Design引数を追加しました。
* 2019/01/28: 公開

## 概要

* phpが使える自前のサーバーがない
* 水準の制約や出現確率の重み付けのない単純なコンジョイント実験がやりたい

このような方のためのパッケージです。

---

## インストール

1. {devtools}、または{remotes}パッケージを導入

```r
install.packages("devtools")
# または
install.packages("remotes")
```

2. {SimpleConjoint}のインストール

```r
devtools::install_github("JaehyunSong/SimpleConjoint")
# または
remotes::install_github("JaehyunSong/SimpleConjoint")
```

3. パッケージの読み込み
```r
library(SimpleConjoint)
```

---

## 使い方

パッケージの読み込み後、`?GenerateURL`で確認してください。

```r
GenerateURL(data, Task = 3, Profile = 2, Randomized = TRUE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php",
            ShortURL = FALSE,
            Design = FALSE)
```

* `data`: data.frame、または属性名が1行目、2行目から各属性の水準が記入されたcsvファイルの経路（URL可）
* `Task`: 試行回数（既定値 = 3）
* `Profile`: プロフィールの数（既定値 = 2）
* `Randomized`: `TRUE`の場合、属性の順番はランダム化され、FALSEの場合、csvに記入された順番で表示されます。（既定値 = `TRUE`）
* `DefaultURL`: `SimpleConjoint.php`のURLを指定します。指定がない場合、宋のサーバーのURL（既定値）となります。自分のサーバーを用いる場合は指定して下さい。宋のサーバーが可愛そうです。
* `ShortURL`: `TRUE`の場合、[is.gd](https://is.gd/)経由で圧縮されたURLを返します。そのままQualtricsに埋め込めます。インターネット接続が必要です。（既定値 = `FALSE`）
* `Design`: {cjoint}パッケージで分析を行う際に必要なデザインリストを返します。このオプションが`TRUE`の場合、URLは返還されません。（既定値 = `FALSE`）

### 例1

**Input**

```r
library(SimpleConjoint)

# 試行回数4回、プロフィール2個、属性の順番ランダム化の場合
GenerateURL(data = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv", 
            Task = 4, Profile = 2, Randomized = TRUE, ShortURL = FALSE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php")
```

**Output**

```
http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php?nTask=5&nProfile=2&AttrRand=1&nA=4&nL[]=6&nL[]=5&nL[]=4&nL[]=7&A[]=スープ&A[]=麺&A[]=具材&A[]=値段&L[]=醤油&L[]=塩&L[]=味噌&L[]=豚骨&L[]=トマト&L[]=ビール&L[]=極太麺&L[]=太麺&L[]=中細麺&L[]=細麺&L[]=こんにゃく&L[]=チャーシュー&L[]=メンマ&L[]=プリン&L[]=ネギ&L[]=400円&L[]=500円&L[]=600円&L[]=700円&L[]=800円&L[]=900円&L[]=1000円 

Before the url above embed into Qualtrics, please shorten the url via url shortner.
Bitly: https://www.bitly.com
is.gd: https://is.gd
```

* ここでURLのみコピーし、URLを短縮します。[Bit.ly](https://bitly.com/)、[is.gd](https://is.gd/)などが代表的なサービスです。以降の手順は、この短縮されたURLを使用し、[通常のコンジョイント分析](https://www.jaysong.net/studynote/methodology/qualtrics_conjoint/)と同じです。QualtricsのUIの方では2バイト文字をGET methodで送ることができますが、実際の場面では出来なようなので、URLを短縮する必要があります ([矢内勇生](https://yukiyanai.github.io)先生の指摘により修正しました。)。

### 例2

* `ShortURL = TRUE`を指定する場合、[is.gd](https://is.gd/)経由で短縮URLを返します。短縮URLはQualtricsのWeb Serviceに埋め込むことができます。インターネットが使える環境で使用してください。URL短縮には{urlshorteneR}パッケージを使用しています。

**Input**

```r
# デザインdata.framen作成
# 余るセルは欠損値でなく空character（""）で補完。補完しないとベクトルがリサイクルされるため、必ず補完してください。
DesignData <- data.frame(性別 = c("男性", "女性", "", "", ""),
                         年齢 = c("20", "30", "40", "50", ""),
                         学歴 = c("高校", "大学", "大学院", "", ""),
                         年収 = c("0", "300万", "500万", "700万", "1000万"))

# デザインはcsv経路でなく、data.frameそのまま
# 試行回数3回、プロフィール2個、属性の順番ランダム化、短縮URL出力
GenerateURL(data = DesignData, 
            Task = 3, Profile = 2, Randomized = TRUE, ShortURL = TRUE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php")
```

**Output**

```
# 出力結果
Short URL: https://is.gd/4Yk64B 

Long URL : http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php?nTask=3&nProfile=2&AttrRand=1&nA=4&nL[]=2&nL[]=4&nL[]=3&nL[]=5&A[]=性別&A[]=年齢&A[]=学歴&A[]=年収&L[]=男性&L[]=女性&L[]=20&L[]=30&L[]=40&L[]=50&L[]=高校&L[]=大学&L[]=大学院&L[]=0&L[]=300万&L[]=500万&L[]=700万&L[]=1000万
```

### 例3

**Input**

* list型を`data`の実引数として使用する場合
  * ここで作成するリストは{cjoint}パッケージのデザインリストとして使用可能です。

```r
# デザインlistの作成
DesignData <- list(性別 = c("男性", "女性"),
                   年齢 = c("20", "30", "40", "50"),
                   学歴 = c("高校", "大学", "大学院"),
                   年収 = c("0", "300万", "500万", "700万", "1000万"))

## 試行回数5回、プロフィール3個、属性の順番ランダム化なし、短縮URL出力
GenerateURL(data = DesignData,
            Task = 5, Profile = 3, Randomized = FALSE, ShortURL = TRUE)
```

**Output**

```
# 出力結果
Short URL: https://is.gd/4Yk64B 

Long URL : http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php?nTask=3&nProfile=2&AttrRand=1&nA=4&nL[]=2&nL[]=4&nL[]=3&nL[]=5&A[]=性別&A[]=年齢&A[]=学歴&A[]=年収&L[]=男性&L[]=女性&L[]=20&L[]=30&L[]=40&L[]=50&L[]=高校&L[]=大学&L[]=大学院&L[]=0&L[]=300万&L[]=500万&L[]=700万&L[]=1000万
```

---

* `DefaultURL`パラメーターは自分のサーバーに[`SimpleConjoint.php`](https://raw.githubusercontent.com/JaehyunSong/SimpleConjoint/master/Script/SimpleConjoint.php)を置く際に使って下さい。指定なない場合、宋のサーバーを使います。

* 最初のパラメーターは属性と水準が格納されているdata.frame、またはcsvファイルです。たとえば、以下の形式となります。
  * 空白のセルは欠損値（`NA`）でなく、空character（`""`）で埋めてください。

|属性名1|属性名2|属性名3|属性名4|
|---|---|---|---|
|水準1-1|水準2-1|水準3-1|水準4-1|
|水準1-2|水準2-2|水準3-2|水準4-2|
|水準1-3||水準3-3|水準4-3|
|||水準3-4||
|||水準3-5|| 

* csvファイルは自分のパソコンからでも、URLからでも取得できます。サンプルファイルとして[http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv](http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv)を使ってみて下さい。
  * `data`引数のクラスがcharacterの場合、その経路のcsvファイルを取得し、data.frameクラスの場合はそのまま使えます。

* {cjoint}パッケージを用いて分析を行う場合、属性と水準情報が含まれたリストオブジェクトが必要となります。引数に`Design = TRUE`を指定するとリスト型が返還され、そのまま{cjoint}パッケージで使用可能です。

---

## 今後の予定

* 属性ブロックの指定
  * ブロック間のランダマイズ + 一部のブロック位置の固定
  * ブロック内のランダマイズ + ランダマイズしないブロックの指定
* SimpleConjoint for Shiny
* URLでなく、Qualtricsに直接埋め込めるJavaScriptコードの生成
