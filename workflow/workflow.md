# Workflow — Linux Command Line Activities

**Run-as legend**

| Label | Meaning |
|-------|---------|
| **normal user** | Your regular login (not root). Used for almost everything. |
| **sudo** | Command prefixed with `sudo`; you will be asked for your password. |

Rules of thumb:
- Do **all activities in one terminal session** if you can (`/tmp` may be cleared on reboot).
- Stay in your **home directory** unless a step says otherwise. Run `pwd` whenever unsure.
- Each screenshot must show **the command and its output** (and ideally the prompt).
- Expected results below describe *what to look for*, not exact output — yours will differ.

---

## Phase 0 — Environment Preparation

### Step 0.1 — Record your environment
- **Run as:** normal user
- **Command:**
  ```bash
  cat /etc/os-release
  uname -r
  whoami
  echo $SHELL
  ```
- **Purpose:** documents the system you are working on (fill the table in the main README).
- **Expected:** distribution name/version, kernel version, your username, your shell path.
- **Evidence:** `00-environment-info.png` *(optional)*.

### Step 0.2 — Start in your home directory and confirm sudo
- **Run as:** normal user
- **Command:**
  ```bash
  cd ~
  pwd
  sudo -v
  ```
- **Purpose:** `cd ~` goes home; `sudo -v` confirms you can use sudo (needed in Activity 5).
- **Expected:** `pwd` prints your home path; `sudo -v` returns without an error.
- **Notes:** if sudo fails you cannot complete Activity 5.

### Step 0.3 — Check the tools exist
- **Run as:** normal user
- **Command:**
  ```bash
  command -v nano vim tar gzip ip ss ping top free df find
  ```
- **Purpose:** lists the path of each tool found.
- **Expected:** a path for each. Missing ones need installing (e.g. `sudo apt install nano iproute2 iputils-ping procps`). You only need `nano` **or** `vim`.

---

## Phase 1 — Activity 1: File & Directory Navigation

### Step 1.1 — Show the current working directory
- **Run as:** normal user
- **Command:** `pwd`
- **Purpose:** *print working directory* — shows where you are.
- **Expected:** your home directory path.

### Step 1.2 — List all files (including hidden) in long format
- **Run as:** normal user
- **Command:** `ls -la`
- **Purpose:** `-l` = long format (permissions, owner, size, date); `-a` = include hidden files (names starting with `.`).
- **Expected:** entries `.` and `..`, hidden files such as `.bashrc`, and your normal files.
- **Verify:** confirm hidden files (leading dot) are listed.
- **Evidence:** `01-a1-pwd-ls-la.png` (steps 1.1 and 1.2 together).

### Step 1.3 — Go to `/tmp` and create `practice_dir`
- **Run as:** normal user
- **Command:**
  ```bash
  cd /tmp
  mkdir practice_dir
  ```
- **Purpose:** `cd` changes directory; `mkdir` creates a directory. Needed for Activities 4 and 7.
- **Expected:** no output on success.
- **Verify:** `ls -ld /tmp/practice_dir`

### Step 1.4 — Go back to your home directory
- **Run as:** normal user
- **Command:**
  ```bash
  cd ~
  pwd
  ```
- **Expected:** `pwd` shows your home directory again.
- **Evidence:** `02-a1-practice-dir-created.png` (steps 1.3 verify + 1.4: show `ls -ld /tmp/practice_dir` and the return home).
- **Notes:** plain `cd` with no argument also returns home.

---

## Phase 2 — Activity 2: File Creation & Editing

### Step 2.1 — Create `demo.txt` with `touch`
- **Run as:** normal user (in home directory)
- **Command:** `touch demo.txt`
- **Purpose:** `touch` creates an empty file (or updates the timestamp of an existing one).
- **Verify:** `ls -l demo.txt` — size should be `0`.

### Step 2.2 — Add the text "Linux is powerful" with `echo`
- **Run as:** normal user
- **Command:** `echo "Linux is powerful" > demo.txt`
- **Purpose:** `echo` prints text; `>` redirects it into the file (**overwrites** existing content).
- **Expected:** no output.
- **Verify:** `cat demo.txt` shows `Linux is powerful`.
- **Evidence:** `03-a2-demo-txt-created.png` (steps 2.1 and 2.2 with their verification).
- **Notes:** type plain straight quotes `"`; the task PDF shows curly quotes which are only typography.

