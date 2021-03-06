  コピペ君は、レシビなどWeb上にあるものをファイルにコピペしたら、栄養
計算してくれるソフトです。Windowsでなくても、MacでもLinuxでも使えます。
（ただし、私はMacは持ってないので、Macでの動作確認はしていません)

 テキストファイルに書かれたレシピをJRubyで一行ずつ読み込んで、Excelの
成分表ファイルから成分値を抽出して計算させるソフトです。ソフトしてはす
ごく地味なソフトです。今回のバージョンから、2015年に公開された７訂食品
成分表のExcelファイルを用いるようになりました。現在は２０１９年７訂の
最新のデータに対応しています。

 なぜこんなソフトを作ろうと思ったかは、Motivation.md に書きましたが、
簡単に言えば、普通の栄養計算ソフト、多少便利でも、それでも毎回メニュー
づくりは面倒。どんどん楽したい。その楽をする可能性が、コピペ君は無限大
にあります。だから最初は手作業部分でGUIの自動化に負けますが、だんだん
工夫次第で自動化できます。これが普通ののGUIつかった栄養ソフトにできな
いので、めんどくさがり屋の私には耐えられなかったので、作っちゃいました。
とはいっても、楽する工夫はこれからです。

　Excelで書かれた成分表のデータにJavaのapache POIを使って、アクセスし
てJRubyを使ってRubyのスクリプトを実行しています。JavaのSDKとJRubyをイ
ンストールして下さい。Windowsの場合のインストールの仕方は、INSTALL.md
に書かれてます。


　　　　　　　　　Windowsの場合

インストールしたいフォルダー（ディレクトリー）で

git clone https://github.com/eclipse2ant/e_keisan/

展開してください。新しく　e_keisan　というフォルダー（ディレクトリー）
ができます。コマンドプロンプトを起動して、カレントディレクトリーをこの
e_keisan にしてください。わからない場合は、e_keisanフォルダーのなかの
cmd.exe〔黒いアイコンのもの）をクリックするとコマンドプロンプトが開き
ます。以下このコマンドプロンプトで作業します。


このプロンプト上で、　

keisan demo.txt

と打って実行すると。demo.txtの中身が計算されて、カロリー計算してくれま
す。



　　　　　　　　　　Windows以外

適当なディレクトリーで、

git clone https://github.com/eclipse2ant/e_keisan/

を実行すると　e_keisan デレクトリーが作られてます、その中に入って
環境変数 E_kEISAN に　このe_keisanの　絶対パス　つまり　
installed_directory/e_keisan を登録して下さい。あと
installed_directory/e_keisan をPATHに入れておいたほうが良いと思います。

それを行って

keisan.rb demo.txt　

を実行します


今回はたまたまdemo.txtを用いましたが、ご自分でエディター作られた、勝手
なファイルで構いません。書式はdemo.txtを参照下さい。尚、漢字コードは
utf-8を用いて下さい。WindowsでのデフォルトはShift-JISですが、保存する
際にutf-8で保存してください。


demo.txt　の中身は

```
納豆とにんじん入りハンバーグ[2]:  
牛ひき肉（赤身）　　１５０ｇ  
納豆　　５０ｇ 
にんじん　　５０ｇ  
万能ねぎ　　３０ｇ  
パン粉　　大さじ２  
塩　少々  
こしょう　少々  
#青じそ　　4枚  
サラダ油　　小さじ２  
  
  
なすのもみ漬け[2]:  
なす　　１００ｇ  
みそ　　小さじ１  
練り辛子　　小さじ１／２  
#バルスィート（カロリーゼロ）　　小さじ1/2  

おにぎり2種[2]:  
ごはん　３００ｇ  
焼きのり　　1枚  
梅干し　　　　小2個  
しょうゆ　　1.5ｇ  
だし汁　　1.5ｇ  
しょうゆ　小さじ1/2  
```  
  
です。これによって出力されるのは、以下の出力例です。



