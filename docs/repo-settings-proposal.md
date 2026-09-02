# Repository settings proposal

This file **proposes** changes to GitHub repository settings. It does not apply
them. Repository and organization settings are the founder's to change, so
treat every item below as a recommendation waiting on a decision.

Written during the org-wide repository hygiene sweep on 2026-09-01.

## What this repository is

`tree-sitter-zig-spm` vendors the generated parser for the upstream Zig tree-sitter
grammar so Swift Package Manager can build it. Every commit to date is from a
single maintainer or from Dependabot. The repository has no stars, no forks, no
external pull requests, and has never had an issue filed on it. It is public so
that Swift Package Manager can resolve it as a dependency and so hosted CI runs
without a paid plan, not because it invites collaboration.

## Proposed changes

| Setting | Today | Proposed | Why |
| --- | --- | --- | --- |
| Issues | Enabled | **Keep enabled** | A consumer hitting a genuine packaging fault needs somewhere to report it, and the cost of an unused tracker is zero. |
| Discussions | Disabled | Keep disabled | Nothing to discuss that does not belong upstream. |
| Wiki | Check and disable if enabled | Disabled | `README.md`, `CONTRIBUTING.md`, and `UPSTREAM.md` are the documentation. A wiki is a second place for the same facts to drift. |
| Projects | Check and disable if enabled | Disabled | No planning happens in this repository. |
| Pull requests from non-members | Allowed | **Restrict to organization members** | A drive-by pull request against a vendored `parser.c` is a supply-chain risk that review cannot cheaply catch. Grammar changes belong upstream, and `CONTRIBUTING.md` now says so. |
| Branch protection on `main` | Verify | Require the CI status check and a pull request | Prevents an accidental direct push to the branch consumers resolve from. |
| Merge strategy | Verify | Squash only, delete branch on merge | Keeps history one commit per change, matching the rest of the org. |

## Deliberately not proposed

- **Archiving.** The package is a live dependency of a consuming Swift project.
  Archiving it would make the dependency unresolvable for writes and signal
  abandonment that is not true.
- **Making it private.** Swift Package Manager consumers resolve it over HTTPS.
  Private would break that path without a token.
