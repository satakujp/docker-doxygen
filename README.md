# DockerからDoxygenを実行する。
[Doxygen](https://www.doxygen.nl/index.html)はC++で開発されているドキュメント自動生成ツールです。C言語、C#、Python、Javaなど様々な言語に対応しています。
このレポジトリではDoxygenをDockerで動作させることで、OSに依存しない実行環境を作ることを目的にしています。

## Doxygenの設定
`doxygen -g`コマンドで初期化されてたDoxyfileに、以下の変更を加えています。

|Doxyfileの変更箇所|変更後|備考|
|------------|----|----|
|94|OUTPUT_LANGUAGE = Japanese|出力ファイルの言語|
|488|EXTRACT_ALL            = YES|プライベートメンバや静的メソッド含めてすべて出力対象とする。|
|855|WARN_LOGFILE           = "warn_log.txt"|ログファイル名|
|867|INPUT                  = /doxygen/src|ドキュメントを作成ソースファイルが保存されいているパス|
|946|RECURSIVE              = YES|再帰的に処理する|
|1077|SOURCE_BROWSER         = YES|ソースファイルのコードを生成されたドキュメントに含める|
|1793|GENERATE_LATEX         = NO|LATEX形式のドキュメントを生成しない|
|2496|CALL_GRAPH             = YES|関数の呼び出しグラフを生成する|
|2508|CALLER_GRAPH           = YES|関数の被呼び出しグラフを生成する|

# 使い方
## Dockerfileの変更（任意）
Dockerfileではコンテナ内の実行ユーザを`doxygen`ユーザにしていますが、このユーザのUIDとGIDをホストOSの実行ユーザと合わせてください。ホストOSの実行ユーザのUID等は`id`コマンドで確認できます。

```
ARG UID=1001
ARG GID=1000
```
これを合わせておくと、Doxygenで生成されたドキュメントファイルのオーナーがホストOSの実行ユーザーとなり、ファイルの移動や削除がやりやすくなります。

## Doxyfileの変更（任意）
Doxyfileの35行目、`PROEJCT_NAME`の値を生成するソースコードの名前に合わせてください。生成されたドキュメントのタイトルに使われます。

```
PROJECT_NAME           = "サンプルプロジェクト"
PROJECT_NUMBER         = "1.0.0"
PROJECT_BRIEF          = "Doxygen動作確認のためのソースコード"
PROJECT_LOGO           = 画像ファイルを指定するとドキュメントに表示されますが、Dockerの環境では対応していません。
```

## ソースコードの保存と実行（必須）
1. レポジトリの`src`フォルダにドキュメントを生成したソースコードを保存します。
2. `docker-compose run --rm  doxygen`を実行します。
3. `dst/html`フォルダーが作成され、`index.html`から生成されたドキュメントを開きます。