### Step 2.3 — Open with `nano` (or `vim`) and add another line manually
- **Run as:** normal user — **interactive**
- **Command:** `nano demo.txt`  *(or `vim demo.txt`)*
- **Purpose:** edit a file in a terminal text editor.
- **What to do:**
  - **nano:** move to the end, press Enter, type any sentence. Save with `Ctrl+O`, press `Enter`, exit with `Ctrl+X`.
  - **vim:** press `G` then `o` to open a new line, type a sentence, press `Esc`, type `:wq` and press `Enter`.
- **Evidence:** `04-a2-editor-open.png` — screenshot **while the editor is open** showing your added line.
- **Notes:** to append without opening an editor you could use `>>`, but the task asks for manual editing.

### Step 2.4 — Display the file with `cat`
- **Run as:** normal user
- **Command:** `cat demo.txt`
- **Purpose:** prints the whole file.
- **Expected:** both lines — "Linux is powerful" and the line you added.
- **Evidence:** `05-a2-cat-demo-txt.png`.

---

## Phase 3 — Activity 3: File Permissions

### Step 3.1 — Create `script.sh` and add the line
- **Run as:** normal user (home directory)
- **Command:**
  ```bash
  touch script.sh
  echo 'echo "Hello Linux"' > script.sh
  ```
- **Purpose:** creates the file and writes the line `echo "Hello Linux"` into it. The outer single quotes make the shell write the inner double quotes literally.
- **Verify:** `cat script.sh` must show exactly `echo "Hello Linux"`.
- **Evidence:** `06-a3-script-created.png` (create + `cat script.sh`).

### Step 3.2 — Check permissions (before)
- **Run as:** normal user
- **Command:** `ls -l script.sh`
- **Purpose:** shows the permission string, e.g. `-rw-r--r--` (yours depends on your `umask`).
- **Expected:** **no** `x` anywhere in the permission string yet.

### Step 3.3 — Make it executable by the user only
- **Run as:** normal user
- **Command:**
  ```bash
  chmod u+x script.sh
  ls -l script.sh
  ```
- **Purpose:** `chmod u+x` adds the execute bit for the **u**ser (owner) only; group and others get no execute permission.
- **Expected:** an `x` appears in the **first** permission triplet only (e.g. `-rwxr--r--`).
- **Evidence:** `07-a3-permissions-before-after.png` — one screenshot showing `ls -l` **before** (3.2) and **after** (3.3).
- **Notes:** `chmod 700` would also strip read access from group/others — that is stricter than the task asks, so `u+x` is used.

### Step 3.4 — Run the script
- **Run as:** normal user
- **Command:** `./script.sh`
- **Purpose:** executes the file. The `./` is required because the current directory is not in your `PATH`.
- **Expected:** prints `Hello Linux`.
- **Evidence:** `08-a3-script-run.png`.
- **Notes:** no shebang line is added because the task only asks for the `echo` line; bash still runs it. If you get `Permission denied`, redo Step 3.3.

---

## Phase 4 — Activity 4: File Operations

### Step 4.1 — Copy `demo.txt` into `/tmp/practice_dir/`
- **Run as:** normal user (home directory)
- **Command:** `cp demo.txt /tmp/practice_dir/`
- **Purpose:** `cp` duplicates a file; the original stays.
- **Verify:** `ls -l /tmp/practice_dir/`

### Step 4.2 — Move `script.sh` into `/tmp/practice_dir/`
- **Run as:** normal user
- **Command:** `mv script.sh /tmp/practice_dir/`
- **Purpose:** `mv` moves a file (it disappears from the old location).
- **Verify:**
  ```bash
  ls -l /tmp/practice_dir/
  ls -l ~
  ```
  `script.sh` should be in `practice_dir` and no longer in home.
- **Evidence:** `09-a4-copy-and-move.png` (steps 4.1 and 4.2 with both listings).

