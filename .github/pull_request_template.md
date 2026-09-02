## What changed

<!--
Title this pull request `[Area] Sentence case`, for example:
  [Grammar] Re-vendor the parser from upstream 10fe0054
  [CI] Pin the checkout action to a release SHA
  [Docs] Correct the symbol check command

Then describe the change in three to five sentences. Example:

  The vendored parser was four commits behind upstream and missed the new
  string-escape rule, so files using it highlighted incorrectly. This
  re-vendors `parser.c` and `scanner.c` from upstream commit `10fe0054` using
  the procedure in UPSTREAM.md, and records that SHA as the last reviewed
  commit. `swift build` passes and the symbol check still reports the expected
  exported parser entry point. No public API changed, so this is a minor bump.
-->

## How you verified it

<!--
Name the command you ran and what it showed. A green build is evidence; an
explanation is not. If you re-vendored the parser, say which upstream SHA you
generated from and paste the symbol check output.
-->

## Scope

<!--
Keep one concern per pull request. A re-vendor, a CI bump, and a docs fix are
three pull requests, not one.
-->
