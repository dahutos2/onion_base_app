# base_app
プロジェクトの元となるAppです。<br>
DDD ✖️ オニオンアーキテクチャ
![image](./source/images/onion_architecture.avif)
## レポジトリ
[base_app](https://github.com/dahutos2/base_app)
## ディレクトリ構造
### 全体
<details>
<summary>クリックして下さい。</summary>

```
├── README.md
├── analysis_options.yaml
├── android
├── assets
│   └── images
├── base_app.iml
├── build
├── ios
├── l10n.yaml
├── lib
├── linux
├── macos
├── pubspec.lock
├── pubspec.yaml
├── sh
│   ├── app_launcher.sh
│   ├── freezed_run.sh
│   └── gen_l10n.sh
├── source
│   └── images
│       └── onion_architecture.avif
├── test
├── web
└── windows

384 directories, 796 files
```
</details>

### lib
<details>
<summary>クリックして下さい。</summary>

```
│   ├── domain_layer
│   │   ├── domain.dart
│   │   ├── exception
│   │   │   ├── domain_exception.dart
│   │   │   ├── exception.dart
│   │   │   └── resource.dart
│   │   ├── model
│   │   │   ├── base
│   │   │   │   ├── base_id.dart
│   │   │   │   ├── base_object.dart
│   │   │   │   ├── base_string.dart
│   │   │   │   └── domain_model_base.dart
│   │   │   ├── domain_model.dart
│   │   │   └── sample
│   │   │       ├── domain_model_sample.dart
│   │   │       ├── sample.dart
│   │   │       ├── sample_id.dart
│   │   │       └── sample_name.dart
│   │   ├── repository
│   │   │   ├── domain_repository.dart
│   │   │   ├── i_base_repository.dart
│   │   │   └── i_sample_repository.dart
│   │   └── service
│   │       ├── common_service.dart
│   │       ├── domain_service.dart
│   │       └── i_sample_factory.dart
│   ├── index.dart
│   ├── infrastructure_layer
│   │   ├── api
│   │   │   ├── db_helper.dart
│   │   │   └── infrastructure_api.dart
│   │   ├── infrastructure.dart
│   │   ├── repository
│   │   │   ├── infrastructure_repository.dart
│   │   │   └── sample_repository.dart
│   │   └── service
│   │       ├── infrastructure_service.dart
│   │       └── sample_factory.dart
│   ├── init.dart
│   ├── l10n
│   │   └── ja.arb
│   ├── main.dart
│   ├── presentation_layer
│   │   ├── extensions
│   │   │   ├── context_extension.dart
│   │   │   └── presentation_extensions.dart
│   │   ├── notifier
│   │   │   ├── current_page_notifier.dart
│   │   │   ├── edit_sample_notifier.dart
│   │   │   ├── presentation_notifier.dart
│   │   │   ├── sample_notifier.dart
│   │   │   └── search_sample_notifier.dart
│   │   ├── page
│   │   │   ├── common
│   │   │   │   ├── base.dart
│   │   │   │   └── presentation_page_common.dart
│   │   │   ├── init.dart
│   │   │   ├── page01
│   │   │   │   ├── page01.dart
│   │   │   │   ├── presentation_page01.dart
│   │   │   │   └── sample_detail.dart
│   │   │   ├── page02
│   │   │   │   ├── page02.dart
│   │   │   │   └── presentation_page02.dart
│   │   │   ├── page03
│   │   │   │   ├── page03.dart
│   │   │   │   └── presentation_page03.dart
│   │   │   └── presentation_page.dart
│   │   ├── presentation.dart
│   │   ├── share
│   │   │   ├── assets.dart
│   │   │   ├── colors.dart
│   │   │   ├── icons.dart
│   │   │   ├── presentation_share.dart
│   │   │   ├── routes.dart
│   │   │   └── styles.dart
│   │   └── widget
│   │       ├── common
│   │       │   ├── dialog
│   │       │   │   ├── presentation_widget_common_dialog.dart
│   │       │   │   ├── show_alert_dialog.dart
│   │       │   │   ├── show_contents_dialog.dart
│   │       │   │   └── show_create_dialog.dart
│   │       │   ├── footer.dart
│   │       │   ├── header.dart
│   │       │   └── presentation_widget_common.dart
│   │       ├── page01
│   │       │   ├── dialog
│   │       │   │   ├── presentation_widget_page01_dialog.dart
│   │       │   │   └── show_delete_dialog.dart
│   │       │   ├── page01_footer.dart
│   │       │   ├── page01_header.dart
│   │       │   ├── parts
│   │       │   │   ├── edit_text_box.dart
│   │       │   │   ├── presentation_widget_page01_parts.dart
│   │       │   │   ├── sample_contents.dart
│   │       │   │   ├── sample_edit_contents.dart
│   │       │   │   └── search_text_box.dart
│   │       │   ├── presentation_widget_page01.dart
│   │       │   ├── sample_add_button.dart
│   │       │   ├── sample_detail.dart
│   │       │   └── sample_list.dart
│   │       ├── page02
│   │       │   ├── page02.dart
│   │       │   └── presentation_widget_page02.dart
│   │       ├── page03
│   │       │   ├── page03.dart
│   │       │   └── presentation_widget_page03.dart
│   │       └── presentation_widget.dart
│   └── usecase_layer
│       ├── dto
│       │   ├── sample_dto.dart
│       │   └── usecase_dto.dart
│       ├── exception
│       │   ├── exception.dart
│       │   ├── resource.dart
│       │   └── usecase_exception.dart
│       ├── service
│       │   └── usecase_service.dart
│       ├── usecase.dart
│       └── usecases
│           ├── copy_samples
│           │   ├── copy_samples_usecase.dart
│           │   ├── i_copy_samples_usecase.dart
│           │   └── usecase_usecases_copy_samples.dart
│           ├── get_all_sample
│           │   ├── get_all_sample_usecase.dart
│           │   ├── i_get_all_sample_usecase.dart
│           │   └── usecase_usecases_get_all_sample.dart
│           ├── get_new_sample
│           │   ├── get_new_sample_usecase.dart
│           │   ├── i_get_new_sample_usecase.dart
│           │   └── usecase_usecases_get_new_sample.dart
│           ├── remove_sample
│           │   ├── i_remove_sample_usecase.dart
│           │   ├── remove_sample_usecase.dart
│           │   └── usecase_usecases_remove_sample.dart
│           ├── update_sample
│           │   ├── i_update_sample_usecase.dart
│           │   ├── update_sample_usecase.dart
│           │   └── usecase_usecases_update_sample.dart
│           └── usecase_usecases.dart
```
</details>

### test
<details>
<summary>クリックして下さい。</summary>

```
├── test
│   ├── domain_layer
│   │   ├── model
│   │   │   └── book
│   │   │       ├── sample_id_test.dart
│   │   │       ├── sample_name_test.dart
│   │   │       └── sample_test.dart
│   │   └── service
│   │       ├── common_service_test.dart
│   │       └── common_service_test.mocks.dart
│   ├── infrastructure_layer
│   │   ├── repository
│   │   │   ├── sample_repository_test.dart
│   │   │   └── sample_repository_test.mocks.dart
│   │   └── service
│   │       ├── sample_factory_test.dart
│   │       └── sample_factory_test.mocks.dart
│   ├── presentation_layer
│   │   └── widget_test.dart
│   └── usecase_layer
│       ├── dto
│       │   └── sample_dto_test.dart
│       ├── service
│       └── usecases
│           ├── copy_samples
│           │   ├── copy_samples_usecase_test.dart
│           │   └── copy_samples_usecase_test.mocks.dart
│           ├── get_all_sample
│           │   ├── get_all_sample_usecase_test.dart
│           │   └── get_all_sample_usecase_test.mocks.dart
│           ├── get_new_sample
│           │   ├── get_new_sample_usecase_test.dart
│           │   └── get_new_sample_usecase_test.mocks.dart
│           ├── remove_sample
│           │   ├── remove_sample_usecase_test.dart
│           │   └── remove_sample_usecase_test.mocks.dart
│           └── update_sample
│               ├── update_sample_usecase_test.dart
│               └── update_sample_usecase_test.mocks.dart
```
</details>

## バージョン管理
### バージョン
- flutter 3.7.1
### 管理方法
**`asdf`を使用する**

`asdf`はプログラミング言語やツールのバージョン管理を行うためのツールであり、<br>
複数の言語やツールのバージョンを1つのフレームワークで管理することができます。<br>
`asdf`を使用すると、プロジェクトごとに異なるバージョンの言語やツールを使うことが容易になります。

Flutterのバージョン管理に`asdf`を使用する場合、以下の手順でセットアップすることができます。
#### 1. `asdf`のインストール
まず、`asdf`自体をインストールします。多くの場合、Homebrewを使用してMacにインストールします。
```bash
brew install asdf
```
#### 2. シェルの設定
使用しているシェル（bash, zshなど）の設定ファイル（`.bashrc`, `.zshrc`など）に以下を追加します。
```bash
. $(brew --prefix asdf)/asdf.sh
```
#### 3. Flutterプラグインの追加
`asdf`でFlutterのバージョン管理を行うために、Flutterプラグインを追加します。
```bash
asdf plugin-add flutter
```
#### 4. Flutterのバージョンのインストール
必要なバージョンのFlutterをインストールします。
```bash
asdf install flutter 3.7.1
```
#### 5. グローバルまたはローカルでのバージョンの設定
インストールしたFlutterのバージョンを、グローバルまたはプロジェクトごとにローカルで設定します。
- グローバルでの設定：
```bash
asdf global flutter 3.7.1
```
- ローカル（プロジェクトごと）での設定：
```bash
asdf local flutter 3.7.1
```
ローカルでの設定を行うと、そのディレクトリに`.tool-versions`というファイルが作成され、<br>
そのプロジェクトで使用するFlutterのバージョンが指定されます。
#### 6. 他のバージョンのインストールと切り替え
必要に応じて他のバージョンのFlutterをインストールし、<br>
`asdf global`や`asdf local`コマンドを使用してバージョンを切り替えることができます。