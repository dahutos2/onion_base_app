# Flutter プロジェクト:
## 開発ルール
- `master` ブランチへのプッシュやマージは禁止。
- `developer` ブランチへの直接のプッシュやマージは禁止。
- `developer` ブランチへのマージはプルリクエストを通じてのみ許可。
- プルリクエスト作成時には自動テストと静的解析が行われる。

## アーキテクチャ概要

DDD ✖️ オニオンアーキテクチャ</br>
![image](./source/images/onion_architecture.avif)

### DI (Dependency Injection)
- **di_container.dart**: DIコンテナの定義
### Domain Layer
- **exception**: カスタム例外やリソースに関する定義
- **model**: ドメインオブジェクトの定義
- **repository**: リポジトリインターフェイスの定義
- **service**: ドメインサービスの定義
### Application Layer
- **dto**: Data Transfer Objectsの定義。
- **exception**: カスタム例外やリソースに関する定義
- **service**: ビジネスロジックの補助サービス
- **use_cases**: ビジネスロジックの定義
### Infrastructure Layer
- **api**: 外部サービスやデータアクセスのヘルパー
- **repository_sql**: SQLベースのリポジトリの実装
- **service**: ファイル操作などのサービスの実装
### L10n (Localization)
- **arb files**: 多言語対応のためのARBファイル
### Presentation Layer
- **view**: UIの実装
  - **extensions**: UIの拡張メソッド
  - **page**: 画面のコンポーネント
  - **share**: 共有されるUIリソース
  - **widget**: 再利用可能なUIコンポーネント
- **view_model**: UIのロジックや状態を管理する層
  - **data**: 画面に表示するデータクラスの定義
  - **notifier**: 状態管理のためのNotifierの定義

### 補足

`index.dart`ファイルは各ディレクトリの内容を統合的にインポートするためのファイルです。

## [Makefile](./Makefile)
- アプリアイコン設定
- コードの自動生成
- 多言語の変更の適応

## バージョン管理

### バージョン

- flutter 3.13.4
- dart 3.1.2

### 管理方法

**[`asdf`](https://asdf-vm.com/)を使用する**

`asdf`はプログラミング言語やツールのバージョン管理を行うためのツールであり、</br>
複数の言語やツールのバージョンを1つのフレームワークで管理することができます。`asdf`を使用すると、</br>
プロジェクトごとに異なるバージョンの言語やツールを使うことが容易になります。

Flutterのバージョン管理に`asdf`を使用する場合、以下の手順でセットアップすることができます。

#### 1. `asdf`のインストール

まず、`asdf`自体をインストールします。多くの場合、Homebrewを使用してMacにインストールします。
```bash
brew install asdf
```
#### 2. シェルの設定

使用しているシェル（bash, zshなど）の設定ファイル（`.bashrc`, `.zshrc`など）に以下を追加します。
```bash
. $(brew --prefix asdf)/libexec/asdf.sh
```

#### 3. Flutter/Dartプラグインの追加

`asdf`でFlutterのバージョン管理を行うために、Flutterプラグインを追加します。
```bash
asdf plugin-add flutter
asdf plugin-add dart
```

#### 4. jqコマンドの追加

jqコマンドは、JSONデータから目的の情報を抽出するのに便利な機能を提供しています。なのでjqを追加します。
```bash
brew install jq
```
#### 5. Flutter/Dartのバージョンのインストール

必要なバージョンのFlutterとDartをインストールします。
```bash
asdf install flutter 3.13.4
asdf install dart 3.1.2
```

#### 6. グローバルまたはローカルでのバージョンの設定

インストールしたFlutterとDartのバージョンを、グローバルまたはプロジェクトごとにローカルで設定します。
- グローバルでの設定：
```bash
asdf global flutter 3.13.4
asdf global dart 3.1.2
```
- ローカル（プロジェクトごと）での設定：
```bash
asdf local flutter 3.13.4
asdf local dart 3.1.2
```
ローカルでの設定を行うと、そのディレクトリに`.tool-versions`というファイルが作成され、</br>
そのプロジェクトで使用するFlutterのバージョンが指定されます。

#### 7. 他のバージョンのインストールと切り替え

必要に応じて他のバージョンのFlutterをインストールし、</br>
`asdf global`や`asdf local`コマンドを使用してバージョンを切り替えることができます。

#### 8. IDEの設定

##### VS Code

Code -> Preferences -> Settingsに移動する</br>
Dart: Flutter Sdk Pathsの箇所で「Add Item」ボタンをクリックして、以下を追加する</br>
`/Users/{ユーザー名}/.asdf/installs/flutter/{flutterバージョン}`

##### Android Studio

Settings > Languages & Frameworks > Flutter > Flutter SDK Pathに以下を設定する
Settings > Languages & Frameworks > Dart > Dart SDK Pathに以下を設定する</br>
```
/Users/{ユーザー名}/.asdf/installs/flutter/{flutterバージョン}
/Users/{ユーザー名}/.asdf/installs/dart/{dartバージョン}
```
