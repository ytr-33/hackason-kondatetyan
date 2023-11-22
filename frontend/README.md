# Flutter
## 環境構築
### 環境構築手順

インストール手順は、以下のサイト参考。

[https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/06_chapter1_environment](https://zenn.dev/kazutxt/books/flutter_practice_introduction/viewer/06_chapter1_environment)

1. Gitをインストールする。
2. FlutterSDK(バージョン：3.13.9)をインストールしてパスを通す。
3. Android Studioをインストール。
4. エミュレーターを登録する（デフォルトでブラウザによる起動は可能。Android等のモバイルで確認をしない場合は、エミュレーターの登録手順は不要）。

## Flutterの起動手順（VSCODEの場合）
1. デバイスを起動（右下から選択可能。エミュレーターは事前にAndroid Studioで設定が必要）。
2. 1.の起動を確認してから、main.dart（libフォルダ直下にあり。）を実行（Flutter run　コマンドでも起動可能。コマンドで起動すると、Hot reloadやHot restart　の操作がひと手間。デバックのボタンからの起動を推奨。）

* 問題がなければ起動します。起動しない場合　Flutter analyze　コマンドで、コード上の問題の有無の確認をしたり、 Flutter doctor コマンドで、そもそものFlutterの設定の問題点を確認します。また、依存関係に問題がある場合は、　Flutter pub get コマンドで、パッケージの依存関係を更新する必要がある場合があります。


# 画面遷移図
## figma

Figmaで画面遷移図を作成しました。

以下URLをクリックすると確認できる予定です。（Figmaは無料です。必要に応じてアカウント登録が必要かもしれません。）
https://www.figma.com/file/ju3KfPjggRB5OYTCIKjFxX/%E3%81%93%E3%82%93%E3%81%A0%E3%81%A6%E3%81%A1%E3%82%83%E3%82%93%E3%83%A1%E3%82%A4%E3%83%B3?type=design&node-id=54695%3A327&mode=design&t=cRcQWLa7YHseIFqv-1