# Contributing to `tree-sitter-zig-spm`

## Scope

This repository is a packaging wrapper, not a product. It exists so Swift
projects can depend on the upstream Zig tree-sitter grammar without running
`tree-sitter-cli` at build time. It contains no original grammar work.

**External contributions are not accepted here.** Grammar behavior belongs to
the upstream project at
<https://github.com/tree-sitter-grammars/tree-sitter-zig>.
Send grammar fixes there, where they reach every consumer instead of this
wrapper alone.

Packaging faults are in scope, and you can open an issue on this repository for
them: a build that fails, a missing exported symbol, or a `Package.swift`
source list that does not match the vendored files. Report a security problem
through [`.github/SECURITY.md`](.github/SECURITY.md) rather than a public
issue.

This repo is a thin **Swift Package Manager wrapper** around the
[`tree-sitter-zig`](https://github.com/tree-sitter-grammars/tree-sitter-zig) tree-sitter grammar. The generated parser
(`Sources/TreeSitterZig/src/parser.c` and any `scanner.c`) is **vendored** so
SPM can build it without `tree-sitter-cli`. This grammar has no external scanner.

There is almost nothing to "develop" here — the value is in keeping the
vendored parser honest, building cleanly, and being safe to depend on.

## Prerequisites

- Swift 6.0+ toolchain (`swift --version`)

## Build & verify

```sh
swift build
```

To confirm the parser entry point is actually exported:

```sh
nm "$(find .build -name parser.c.o | head -1)" | grep ' T _tree_sitter_'
```

You should see `T _tree_sitter_zig`. If the grammar ships an
external scanner, `scanner.c.o` must also export the five
`*_external_scanner_*` symbols, and `scanner.c` must be listed in
`Package.swift`'s `sources`.

## Updating the grammar (re-vendoring)

This is the main reason to touch this repo. **Read [UPSTREAM.md](UPSTREAM.md)** —
it documents the exact upstream source, the last reviewed commit, and the
step-by-step re-vendor procedure. In short:

1. Clone the upstream grammar and capture `git rev-parse HEAD`.
2. Copy `src/parser.c`, `src/scanner.c` (if present), and `src/tree_sitter/*.h`
   into `Sources/TreeSitterZig/src/`.
3. If the grammar gained/lost an external scanner, update the `sources` list
   in `Package.swift` to match.
4. Update **Last reviewed commit** and the date in `UPSTREAM.md`.
5. `swift build` and run the symbol check above.

### Supply-chain rules (non-negotiable)

- A multi-hundred-KB `parser.c` **is** the supply chain. Review the diff. If
  you can't justify a chunk, don't commit it.
- Never bump the vendored parser without recording the exact source SHA in
  `UPSTREAM.md`. Reviewers rely on it to diff against upstream.
- Keep CI action pins (`uses: actions/checkout@<sha>`) — Dependabot proposes
  updates under review; don't unpin them.

## Releasing

- Versioning is **SemVer**; tags are plain `X.Y.Z` (no `v` prefix).
- A grammar re-vendor is at least a **minor** bump (parser behavior changes).
- Tag and push: `git tag X.Y.Z && git push origin X.Y.Z`.

## Pull requests

- Keep PRs focused (a re-vendor, a CI bump, a docs fix — not all three).
- CI (`swift build`) must pass.
- Sign off your commits (`git commit -s`) to assert the
  [DCO](https://developercertificate.org/).

## Security

Found malicious code in a vendored `parser.c`, a `Package.swift` escape, or a
CI bypass? Do **not** open a public issue — follow
[`.github/SECURITY.md`](.github/SECURITY.md).

## Pull request titles

Title every pull request `[Area] Sentence case`. The area is one bracketed word
naming the part you touched, and the sentence that follows says what the change
does, capitalized like a sentence and with no trailing period.

```
[Grammar] Re-vendor the parser from upstream a1b2c3d
[CI] Pin the checkout action to a release SHA
[Docs] Correct the exported symbol check
```

Common areas here are `Grammar`, `Packaging`, `CI`, and `Docs`. Describe the
change in three to five sentences in the body, and say which command you ran to
verify it. [`.github/pull_request_template.md`](.github/pull_request_template.md)
prompts for both.
