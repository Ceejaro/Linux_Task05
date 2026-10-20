#!/usr/bin/env bash
# =============================================================================
# Linux Command Line Activities - COMMAND REFERENCE SHEET
# =============================================================================
# DO NOT RUN THIS FILE. Copy commands one section at a time into your terminal.
# Reasons: interactive editors/monitors, a placeholder PID, user creation (sudo),
# and file deletion. See workflow/workflow.md for explanations and evidence steps.
# =============================================================================
echo "commands.sh is a reference sheet - copy the commands manually (see workflow/workflow.md)." >&2
exit 1

# ---------------------------------------------------------------------------
# PHASE 0 - Environment preparation (normal user)
# ---------------------------------------------------------------------------
cat /etc/os-release
uname -r
whoami
echo $SHELL
cd ~
pwd
sudo -v                                   # [SUDO] confirm sudo works (needed in Activity 5)
command -v nano vim tar gzip ip ss ping top free df find

# ---------------------------------------------------------------------------
# ACTIVITY 1 - File & Directory Navigation (normal user)
# ---------------------------------------------------------------------------
pwd                                       # show current working directory
ls -la                                    # all files (incl. hidden), long format
cd /tmp                                   # go to /tmp
mkdir practice_dir                        # create practice_dir
ls -ld /tmp/practice_dir                  # verify
cd ~                                      # back to home directory
pwd

# ---------------------------------------------------------------------------
# ACTIVITY 2 - File Creation & Editing (home directory)
# ---------------------------------------------------------------------------
touch demo.txt                            # create empty file
ls -l demo.txt
echo "Linux is powerful" > demo.txt       # '>' overwrites file content
cat demo.txt
nano demo.txt                             # [INTERACTIVE] add another line; Ctrl+O, Enter, Ctrl+X to save/exit
# vim demo.txt                            # [OPTIONAL] alternative: G, o, type, Esc, :wq
cat demo.txt                              # show final content

# ---------------------------------------------------------------------------
# ACTIVITY 3 - File Permissions (home directory)
# ---------------------------------------------------------------------------
touch script.sh
echo 'echo "Hello Linux"' > script.sh     # single quotes keep the inner double quotes
cat script.sh                             # verify exact content
ls -l script.sh                           # permissions BEFORE
chmod u+x script.sh                       # executable by the USER (owner) only
ls -l script.sh                           # permissions AFTER
./script.sh                               # run it - should print: Hello Linux

# ---------------------------------------------------------------------------
# ACTIVITY 4 - File Operations (home directory)
# ---------------------------------------------------------------------------
cp demo.txt /tmp/practice_dir/            # copy (original stays)
mv script.sh /tmp/practice_dir/           # move
ls -l /tmp/practice_dir/
ls -l ~
mv demo.txt notes.txt                     # rename the home-directory original
ls -l demo.txt notes.txt                  # demo.txt gone, notes.txt present
rm notes.txt                              # delete (permanent!)
ls notes.txt                              # should report: No such file or directory

# ---------------------------------------------------------------------------
# ACTIVITY 5 - User & Group Management
# ---------------------------------------------------------------------------
whoami
w                                         # or: who
sudo useradd -m student1                  # [SUDO] create user (-m = create home directory)
sudo usermod -aG sudo student1            # [SUDO] append student1 to the sudo group (-a is essential)
id student1                               # verify group membership
getent group sudo
# On RHEL-family systems the group is "wheel":  sudo usermod -aG wheel student1   [FALLBACK]

# ---------------------------------------------------------------------------
# ACTIVITY 6 - Process Management
# ---------------------------------------------------------------------------
sleep 500 &                               # start in background; prints [1] <PID>
jobs                                      # list background jobs
fg                                        # [INTERACTIVE] bring to foreground (terminal now busy)
# Press Ctrl+Z to suspend it, then:
bg                                        # resume it in the background
jobs -l                                   # shows the PID
# kill <PID>                              # [NEEDS REAL PID] replace <PID> with the number, e.g. kill 12345
ps aux | grep sleep                       # no "sleep 500" line should remain (the grep line itself is normal)
jobs

# ---------------------------------------------------------------------------
# ACTIVITY 7 - Disk Usage & File Searching
# ---------------------------------------------------------------------------
df -h                                     # disk space, human-readable
free -h                                   # memory usage, human-readable
find ~ -name "*.sh"                       # may be empty: script.sh was moved in Activity 4
ls /tmp/practice_dir/                     # explains the result
grep -r "Linux" /tmp/practice_dir/ --include="*.txt"

# ---------------------------------------------------------------------------
# ACTIVITY 8 - Archiving & Compression (home directory)
# ---------------------------------------------------------------------------
mkdir backup_test
echo "sample file one" > backup_test/file1.txt
echo "sample file two" > backup_test/file2.txt
echo "sample file three" > backup_test/file3.txt
ls -l backup_test
tar -cvf backup.tar backup_test           # create tar archive (no compression)
ls -lh backup.tar
tar -tf backup.tar                        # list archive contents
gzip backup.tar                           # compress -> backup.tar.gz (removes backup.tar)
ls -lh backup.tar*
mkdir extract_test
tar -xzvf backup.tar.gz -C extract_test   # extract into a separate directory
ls -R extract_test
diff -r backup_test extract_test/backup_test && echo "Extraction verified: identical"

# ---------------------------------------------------------------------------
# ACTIVITY 9 - Networking Basics
# ---------------------------------------------------------------------------
ip a                                      # NOTE: shows IP/MAC - redact before publishing
ping -c 3 google.com                      # exactly 3 pings (needs internet/DNS/ICMP)
ss -tulnp                                 # listening TCP/UDP sockets with processes
# sudo ss -tulnp                          # [OPTIONAL][SUDO] shows process names for all sockets
hostname

# ---------------------------------------------------------------------------
# ACTIVITY 10 - System Monitoring & Logs
# ---------------------------------------------------------------------------
tail -n 10 /var/log/dmesg                 # last 10 lines of dmesg log
# FALLBACKS if the file is missing/unreadable (document which you used):
#   dmesg | tail -n 10
#   sudo dmesg | tail -n 10               # [SUDO]
#   journalctl -k -n 10
tail -f /var/log/dmesg                    # [INTERACTIVE] follow the log; Ctrl+C to stop
#   journalctl -k -f                      # [FALLBACK] follow kernel messages
uptime
top                                       # [INTERACTIVE] note the top %CPU process; press q to quit
# top -b -n 1 | head -n 15                # [OPTIONAL] text capture of top

# ---------------------------------------------------------------------------
# FINAL VERIFICATION & DOCUMENTATION (run from the repository directory)
# ---------------------------------------------------------------------------
bash scripts/verify.sh
bash scripts/generate-gallery.sh
history | sed 's/^ *[0-9]* *//' | tail -n 200     # help build submission/command-history.txt
# bash scripts/cleanup.sh                 # [OPTIONAL] only AFTER all evidence is captured
