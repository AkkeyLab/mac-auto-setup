---
description: "Use when running gh CLI commands as an AI agent: avoid interactive mode, use --json and --jq for structured output"
---

## `gh` CLI をAIエージェントとして操作するときのルール

インタラクティブモードは高確率で失敗するため、以下を必ず守ること。

### 基本原則

- `GH_PAGER=cat` を先頭に付けてページャーを無効化する
- `gh pr view` / `gh pr list` / `gh issue view` など `--json` をサポートするコマンドは `--json` + `--jq` で必要なフィールドだけ取得する
- `gh api` は `--json` 不要（REST エンドポイントは JSON を返す）；`--paginate` で全件取得し `--jq` で絞り込む
- インタラクティブプロンプトが出ないよう、必要な引数はすべて明示的に指定する

### PRコメントの取得

```bash
# タイムラインコメント（PR全体へのコメント）
GH_PAGER=cat gh pr view <PR番号> --json comments --jq '.comments[] | {author: .author.login, body: .body}'

# レビューコメント（インラインの行コメント）- --paginate で全件取得し --jq で絞り込む
GH_PAGER=cat gh api repos/{owner}/{repo}/pulls/<PR番号>/comments --paginate --jq '.[] | {author: .user.login, body: .body, path: .path, line: .line}'

# レビュー一覧（Approve / Request Changes など）- --paginate で全件取得し --jq で絞り込む
GH_PAGER=cat gh api repos/{owner}/{repo}/pulls/<PR番号>/reviews --paginate --jq '.[] | {author: .user.login, state: .state, body: .body}'
```

`{owner}/{repo}` は以下で取得できる（`-q` は `--jq` のエイリアス）:

```bash
GH_PAGER=cat gh repo view --json nameWithOwner --jq .nameWithOwner
```
