# iddom

local indesign dom viewer

オリジナルの
[CS-CS5.5のオブジェクトモデル図（JavaScript）](http://indesign.cs5.xyz/dom_about.html)
および
[InDesignオブジェクトモデル図 CS5-CC2015 ベータ版](http://indesign.cs5.xyz/dom/about.html)

に対して変換処理

- 検索フォームつける
- ファイルのエンコーディングをcp932からutf-8にする(v1)
- ヘッダの`<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">` をutf-8にする(v1)
- 内部リンクの `<base target="_blank">` を削除

してローカル環境で使えるようにする


## ビルド

namespaceに CS-CS5版のv1とCS5-CC2015版のv2を設定

wgetをインストール

rake buildタスクを実行

~~~
$ bundle install
$ rake v1:build
or
$ rake v2:build
~~~

## 起動

~~~
$ rackup
~~~

[http://localhost:9292/](http://localhost:9292/) をひらく

OSXだったらビルドした後に

[Pow: Zero-configuration Rack server for Mac OS X](http://pow.cx/) してもいいかも