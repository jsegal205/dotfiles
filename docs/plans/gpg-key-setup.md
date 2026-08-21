# GPG key setup: personal + agents key

## Context

This repo automates most of a fresh-machine setup (`fresh-setup.sh` on Mac, manual steps on Ubuntu/WSL) via per-tool modules (`apple/`, `brew/`, `git/`, `zsh/`, each with a `main.sh`). GPG key generation for git commit signing was the one thing left as a fully manual step — `manual-steps.md` said *"I couldn't figure out how to automate this, maybe you will FUTURE Jim!"*, and `ubuntu/install-steps.md` had a hand-walkthrough of the same. Only a single personal signing key existed (`git/.gitconfig` had a placeholder `signingkey = XXXXXXXXXXXXXX` filled in by hand per machine).

Two identities going forward: the personal key (as before), and a second, generic **agents** key for commits made by coding agents (Claude Code today, possibly others later). The recurring pain point was gpg-agent's passphrase cache going cold and an interactive pinentry prompt popping up mid-task, disruptive when an agent is driving the terminal. The fix is to prime/cache the agents key's passphrase once per shell session (via zshrc), not to eliminate its passphrase entirely.

## Scope decisions

- Both keys are regenerated fresh per machine by default (matches how the personal key already worked) — **not** reused/copied across machines by default.
- Agent key keeps a real passphrase; a zshrc check primes gpg-agent's cache for it once per session so subsequent automated commits don't hit pinentry.
- The agents key is **not** wired up as the actual git signer yet — global `user.signingkey` stays the personal key. The agents key is generated and kept unlocked/available for future use (e.g. if per-repo/agent signer switching is added later).
- A companion export script writes both keys (armored, public+private) to a gitignored folder for manual transfer to another machine, if desired.
- New keys use `ed25519` rather than RSA4096 (smaller/faster, stronger security margin, sign/cert-only which is all git commit signing needs).

## `gpg/` module

**`gpg/main.sh`**
- `PERSONAL_UID="Jim Segal <jsegal205@gmail.com>"` and `AGENT_UID="Jim Segal (agents) <jsegal205+agents@gmail.com>"` as vars at the top (`+agents` is a Gmail alias — same inbox, can be added/verified as a second email on GitHub).
- For each UID: skip if `gpg --list-secret-keys "$UID"` already finds a key; otherwise `gpg --quick-generate-key "$UID" ed25519 cert,sign <expiry>` (default `2y`). Interactive only for the passphrase prompt.
- Patches the personal key's long key ID into the **deployed** `~/.gitconfig`'s `signingkey` line; the repo's tracked `git/.gitconfig` keeps its placeholder (per-machine value).
- Copies `gpg/gpg-agent.conf` to `~/.gnupg/gpg-agent.conf`.
- Prints both public keys at the end with a reminder to add them to GitHub → Settings → SSH and GPG keys.

**`gpg/gpg-agent.conf`** — long cache TTL, same shape as `ubuntu/gpg-agent.conf`.

**`gpg/export.sh`** — exports both identities' public+private keys (armored) to `gpg/backup/`, gitignored, with a warning that the private files are sensitive and meant for a deliberate manual transfer only.

## Wiring

- `fresh-setup.sh`: `./gpg/main.sh` right after `./git/main.sh`.
- `zsh/.zshrc` and `ubuntu/.zshrc`: after `export GPG_TTY=$(tty)`, prime the agents key's gpg-agent cache (check-then-act: `--pinentry-mode=cancel` to test the cache, real sign only if that fails).
- `manual-steps.md`: GPG section replaced with a pointer to the automated `gpg/main.sh` output + the GitHub upload step (still manual, needs a browser).
- `ubuntu/install-steps.md`: manual `gpg --full-generate-key` walkthrough replaced with a pointer to `../gpg/main.sh`.

## Verification

- `bash -n` on the new scripts.
- Run `gpg/main.sh`: confirm existing personal key is skipped, agents key is created (one passphrase prompt).
- `~/.gitconfig` signingkey unchanged (personal key already existed).
- Source updated `zsh/.zshrc` in a fresh subshell; confirm priming block runs once, no second prompt on a second source in the same session.
- `git commit --allow-empty` after priming: no passphrase modal.
- `gpg/export.sh` output lands in `gpg/backup/`, excluded by `.gitignore`.
