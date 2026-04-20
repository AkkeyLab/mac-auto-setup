---
description: "Use when running gh CLI commands as an AI agent: avoid interactive mode, use --json and --jq for structured output"
---

## `gh` CLI をAIエージェントとして操作するときのルール

インタラクティブモードは高確率で失敗するため、以下を必ず守ること。

### 基本原則

- `GH_PAGER=cat` を先頭に付けてページャーを無効化する
- `gh pr` / `gh issue` などのサブコマンドでは `--json` フラグで構造化データとして受け取る（`gh api` は常に JSON を返すため不要）
- `--jq` で必要なフィールドだけ抽出することで出力を小さく保つ
- インタラクティブプロンプトが出ないよう、必要な引数はすべて明示的に指定する

### PRコメントの取得

```bash
# タイムラインコメント（PR全体へのコメント）
GH_PAGER=cat gh pr view <PR番号> --json comments --jq '.comments[] | {author: .author.login, body: .body}'

# レビューコメント（インラインの行コメント）
GH_PAGER=cat gh api repos/{owner}/{repo}/pulls/<PR番号>/comments

# レビュー一覧（Approve / Request Changes など）
GH_PAGER=cat gh api repos/{owner}/{repo}/pulls/<PR番号>/reviews
```

`{owner}/{repo}` は以下で取得できる:

```bash
gh repo view --json nameWithOwner -q .nameWithOwner
```