＜出力例＞
```
納豆とにんじん入りハンバーグ[2]:  
牛ひき肉(赤身)  150.0g  
納豆  50.0g  
にんじん  50.0g  
万能ねぎ  30.0g  
パン粉  8.0g  
塩  0.5g  
こしょう  0.2g  
#青じそ  4枚  
サラダ油  8.0g  
----------------------------------  
521.4 kcal (260.7 kcal)  
  
(タンパク質;21.2g)(塩分;0.4g)  
(DM交換表; 0.2 0.0 1.8 0.0 0.5 0.2 0.0)  
  
なすのもみ漬け[2]:  
なす  100.0g  
みそ  6.0g  
練り辛子  3.0g  
#バルスィート(カロリーゼロ)  小さじ1/2  
----------------------------------  
42.6 kcal (21.3 kcal)  
  
(タンパク質;1.0g)(塩分;0.5g)  
(DM交換表; 0.0 0.0 0.0 0.0 0.0 0.1 0.1)  
  
おにぎり2種[2]:  
ごはん  300.0g  
焼きのり  3.0g  
梅干し  12.0g  
しょうゆ  1.5g  
だし汁  1.5g  
しょうゆ  3.0g  
----------------------------------  
516.8 kcal (258.4 kcal)  

(タンパク質;4.6g)(塩分;1.7g)  
(DM交換表; 3.2 0.0 0.0 0.0 0.0 0.0 0.0)  
  
Total:1080.8 kcal (540.4 kcal)  
  
(タンパク質;26.8g)(塩分;2.6g)  
(DM交換表; 3.3 0.0 1.8 0.0 0.5 0.3 0.1)  
```  
  
あと、すべての成分表の値を計算しています。今は表示させていませんが
```
Vector[540.3985, 2261.7495, 246.2885, 26.801600000000004, 22.1054,
15.848199999999999, 14.7567, 3.7917999999999994, 6.53436, 3.7539,
53.41, 70.1728, 62.85390000000001, 1.096, 3.7029999999999994, 5.339,
4.6989, 1016.0400000000001, 798.6274999999999, 76.28, 80.4525,
289.00750000000005, 3.9244499999999993, 5.11325, 0.44645,
0.7692999999999999, 42.988, 6.157, 0.6295000000000001, 129.117, 0.0,
886.509, 2484.6839999999997, 18.171999999999997, 2940.4689999999996,
247.442, 0.0, 1.35, 0.11800000000000002, 4.015, 1.379,
193.23000000000002, 0.20001000000000002, 0.4258800000000001,
6.132700000000001, 11.971799999999998, 0.4666500000000001,
1.8435000000000001, 113.23, 2.5195000000000003, 7.898999999999999,
14.001, 2.5703500000000004, 0.0, 0.015, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
0.2, 315.0, 3.3365000000000005, 0.024749999999999998,
1.8093750000000002, 0.0, 0.46068749999999997, 0.31, 0.06975]
```

から、自由に表示させられます。Rubyは　Matrix module というのがあって、
これでベクトルが実現出きるので、ベクトルで計算させています。1行 n 列の
行列なので、行列計算を行って、将来的には、栄養判定、栄養指導も可能です。



----------------------------------------------------------------------



プログラムはできてますが、まだまだ、いろいろカスタマイズしてあげないと
いけない部分があります。次の二つの部分です。


1．nanatei.listというファイルが、食品名と成分表のデータをつなぐインデッ
クスファイルになってますが、このインデックスファイルに載ってないと食品
がないといってしまいますので、名前をちゃんと載せてあげる必要があります。


nanatei.list　で、

りんご,りんご ,りんご 生,813


となっていれば、　りんご　という食材のデータは813にあるとわかりますが、
食品によっては、

```
,りんご ,りんご 生,813
```
と見出しが書かれてない場合があります。この場合　見出しを書いてあげれば、
数字を拾うことができます。（この数字が成分表のどこに書かれてるかを示す
数字です）半角カンマは重要でので、消さないでください。


また　リンゴで計算させたいときは、
```
りんご,りんご ,りんご 生,813
リンゴ,りんご ,りんご 生,813
```
のように、いろんな見出しを追加してあげても大丈夫です。好きな呼び名で、
その食材の数値を拾ってこれます。

```
りんご(皮あり),りんご ,りんご 生,813
```
という括弧も使えます。ただし必ず半角を使用してください。

〔注意）　レシビのファイルは、全角で書いてもかまいません。途中の処理で、
記号、英数字、空白文字は全て半角に変換しています。従って、nanatei.list
では　半角で括弧を書かないと、文字列が一致せず、数字を拾ってくれなくて、
食品が見つからないというエラーになります。


　今回ののバージョンから、 他の人のnanatei.listから情報を取り込んだり、
いろいろ操作できるツールをRubyのスクリプトでつくりました。tool フォル
ダ（ディレクトリー）にあります。尚、Windowsの場合のRubyのインストール
についてはINSTALL.md を見て下さい。

