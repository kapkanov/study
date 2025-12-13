# Repository Guidelines

## Project Structure & Module Organization
Code and notes are grouped by topic so each learning strand stays focused. Advent of Code lives in `aoc/2023/`: day folders (`1`, `2`, `3`) hold solutions, while helpers such as `strmod.erl` sit beside them. Assembly divides into `assembly/gas/` for GNU chapters and `assembly/nasm/` for NASM samples with build scripts. Erlang experiments (`erlang/messenger`, `erlang/pingpong.erl`) explore OTP messaging. LeetCode solutions stay in per-problem directories (e.g. `leetcode/80-remove-duplicates/eighty.c`, `leetcode/392-is-subsequence/subseq.erl`), and `algos/` waits for future notebooks.

## Build, Test, and Development Commands
- `gcc -Wall -Wextra -std=c11 -o eighty leetcode/80-remove-duplicates/eighty.c` builds the C solution for quick smoke tests.
- `erlc -o aoc/2023 aoc/2023/strmod.erl` compiles shared Advent of Code helpers; run with `erl -pa aoc/2023 -noshell -s strmod reverse -s init stop`.
- `bash assembly/nasm/env/build.sh` or `bash assembly/nasm/stosb-vs-mov/build.sh` assemble NASM samples; GAS chapters use `as` or `gcc` from their folder.

## Coding Style & Naming Conventions
Keep two-space indents across C, Erlang, and assembly. Use K&R braces, align columns only when helpful, and name files by problem or chapter (`80-remove-duplicates`, `chapter-5`). Erlang modules stay snake_cased with verb-first public functions, while assembly keeps lowercase labels and targeted inline comments.

## Testing Guidelines
Keep small test harnesses near the code. For C problems, maintain lightweight `main` drivers that cover boundary inputs. Erlang modules can expose helper functions or be run with `erl -noshell -pa <dir> -eval "io:format(\"~p~n\", [Module:Function(...)])" -s init stop`. Assembly binaries are verified by running them against sample files; log notable command lines in the local README.

## Commit & Pull Request Guidelines
Use short, lowercase commits (`area: concise change`). Group related files and avoid mixing languages unless the fix spans them. Pull requests should summarise behaviour changes, list reproduction steps or sample inputs, mention required tools (gcc, nasm, erl), and link issues or runtime output when helpful.

## Tooling & Environment
Ensure local toolchains cover `gcc` (C11), Erlang/OTP, NASM, and GNU binutils. Scripts assume a POSIX shell; document any extra dependencies in the nearest README so contributors can bootstrap quickly.

## Learning Notes
Capture short refreshers alongside the code—use nearby `readme.md` files (e.g. `assembly/gas/chapter-5/readme.md`) or create concise `.md` companions for new patterns. When revisiting a topic, append key takeaways and links so future you regains context fast.


