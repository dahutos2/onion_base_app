.PHONY: \
	run rl10n assets icon

# flutterを実行
run:
	flutter run --release

# .arbで定義した文言を使用するためのコードを自動作成
l10n:
	flutter gen-l10n

# assets内のファイルにアクセスするコードを自動生成
assets:
	flutter pub run build_runner build --delete-conflicting-outputs

# アプリにアイコンを設定する
# ※生成される画像の大きさが誤っている場合があります
icon:
	flutter pub run flutter_launcher_icons