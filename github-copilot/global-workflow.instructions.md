---
applyTo: "**"
description: Global workflow rules
---

Language rules:

- Use Japanese for all user-facing communication, including explanations and code reviews.
- Use Japanese for pull request titles and descriptions.
- Use English for commit messages.
- Use English for code and identifiers unless explicitly requested otherwise.

---

When the user asks you to implement something and create a pull request:

1. Create and switch to a new branch.
   - `feature/<short-name>` or `fix/<short-name>`
   - kebab-case

2. Implement the requested changes.

3. Commit in logical units. Follow `commit-message.instructions.md` for formatting rules.
   - After running `git commit`, wait for the terminal to finish before proceeding.
   - Pre-commit hooks (e.g. linters, formatters) may run and cause a delay — do not assume the commit is done until the prompt returns.

4. Push the branch.

5. Create PR using `gh`. Follow `pr-description.instructions.md` for title/body rules.

6. Delete temporary file after success.

7. Report results to the user in Japanese.

---

When the user asks for code review, follow `review.instructions.md`.