### Step 4.3 — Rename `demo.txt` to `notes.txt`
- **Run as:** normal user (home directory)
- **Command:** `mv demo.txt notes.txt`
- **Purpose:** `mv` also renames when the destination is a new name in the same directory.
- **Verify:** `ls -l demo.txt notes.txt` — `demo.txt` should report "No such file", `notes.txt` should be listed.
- **Notes:** this renames the **home-directory original**; the copy in `/tmp/practice_dir/` stays as `demo.txt` (see `docs/task-overview.md`).

### Step 4.4 — Delete `notes.txt`
- **Run as:** normal user
- **Command:** `rm notes.txt`
- **Purpose:** removes the file permanently (no recycle bin).
- **Verify:** `ls notes.txt` should say "No such file or directory".
- **Evidence:** `10-a4-rename-and-delete.png` (steps 4.3 and 4.4).
- **Notes:** delete only `notes.txt`.

---

## Phase 5 — Activity 5: User & Group Management

### Step 5.1 — Display your username
- **Run as:** normal user
- **Command:** `whoami`
- **Expected:** your username.

### Step 5.2 — Show logged-in users
- **Run as:** normal user
- **Command:** `w`  *(or `who`)*
- **Purpose:** lists who is logged in; `w` also shows what each session is doing.
- **Expected:** at least your own session.
- **Evidence:** `11-a5-whoami-and-who.png` (5.1 + 5.2).
- **Notes:** may reveal IP addresses or hostnames — see the privacy note in the README before publishing.

### Step 5.3 — Create `student1`
- **Run as:** **sudo**
- **Command:** `sudo useradd -m student1`
- **Purpose:** `useradd` creates the account; `-m` also creates `/home/student1` (an addition so the account is usable — plain `sudo useradd student1` also meets the task).
- **Expected:** no output on success.
- **Verify:**
  ```bash
  id student1
  grep student1 /etc/passwd
  ```

### Step 5.4 — Add `student1` to the `sudo` group
- **Run as:** **sudo**
- **Command:** `sudo usermod -aG sudo student1`
- **Purpose:** `-G sudo` sets a supplementary group; **`-a` (append) is essential** — without it existing groups would be replaced.
- **Expected:** no output on success.
- **Verify:**
  ```bash
  id student1
  getent group sudo
  ```
  `sudo` must appear in `student1`'s groups.
- **Evidence:** `12-a5-student1-created-in-sudo.png` (5.3 + 5.4 with verification).
- **Notes:** on RHEL-family systems the group is `wheel`. No password was set (not requested), so `student1` cannot log in yet — that is fine.

---

## Phase 6 — Activity 6: Process Management

### Step 6.1 — Start a background process
- **Run as:** normal user
- **Command:** `sleep 500 &`
- **Purpose:** `sleep 500` waits 500 seconds; the trailing `&` runs it in the **background** so you keep your prompt.
- **Expected:** a line like `[1] <number>` — job number and PID.

### Step 6.2 — View background jobs
- **Run as:** normal user
- **Command:** `jobs`  *(optionally `jobs -l` to also show PIDs)*
- **Expected:** `[1]+ Running sleep 500 &`
- **Evidence:** `13-a6-background-job.png` (6.1 + 6.2).

### Step 6.3 — Bring it to the foreground
- **Run as:** normal user
- **Command:** `fg`
- **Purpose:** moves job 1 to the foreground.
- **Expected:** the command `sleep 500` is shown and your prompt does **not** return (the terminal is now occupied by `sleep`).
- **Next, to continue in the same terminal:** press `Ctrl+Z` (suspends it: `Stopped`), then run `bg` (resumes it in the background).
- **Evidence:** `14-a6-foreground-suspend-resume.png` (`fg`, the `Ctrl+Z` result, and `bg`).
- **Notes:**
  - Why `bg`? A *stopped* process cannot act on a normal `kill` until it is resumed.
  - Alternative: open a **second terminal**, find the PID there, and `kill` it while the first terminal shows `fg`. Document which method you used.

