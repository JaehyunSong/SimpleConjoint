# SimpleConjoint 0.1.0
URL Generator for Conjoint Experiments with Simple Designs

---

## 履歴

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

1. devtoolsパッケージを導入
  * `install.packages("devtools")`
2. SimpleConjointのインストール
  * `devtools::install_github("JaehyunSong/SimpleConjoint")`
3. パッケージの読み込み
  * `library(SimpleConjoint)`

---

## 使い方

パッケージの読み込み後、`?GenerateURL`で確認してください。

**例**

```
library(SimpleConjoint)

# 試行回数4回、プロフィール2個、属性のランダム化の場合
GenerateURL(data = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv", 
            Task = 4, Profile = 2, Randomized = TRUE, ShortURL = FALSE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php")
```

* 実行すると、以下のような結果が返ってきます。

`http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php?nTask=4&nProfile=2&AttrRand=1&nA=4&nL[]=6&nL[]=5&nL[]=4&nL[]=7&A[]=スープ&A[]=麺&A[]=具材&A[]=値段&L[]=醤油&L[]=塩&L[]=味噌&L[]=豚骨&L[]=トマト&L[]=ビール&L[]=極太麺&L[]=太麺&L[]=中細麺&L[]=細麺&L[]=こんにゃく&L[]=チャーシュー&L[]=メンマ&L[]=プリン&L[]=ネギ&L[]=400円&L[]=500円&L[]=600円&L[]=700円&L[]=800円&L[]=900円&L[]=1000円`

* ここでURLのみコピーし、URLを短縮します。[Bit.ly](https://bitly.com/)、[is.gd](https://is.gd/)などが代表的なサービスです。以降の手順は、この短縮されたURLを使用し、[通常のコンジョイント分析](http://tintstyle.cafe24.com/studynote/methodology/qualtrics_conjoint/)と同じです。QualtricsのUIの方では2バイト文字をGET methodで送ることができますが、実際の場面では出来なようなので、URLを短縮する必要があります ([矢内勇生](https://yukiyanai.github.io)先生の指摘により修正しました。)。

* `ShortURL = TRUE`を指定する場合、[is.gd](https://is.gd/)経由で短縮URLを返します。

```
# デザインdata.framenの読み込み
DesignData <- read.csv("http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv")

# 試行回数4回、プロフィール2個、属性のランダム化の場合
GenerateURL(data = DesignData, 
            Task = 4, Profile = 2, Randomized = TRUE, ShortURL = TRUE,
            DefaultURL = "http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php")
```

```
# 出力結果
Short URL: https://is.gd/BbwxBk 

Long URL : http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/SimpleConjoint.php?nTask=4&nProfile=2&AttrRand=1&nA=4&nL[]=6&nL[]=5&nL[]=4&nL[]=7&A[]=スープ&A[]=麺&A[]=具材&A[]=値段&L[]=醤油&L[]=塩&L[]=味噌&L[]=豚骨&L[]=トマト&L[]=ビール&L[]=極太麺&L[]=太麺&L[]=中細麺&L[]=細麺&L[]=こんにゃく&L[]=チャーシュー&L[]=メンマ&L[]=プリン&L[]=ネギ&L[]=400円&L[]=500円&L[]=600円&L[]=700円&L[]=800円&L[]=900円&L[]=1000円
```

* `DefaultURL`パラメーターは自分のサーバーに`SimpleConjoint.php`を置く際に使って下さい。指定なない場合、宋のサーバーを使います。
    * 自分のサーバーに導入する場合、[このファイル](https://www.dropbox.com/s/rfxlu8k0ctgjl9p/SimpleConjoint.php?dl=0)を使って下さい。

* 最初のパラメーターは属性と水準が格納されているdata.frame、またはcsvファイルです。たとえば、以下の形式となります。

|属性名1|属性名2|属性名3|属性名4|
|---|---|---|---|
|水準1-1|水準2-1|水準3-1|水準4-1|
|水準1-2|水準2-2|水準3-2|水準4-2|
|水準1-3||水準3-3|水準4-3|
|||水準3-4||
|||水準3-5|| 

* CSVファイルは自分のパソコンからでも、URLからでも取得できます。サンプルファイルとして[http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv](http://tintstyle.cafe24.com/Qualtrics/SimpleConjoint/ExampleDesign2.csv)を使ってみて下さい。
  * `data`引数のクラスがcharacterの場合、その経路のcsvファイルを取得し、data.frameクラスの場合はそのまま使えます。

* `cjoint`パッケージを用いて分析を行う場合、属性と水準情報が含まれたリストオブジェクトが必要となります。引数に`Design = TRUE`を指定するとリスト型が返還され、そのまま`cjoint`パッケージで使用可能です。