- find.rb: 指定したフィールドが連続して同じ行を表示する  
- mysort.rb: 指定したフィールドに関して行をソートする  
- add-list.rb: ひとの見出しに書かれて自分の見出しファイルにないレシピに
出る食品名の見出しを取り込む  
- grep.rb: いわゆるgrep コマンド　パターンにマッチする行を表示する  
- mydiff.rb: diffコマンド　２つのファイルの違いを表示する  
- cut-empty.rb: 第一フィールドが空欄の行を除外してすべての行を表示する  


例えば
```
./cut-empty.rb nanatei.list |./mysort.rb -n 0 | ./dfind.rb -n 0 
```
とすれば、見出しが重複してるものを列挙することが出来ます。




2.　レシビなどではグラム書かれてなく　大1個とか書かれてます、これを自
動的にグラムに変換して計算するようにしてますが、この変換テーブルを作っ
てあげる必要があります。libフォルダーのなかのunitフォルダーを見ていた
だくと、何をやっているかわかると思いまが、。


例えば　りんご　大1個　 

なら　まず　大#個　に変換され　これに対応するファイルは　unit.rb に書
いてます 。取り決めてるのは、この場合は　　dai_ko になります。 そして、
このファイル　dai_ko

例えば　
 ```
りんご,60 
```
とか、書いてあるので、この数字を拾ってきます。

従って、こういう仕組みになっているので、いくらでも自由に変えられます。 

例えば、dai_ko ガない場合、大＃個との対応を定義してやって、そして、
dai_ko というファイルを作って、そのなかに　りんごの数値を書いてあげれ
ばよいわけです。 大抵は、ファイルがあって、そのファイルに　食品と数値
を書けばすむと思います。 





＊エラーメッセージが出るのは、次の４つです。

１．食品の見出しがない場合　----　上記の要領で、見出しをつけてください。
どこにつけるべきか検索は、メモ帳やエディターの検索や　grep.rb を使えば
できます。


grep.rb キーワード　nanatei.list

で探してくれます。

2. 単位のファイルがない場合。　　例えば　#羽　に対応するファイルがない
場合は、libフォルダーの


unit_file.rb に　

```
# -*- coding: utf-8 -*-
@@u2f = {

'大#'=>'dai_', 
'大#個'=>'dai_ko',
'中#個'=>'tyu_ko',
'小#個'=>'syo_ko', 
'#個'=>'_ko', 
'#本'=>'_hon',
'小#'=>'syo_',
'#束'=>'_taba',
'#cc'=>'_cc',
'#ml'=>'_ml',
'大さじ#'=>'osaji_',
'小さじ#'=>'kosaji_',
'小さじ#弱'=>'kosaji_',
'大さじ#杯'=>'osaji_',
'小さじ#杯'=>'kosaji_',
'大匙#'=>'osaji_',
'小匙#'=>'kosaji_',
'#枚'=>'_mai',
'全形#枚'=>'zenkei_mai',
'小#本'=>'syo_hon',
'#カップ'=>'_cup',
'#缶'=>'_kan',
'#切れ'=>'_kire',
'#合'=>'_go',
'#かけ分'=>'_kakebun',
'#かけ'=>'_kake',

'適当'=>'tekitou',
'適量'=>'tekiryo',
'適宜'=>'tekigi',

'少々'=>'syosyo',
'小#パック'=>'syo_pakku'
}
```

対応表が書かれているので、この中に　'#羽'=>'_wa'  を例えば
```
# -*- coding: utf-8 -*-
@@u2f = {

'大#'=>'dai_', 
'大#個'=>'dai_ko',
   .
   .
'適量'=>'tekiryo',
'適宜'=>'tekigi',

'少々'=>'syosyo',
'#羽'=>'_wa',
'小#パック'=>'syo_pakku'
}
```

のように追加してください。（半角カンマを忘れないでください、いわゆる　
ハッシュ（連想配列）と呼ばれるものです。



3.　単位のファイルのなかに、その食材の記載がない場合　
```
リンゴ　大1個
```

で、dai_ko というファイルに、リンゴ,60  のように、対応するグラム数を半
角で記載してください、この際も半角カンマをつけることを忘れないでくださ
い。


4.　レシビのファイル名を間違えた場合------ファイルが見つからないので、
見つからないというエラーが英語で表示されます


-----------------------------------------------------------------

＜必要なもの＞

エディター


＜使い方＞


demo.txt のようにメモ帳かエディターで書いて

keisan ファイル名

または

keisan.rb ファイル名

で結果が出力されます。


* なお、著作権は、GPL的なものを考えてます。
