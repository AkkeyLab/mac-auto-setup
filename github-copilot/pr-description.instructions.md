---
description: "Use when writing pull request titles and descriptions: Japanese, template-based, write body to temp file, assign @me"
---

Pull Requestのタイトルと説明は必ず日本語で記述してください。

ルール:

1. テンプレートがある場合はそれをベースにする
2. PR本文は一度テキストファイルに書く前提で構成する
3. シェルに直接埋め込まない

記載内容:

- 変更内容の概要
- 背景・目的
- 実装ポイント
- 動作確認
- 注意点

Markdown互換で書くこと

PRコマンドの形式:

```
gh pr create --title "タイトル" --body-file /tmp/pr-body.md --assignee @me
```

`--assignee @me` を必ず付与すること。`@me` は `gh` CLI の認証済みユーザーとして解決されるため、Git設定の参照は不要。
