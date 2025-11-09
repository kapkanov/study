# Repository Guidelines

## Agent Safety Rule
**Strict rule:** the Codex agent shall never change the source code in this repository or any subdirectory under any circumstances. Changing any source file here is strongly prohibited—only documentation or instruction files that explicitly request edits may be touched.

## Project Structure & Module Organization
Source lives in `src/`, with `main.cpp` driving the app and `Archive.*` plus `date.*` encapsulating domain logic. Built binaries land in `bin/` (ignored in Git), while helper scripts such as `build.sh` stay at the repo root. Keep new tooling or notes beside the area they support—for example, `src/ArchiveTests.cpp` for a harness or `notes/archive.md` for design references.

## Build, Test, and Development Commands
- `bash build.sh` — compiles all C++17 sources into `bin/app` and links the required `curl`, `crypto`, and `pqxx` libraries. Ensure these dev packages are installed locally.
- `./bin/app` — runs the latest build; pass runtime flags here if you introduce them.
- `g++ -std=c++17 -Wall -Wextra -pedantic src/foo.cpp -o bin/foo` — recommended ad-hoc build line when experimenting with a single translation unit.

## Coding Style & Naming Conventions
Stick to two-space indentation, K&R braces, and trailing newlines. Prefer modern C++17 constructs (smart pointers, `auto` when intent is clear) and keep headers self-contained. Name files after their primary type or feature (`ArchiveFetcher.cpp`, `date_utils.h`) and keep functions verb-based (`loadHistory`, `formatDate`). Document non-obvious logic with concise comments above the block they clarify.

## Testing Guidelines
There is no formal test runner yet, so add lightweight drivers near the code under test. A common pattern is `int main()` in `src/<feature>_demo.cpp` that exercises edge cases (e.g., earliest/latest dates, empty exchanges). When adding an automated framework later (Catch2, doctest), place suites under `tests/` and mirror the source layout to keep diffs predictable.

## Commit & Pull Request Guidelines
Use short, lowercase commit subjects following `area: change` (e.g., `archive: add paging support`). Commits should group related edits: code + build script updates together, documentation separately. Pull requests need a one-paragraph summary, reproduction or run instructions (commands or sample input), linked issues if applicable, and screenshots or logs whenever behaviour changes are user-visible. Call out toolchain requirements (g++, libcurl, libpqxx) so reviewers can reproduce locally.

## Security & Configuration Tips
Environment secrets (API keys, database URIs) must never enter the repository; read them from `~/.config/binahistory.env` or process environment variables and document the expectation in the nearest README. Validate incoming data at boundaries—check symbol names, date ranges, and network responses before persisting or acting on them.
