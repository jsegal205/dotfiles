# PostgreSQL 14 → 16 Upgrade Guide (macOS / Homebrew)

## Before you start

```bash
# Confirm current version and data directory
psql --version
brew services list | grep postgres
ls /usr/local/var/postgresql@14
```

Back up your databases:

```bash
pg_dumpall -U postgres > ~/postgres14_backup_$(date +%F).sql
```

---

## 1. Install PostgreSQL 16

```bash
brew install postgresql@16
```

---

## 2. Initialize a PostgreSQL 16 data directory

```bash
/usr/local/opt/postgresql@16/bin/initdb \
  --locale=C -E UTF-8 \
  /usr/local/var/postgresql@16
```

---

## 3. Stop the running PostgreSQL 14 service

```bash
brew services stop postgresql@14
```

---

## 4. Run pg_upgrade

`pg_upgrade` migrates the data directory in-place without a dump/restore.

```bash
/usr/local/opt/postgresql@16/bin/pg_upgrade \
  --old-datadir /usr/local/var/postgresql@14 \
  --new-datadir /usr/local/var/postgresql@16 \
  --old-bindir  /usr/local/opt/postgresql@14/bin \
  --new-bindir  /usr/local/opt/postgresql@16/bin \
  --check
```

The `--check` flag does a dry run — no data is moved. If it reports "Clusters are compatible", remove `--check` and run it for real:

```bash
/usr/local/opt/postgresql@16/bin/pg_upgrade \
  --old-datadir /usr/local/var/postgresql@14 \
  --new-datadir /usr/local/var/postgresql@16 \
  --old-bindir  /usr/local/opt/postgresql@14/bin \
  --new-bindir  /usr/local/opt/postgresql@16/bin
```

---

## 5. Start PostgreSQL 16

```bash
brew services start postgresql@16
```

---

## 6. Verify

```bash
psql --version                        # should report 16.x
psql -U postgres -c "SELECT version();"
\l                                    # list databases — all should be present
```

If anything looks wrong, your PostgreSQL 14 data directory is untouched and you can restart the old service:

```bash
brew services stop postgresql@16
brew services start postgresql@14
```

---

## 7. Update statistics and clean up

After confirming everything works, run the post-upgrade steps pg_upgrade generates:

```bash
# Update optimizer statistics (pg_upgrade prints this command after a successful run)
/usr/local/opt/postgresql@16/bin/vacuumdb --all --analyze-in-stages

# Remove the old cluster (pg_upgrade also generates a delete_old_cluster.sh script)
./delete_old_cluster.sh
```

Then uninstall PostgreSQL 14:

```bash
brew services stop postgresql@14   # no-op if already stopped
brew uninstall postgresql@14
```

---

## 8. Update dotfiles

In `brew/main.sh`, change the package and service references from `postgresql@14` to `postgresql@16`:

```bash
# brew/main.sh — PACKAGES array
postgresql@16

# brew/main.sh — SERVICES array
postgresql@16
```
