# iddom

local indesign dom viewer

こちらの [オリジナル](http://indesign.cs5.xyz/dom_about.html) に

変換処理

- 検索フォームつける
- ファイルのエンコーディングをcp932からutf-8にする
- ヘッダの`<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">` をutf-8にする
- 内部リンクの `<base target="_blank">` を削除

してローカル環境で使えるようにする


## ビルド
1. ビルドスクリプトを実行
    - オリジナルのhtml.zip ( [zip](http://indesign.cs5.xyz/extra/iddomjs_CS55.zip) ) をダウンロード
    - [SpecialCharacters](http://indesign.cs5.xyz/iddomjs/SpecialCharacters.html) を別途ダウンロード
2. 変換処理をして inddomjs フォルダに展開


~~~
$ bundle install
$ ruby build.rb
~~~

## 起動

~~~
$ rackup
~~~

[http://localhost:9292/](http://localhost:9292/) をひらく

OSXだったらビルドした後に

[Pow: Zero-configuration Rack server for Mac OS X](http://pow.cx/) してもいいかも