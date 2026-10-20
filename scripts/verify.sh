#!/usr/bin/env bash
# =============================================================================
# verify.sh - READ-ONLY end-state checker for "Linux Command Line Activities"
# Purpose : Confirm the files/users/archives the task should have produced exist.
# Safety  : Makes NO changes to the system and never executes script.sh.
# Run as  : the same NORMAL user who did the lab (not root):  bash scripts/verify.sh
# =============================================================================
set -u

PASS=0; FAIL=0
pass() { echo "[PASS] $1"; PASS=$((PASS + 1)); }
fail() { echo "[FAIL] $1"; FAIL=$((FAIL + 1)); }
info() { echo "[INFO] $1"; }
check() { # check "description" command args...
  local desc="$1"; shift
  if "$@" >/dev/null 2>&1; then pass "$desc"; else fail "$desc"; fi
}

if [ "$(id -u)" -eq 0 ]; then
  echo "Run this as your normal user, not root (the lab files live in your home directory)." >&2
  exit 2
fi

PD="/tmp/practice_dir"
echo "== Linux Command Line Activities - verification (read-only) =="
echo "User: $(whoami)   Home: $HOME"
echo

echo "-- Activity 1: navigation --"
check "/tmp/practice_dir exists" test -d "$PD"

echo "-- Activities 2 & 4: demo.txt copy --"
check "copy of demo.txt exists in $PD" test -f "$PD/demo.txt"
check "demo.txt contains 'Linux is powerful'" grep -qF "Linux is powerful" "$PD/demo.txt"

echo "-- Activities 3 & 4: script.sh --"
check "script.sh was moved into $PD" test -f "$PD/script.sh"
check "script.sh contains: echo \"Hello Linux\"" grep -qF 'echo "Hello Linux"' "$PD/script.sh"
if [ -f "$PD/script.sh" ]; then
  perms="$(stat -c %A "$PD/script.sh")"
  [ "${perms:3:1}" = "x" ] && pass "script.sh is executable by the owner ($perms)" || fail "script.sh is NOT executable by the owner ($perms)"
  if [ "${perms:6:1}" != "x" ] && [ "${perms:9:1}" != "x" ]; then
    pass "script.sh is NOT executable by group/others"
  else
    fail "script.sh is executable by group or others ($perms) - task says user only"
  fi
fi
[ -e "$HOME/script.sh" ] && info "script.sh still exists in home - the task says to MOVE it" || info "script.sh is no longer in home (moved)"
[ -e "$HOME/demo.txt" ] && info "$HOME/demo.txt still exists (task says rename it; see docs/task-overview.md for interpretation)" || info "$HOME/demo.txt not present (renamed)"
[ -e "$HOME/notes.txt" ] && info "$HOME/notes.txt still exists (task says delete it)" || info "$HOME/notes.txt not present (deleted)"

echo "-- Activity 5: users and groups --"
check "user student1 exists" id student1
if id student1 >/dev/null 2>&1; then
  if id -nG student1 | tr ' ' '\n' | grep -qx sudo; then
    pass "student1 is in the sudo group"
  else
    fail "student1 is NOT in the sudo group (wheel on RHEL-family systems?)"
  fi
fi

echo "-- Activity 6: processes --"
if command -v pgrep >/dev/null 2>&1; then
  if pgrep -fx "sleep 500" >/dev/null 2>&1; then fail "a 'sleep 500' process is still running"; else pass "no 'sleep 500' process is running"; fi
else
  info "pgrep not available - check manually with: ps aux | grep sleep"
fi

echo "-- Activity 7: tools --"
for t in df free find grep; do check "command available: $t" command -v "$t"; done

echo "-- Activity 8: archiving --"
check "backup_test directory exists" test -d "$HOME/backup_test"
check "backup.tar.gz exists" test -f "$HOME/backup.tar.gz"
check "backup.tar.gz is a valid gzip tar containing backup_test/" bash -c 'tar -tzf "$HOME/backup.tar.gz" | grep -q "^backup_test/"'
[ -e "$HOME/backup.tar" ] && info "backup.tar still exists (gzip normally removes it)" || info "backup.tar not present (replaced by backup.tar.gz)"
check "extract_test/backup_test exists" test -d "$HOME/extract_test/backup_test"
check "extracted files match backup_test" diff -r "$HOME/backup_test" "$HOME/extract_test/backup_test"

echo "-- Activity 9: networking tools --"
for t in ip ping ss hostname; do check "command available: $t" command -v "$t"; done
[ -n "$(hostname 2>/dev/null)" ] && pass "hostname is set" || fail "hostname is empty"
info "ping/ss results cannot be verified here - rely on your screenshots"

echo "-- Activity 10: monitoring --"
for t in tail uptime top; do check "command available: $t" command -v "$t"; done
if [ -r /var/log/dmesg ]; then info "/var/log/dmesg exists and is readable"
elif [ -e /var/log/dmesg ]; then info "/var/log/dmesg exists but is NOT readable by you (document the fallback you used)"
else info "/var/log/dmesg does not exist on this system (document the fallback you used)"; fi

echo
echo "== Summary: $PASS passed, $FAIL failed (INFO lines are not scored) =="
[ "$FAIL" -eq 0 ]
