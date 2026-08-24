# TODO: Centralize MacBook Pro + WSL config

Noted 2026-08-23, to dig into next time.

## Problem

MacBook Pro (`apple/`) and WSL (`ubuntu/`) configs have deviated. Some
changes were made directly on the MacBook and never made it back into
this repo, so this isn't just "diff and merge" - it's "first figure out
what changed on the Mac that isn't captured here yet."

Also: Claude Code config (`~/.claude` - settings.json, memory, output
style/behavior preferences) isn't tracked in this repo at all yet, and
should probably join this centralization effort too. Distinguish what's
safe to share across all machines/projects (e.g. general workflow
preferences) vs. what should stay per-project (e.g. segal-server's "no
Claude co-author in commits" preference, which is project-scoped on
purpose - see that repo's Claude memory).

## When picking this up

1. Diff `apple/` vs `ubuntu/` vs whatever's actually live on each machine
   right now to find drift, not just diff the repo against itself.
2. Whatever gets added/changed must be idempotent and work on both
   WSL/Ubuntu and macOS - a lot of existing scripts here already branch
   by OS (see `fresh-setup.sh`, `ubuntu/wsl-update.sh`), follow that
   pattern.
3. Decide the Claude Code config strategy (what's global vs per-project)
   before just dumping `~/.claude` into this repo wholesale.
