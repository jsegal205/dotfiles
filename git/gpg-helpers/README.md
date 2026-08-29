# GPG commit-signing helpers

Guards against a specific failure mode: `commit.gpgsign = true` (see
`../.gitconfig`) means every `git commit` asks `gpg-agent` to sign, which
asks `pinentry` for the passphrase if it isn't cached. `pinentry` sometimes
tries to draw its prompt on a display/tty that isn't actually visible (no X
server in WSL, or a curses prompt on a pty nobody is watching) — most often
because **Claude Code, running via a terminal, triggered the commit itself**.
When that happens the prompt doesn't fail, it just hangs forever, and
`gpg-agent` serializes pinentry requests — so that one stuck process blocks
every later signing attempt, from every shell, until it's killed.

Installed automatically by `../main.sh`. Requires `user.signingkey` to
already be set (see `../../ubuntu/install-steps.md`'s "GPG commit signing"
section) and `gpg-agent.conf` copied for a long cache TTL, otherwise you'll
hit this constantly instead of rarely.

## The three pieces

- **`check-pinentry-stuck`** (→ `~/.local/bin`, on `PATH`) — diagnoses a
  *currently* stuck pinentry: lists any running pinentry process, how long
  it's been running, and the `kill <pid>` command to unblock `gpg-agent`.
- **`find-stuck-gpg-modal-process`** (→ `~`) — one-line wrapper around the
  above, named to be findable at `ls ~` months later when you've forgotten
  where the real script lives.
- **`will-git-commit-prompt-gpg`** (→ `~`) — a *preflight* check: asks
  `gpg-agent` (via `gpg-connect-agent KEYINFO <keygrip>`, read-only) whether
  the signing key's passphrase is currently cached, before a commit ever
  attempts to sign. Exit code doubles as the answer: `0` = cached, safe to
  sign silently; `1` = not cached, a commit right now would try to prompt.

## The pre-commit hook

`pre-commit` (→ `~/.git-hooks-global/pre-commit`, wired up via
`git config --global core.hooksPath ~/.git-hooks-global`) runs
`will-git-commit-prompt-gpg` before every commit, in every repo on the
machine, and **blocks the commit** (no commit created) if the passphrase
isn't cached — it does not let `git commit` reach the pinentry step at all.

This is deliberately a hard stop rather than a warning: most commits here
are made by Claude Code, which can't see or react to an invisible/stuck
pinentry prompt any better than a human who isn't watching that shell. When
a commit gets blocked, the message tells you what to do: run something like
`echo x | gpg --clearsign >/dev/null` from a terminal you can actually see,
enter the passphrase there (this caches it in `gpg-agent`), then retry the
commit. If a pinentry is already stuck rather than just about to prompt, run
`find-stuck-gpg-modal-process` instead.

If a specific repo later sets its own local `core.hooksPath` (e.g. husky),
that local setting wins over this global one for that repo.