### Step 6.4 — Kill it using its PID
- **Run as:** normal user
- **Find the PID:** `jobs -l`  *(or `pgrep -x sleep`)*
- **Command:** `kill <PID>`   ← replace `<PID>` with the real number, e.g. `kill 12345`
- **Purpose:** sends SIGTERM (polite termination request) to that exact process.
- **Expected:** no output; the next prompt may print `[1]+ Terminated sleep 500`.
- **Notes:** check the number twice — kill **only** your `sleep 500`. Avoid `kill -9`, `pkill` and `killall`; the task asks for kill by PID.

### Step 6.5 — Verify it is terminated
- **Run as:** normal user
- **Command:** `ps aux | grep sleep`
- **Purpose:** lists processes and filters lines containing "sleep".
- **Expected:** **no line containing `sleep 500`.** You will likely still see one line for the `grep sleep` command itself — that is normal.
- **Verify:** `jobs` shows nothing running (or shows `Terminated` once).
- **Evidence:** `15-a6-kill-and-verify.png` (6.4 `jobs -l`/PID, `kill`, and 6.5).

---

## Phase 7 — Activity 7: Disk Usage & File Searching

### Step 7.1 — Disk space
- **Run as:** normal user
- **Command:** `df -h`
- **Purpose:** *disk free*, `-h` = human-readable sizes (K/M/G).
- **Expected:** a table of filesystems with Size, Used, Avail, Use%, Mounted on.

### Step 7.2 — Memory usage
- **Run as:** normal user
- **Command:** `free -h`
- **Purpose:** shows total/used/free RAM and swap, human-readable.
- **Evidence:** `16-a7-df-and-free.png` (7.1 + 7.2).

