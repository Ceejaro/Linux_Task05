#!/usr/bin/env bash
# =============================================================================
# cleanup.sh - OPTIONAL interactive cleanup of the lab's leftovers
# Purpose : Remove files and the student1 user created during the lab.
# WARNING : DELETES FILES and a USER. Run only AFTER all screenshots/evidence are captured.
# Run as  : your NORMAL user (it calls sudo itself, only for userdel):  bash scripts/cleanup.sh
# Safety  : Asks y/N before each group; only touches the fixed paths below.
# =============================================================================
set -u

if [ "$(id -u)" -eq 0 ]; then
  echo "Do not run as root. Run as your normal user." >&2
  exit 2
fi
if [ -z "${HOME:-}" ] || [ "$HOME" = "/" ]; then
  echo "HOME is unset or '/', refusing to continue." >&2
  exit 2
fi

confirm() { # confirm "question"
  local ans
  read -r -p "$1 [y/N] " ans
  [ "$ans" = "y" ] || [ "$ans" = "Y" ]
}

echo "== Lab cleanup (nothing is deleted without your confirmation) =="
echo

# 1. /tmp/practice_dir
if [ -d /tmp/practice_dir ]; then
  echo "Found: /tmp/practice_dir"; ls -la /tmp/practice_dir
  confirm "Remove /tmp/practice_dir ?" && rm -rf -- /tmp/practice_dir && echo "  removed."
else
  echo "/tmp/practice_dir not found - skipping."
fi
echo

# 2. Files in home directory
FILES=("demo.txt" "notes.txt" "script.sh" "backup.tar" "backup.tar.gz")
DIRS=("backup_test" "extract_test")
FOUND=()
for f in "${FILES[@]}"; do [ -e "$HOME/$f" ] && FOUND+=("$HOME/$f"); done
for d in "${DIRS[@]}";  do [ -d "$HOME/$d" ] && FOUND+=("$HOME/$d"); done
if [ ${#FOUND[@]} -gt 0 ]; then
  echo "Found in home directory:"; printf '  %s\n' "${FOUND[@]}"
  if confirm "Remove these ?"; then
    for p in "${FOUND[@]}"; do rm -rf -- "$p"; done
    echo "  removed."
  fi
else
  echo "No lab files found in $HOME - skipping."
fi
echo

# 3. Leftover sleep 500 process
if command -v pgrep >/dev/null 2>&1 && pgrep -fx "sleep 500" >/dev/null 2>&1; then
  echo "A 'sleep 500' process is still running (PIDs: $(pgrep -fx 'sleep 500' | tr '\n' ' '))"
  confirm "Terminate it ?" && pkill -fx "sleep 500" && echo "  terminated."
fi

# 4. student1 user
if id student1 >/dev/null 2>&1; then
  echo "User student1 exists:"; id student1
  if confirm "Delete user student1 AND its home directory (sudo userdel -r) ?"; then
    sudo userdel -r student1 && echo "  student1 removed."
  fi
else
  echo "User student1 not found - skipping."
fi

echo
echo "Cleanup finished."
