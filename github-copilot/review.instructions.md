---
description: "Use when performing code review: Japanese, confirm scope (uncommitted vs branch diff) first, structured output by severity"
---

コードレビューは必ず日本語で行ってください。

レビュー前に必ず確認:
- 未コミットの差分か
- ブランチ差分か

手順:

1. 変更ファイル一覧を確認:
   - 未コミット: `git diff --name-only`
   - ブランチ差分: `git diff --name-only <base-branch>...<feature-branch>`

2. ファイルごとに差分を一時ファイルへ保存:
   - 未コミット: `git diff -- <file> > /tmp/review-<safe-file-name>.diff`
   - ブランチ差分: `git diff <base-branch>...<feature-branch> -- <file> > /tmp/review-<safe-file-name>.diff`

3. 読む前に差分サイズを確認:
   `wc -l /tmp/review-<safe-file-name>.diff`

4. 差分が大きい場合は順次チャンク読み込み:
   `sed -n '<start>,<end>p' /tmp/review-<safe-file-name>.diff`

5. `tail` や `head` で変更の一部を読み飛ばさない

6. すべてのファイルのすべてのチャンクをレビューする

7. レビュー完了後に一時ファイルを削除する

観点:
- 正しさ
- リグレッション
- セキュリティ
- パフォーマンス
- 保守性
- テスト不足

出力:
- 重要度順に整理
- 修正案を具体的に提示