### Step 7.3 — Find all `.sh` files in your home directory
- **Run as:** normal user
- **Command:** `find ~ -name "*.sh"`
- **Purpose:** searches your home directory tree for files whose names end in `.sh`. Quotes stop the shell expanding `*`.
- **Expected:** **may be empty** — `script.sh` was moved to `/tmp/practice_dir/` in Activity 4. Any other `.sh` files you own (including this repo's `scripts/` if it lives in your home directory) will be listed.
- **Verify:** `ls /tmp/practice_dir/` shows `script.sh` there, explaining the result.

### Step 7.4 — Search for "Linux" inside `.txt` files in `/tmp/practice_dir/`
- **Run as:** normal user
- **Command:** `grep -r "Linux" /tmp/practice_dir/ --include="*.txt"`
- **Purpose:** `-r` recurses into the directory; `--include="*.txt"` limits it to `.txt` files. Matching is case-sensitive.
- **Expected:** lines containing "Linux" from `demo.txt`, each prefixed with the filename.
- **Evidence:** `17-a7-find-and-grep.png` (7.3 + 7.4).
- **Notes:** if nothing matches, check that the copy of `demo.txt` is in `/tmp/practice_dir/` (Activity 4).

---

## Phase 8 — Activity 8: Archiving & Compression

*Work in your home directory.*

### Step 8.1 — Create `backup_test` and add some files
- **Run as:** normal user
- **Command:**
  ```bash
  mkdir backup_test
  echo "sample file one" > backup_test/file1.txt
  echo "sample file two" > backup_test/file2.txt
  echo "sample file three" > backup_test/file3.txt
  ```
- **Purpose:** creates content to archive (the task says "some files"; names and text are your choice).
- **Verify:** `ls -l backup_test`
- **Evidence:** `18-a8-backup-test-created.png`.

### Step 8.2 — Create `backup.tar`
- **Run as:** normal user
- **Command:** `tar -cvf backup.tar backup_test`
- **Purpose:** `-c` create, `-v` verbose (list files), `-f` archive filename. A tar archive bundles files **without** compressing them.
- **Verify:**
  ```bash
  ls -lh backup.tar
  tar -tf backup.tar
  ```

### Step 8.3 — Compress it with `gzip`
- **Run as:** normal user
- **Command:**
  ```bash
  gzip backup.tar
  ls -lh backup.tar*
  ```
- **Purpose:** compresses `backup.tar` into `backup.tar.gz`.
- **Expected:** `backup.tar.gz` exists; **`backup.tar` is gone** (gzip replaces the original by default).
- **Evidence:** `19-a8-tar-and-gzip.png` (8.2 + 8.3).
- **Notes:** `gzip -k` would keep the original; the task does not ask for that.

### Step 8.4 — Extract the compressed archive to test it
- **Run as:** normal user
- **Command:**
  ```bash
  mkdir extract_test
  tar -xzvf backup.tar.gz -C extract_test
  ```
- **Purpose:** `-x` extract, `-z` decompress gzip, `-v` verbose, `-f` file, `-C` target directory. Extracting into a separate directory lets you compare with the original.
- **Verify:**
  ```bash
  ls -R extract_test
  diff -r backup_test extract_test/backup_test && echo "Extraction verified: identical"
  ```
  `diff` prints nothing when the directories match, so you should see your confirmation message.
- **Evidence:** `20-a8-extraction-verified.png`.

---

## Phase 9 — Activity 9: Networking Basics

### Step 9.1 — Display your IP address
- **Run as:** normal user
- **Command:** `ip a`
- **Purpose:** shows network interfaces and their addresses (`lo` is loopback; others are real/virtual NICs).
- **Expected:** at least `lo`; usually another interface with an `inet` address.
- **Evidence:** `21-a9-ip-a.png`.
- **Notes:** ⚠️ shows IP and MAC addresses — crop/blur before publishing if you do not want them public. If `ip` is missing: `sudo apt install iproute2`.

### Step 9.2 — Ping google.com three times
- **Run as:** normal user
- **Command:** `ping -c 3 google.com`
- **Purpose:** `-c 3` sends exactly 3 echo requests and stops.
- **Expected:** three reply lines plus a statistics summary. If there is no internet, DNS failure or blocked ICMP you will see an error instead.
- **Evidence:** `22-a9-ping.png` — capture what really happened, success or failure.

### Step 9.3 — Show all listening ports
- **Run as:** normal user
- **Command:** `ss -tulnp`
- **Purpose:** `-t` TCP, `-u` UDP, `-l` listening, `-n` numeric, `-p` process.
- **Expected:** a table of listening sockets. Without root, the process column is only filled for your own processes.
- **Optional extra:** `sudo ss -tulnp` shows process names for all sockets. If you run it, note it in your documentation.

### Step 9.4 — Display the hostname
- **Run as:** normal user
- **Command:** `hostname`
- **Expected:** your system's hostname.
- **Evidence:** `23-a9-ss-and-hostname.png` (9.3 + 9.4).
- **Notes:** ⚠️ the hostname may also appear in your prompt — blur if needed.

---

## Phase 10 — Activity 10: System Monitoring & Logs

### Step 10.1 — Last 10 lines of `/var/log/dmesg`
- **Run as:** normal user
- **Command:** `tail -n 10 /var/log/dmesg`
- **Purpose:** `tail` prints the end of a file; `-n 10` = 10 lines. `dmesg` holds kernel boot messages.
- **Expected:** 10 lines of kernel messages.
- **If it fails** (record the real error first, and screenshot it):
  - `No such file or directory` — many newer systems and WSL do not keep this file. Fallback: `dmesg | tail -n 10` or `journalctl -k -n 10`.
  - `Permission denied` — the file may be readable only by root/`adm`. Fallback: `sudo tail -n 10 /var/log/dmesg` or `sudo dmesg | tail -n 10`.
  - Fallbacks go beyond the wording of the task, so state in your documentation which one you used and why.
- **Evidence:** `24-a10-dmesg-tail.png`.

### Step 10.2 — Monitor the log in real time
- **Run as:** normal user — **interactive**
- **Command:** `tail -f /var/log/dmesg`  *(fallback if the file is unavailable: `sudo dmesg -w` or `journalctl -k -f`)*
- **Purpose:** `-f` follows the file and prints new lines as they are added.
- **Expected:** the last 10 lines, then the command keeps waiting. If the log is not changing, nothing new will appear — that is normal.
- **Stop it:** press `Ctrl+C`.
- **Evidence:** `25-a10-tail-follow.png` — screenshot while it is running.

### Step 10.3 — System uptime
- **Run as:** normal user
- **Command:** `uptime`
- **Purpose:** shows current time, how long the system has been up, logged-in users, and load averages.
- **Evidence:** `26-a10-uptime.png`.

### Step 10.4 — Run `top` and identify the top CPU process
- **Run as:** normal user — **interactive**
- **Command:** `top`
- **Purpose:** live view of running processes. The default order is by CPU use (press `P` to sort by CPU, `M` for memory).
- **What to do:** look at the `%CPU` column; the process in the first row is using the most CPU at that moment. Note its **name** and **PID**.
- **Quit:** press `q`.
- **Evidence:** `27-a10-top-running.png` — screenshot while `top` is open.
- **Notes:** write the process name/PID in `submission/final-output.txt`. For a plain-text capture you can also run `top -b -n 1 | head -n 15`.

---

## Phase 11 — Final Verification & Evidence

### Step 11.1 — Run the verification script
- **Run as:** normal user, from the repository directory
- **Command:**
  ```bash
  bash scripts/verify.sh
  ```
- **Purpose:** read-only check of the end state (files, `student1`, archive, no leftover `sleep 500`).
- **Expected:** `[PASS]` / `[FAIL]` / `[INFO]` lines and a summary. Investigate any `[FAIL]`.
- **Evidence:** `28-final-verification.png`.

### Step 11.2 — Build the screenshot gallery
- **Command:** `bash scripts/generate-gallery.sh`
- **Purpose:** creates `evidence/GALLERY.md` linking the screenshots that actually exist in `evidence/screenshots/`.

### Step 11.3 — Complete the documentation
1. Put screenshots in `evidence/screenshots/` with the names above.
2. Fill `submission/command-history.txt` and `submission/final-output.txt`.
3. Write `docs/lessons-learned.md` in your own words.
4. Fill the environment table and tick the Results Summary in the main `README.md`.

---

## Phase 12 — Publish to GitHub

1. **Privacy review** — open every screenshot and text file; remove or blur IPs, MAC addresses, hostnames, remote login IPs, and anything else private.
2. Follow the *Publishing to GitHub* commands in the main [`README.md`](../README.md).
3. (Optional) Run `bash scripts/cleanup.sh` **after** all evidence is captured to remove lab files and the `student1` user.

---

## Final Verification Checklist

- [ ] Environment info recorded (distro, kernel, user)
- [ ] **A1** `pwd` and `ls -la` run; `/tmp/practice_dir` created; returned home
- [ ] **A2** `demo.txt` created with `touch`; "Linux is powerful" added with `echo`; second line added in `nano`/`vim`; shown with `cat`
- [ ] **A3** `script.sh` contains `echo "Hello Linux"`; `ls -l` before and after; executable by owner only; script run and printed `Hello Linux`
- [ ] **A4** `demo.txt` copied and `script.sh` moved into `/tmp/practice_dir/`; `demo.txt` renamed to `notes.txt`; `notes.txt` deleted
- [ ] **A5** `whoami` and `w`/`who` run; `student1` created; `student1` in `sudo` group
- [ ] **A6** `sleep 500 &` started; `jobs` viewed; `fg` used; process killed by PID; `ps aux | grep sleep` verified
- [ ] **A7** `df -h` and `free -h` run; `.sh` search done; "Linux" search in `/tmp/practice_dir/` done
- [ ] **A8** `backup_test` with files; `backup.tar` created; `backup.tar.gz` created; extraction tested
- [ ] **A9** `ip a`, `ping -c 3 google.com`, `ss -tulnp`, `hostname` run (failures documented honestly)
- [ ] **A10** `tail -n 10` and `tail -f` on `/var/log/dmesg` (or documented fallback); `uptime`; `top` and top CPU process noted
- [ ] `scripts/verify.sh` run
- [ ] 28 screenshots captured and named correctly
- [ ] Private information removed from screenshots and text
- [ ] `command-history.txt`, `final-output.txt`, `lessons-learned.md` completed in your own words
- [ ] Repository pushed to GitHub
