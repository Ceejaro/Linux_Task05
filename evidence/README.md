# evidence/

Your proof that you did the work. **Only add real screenshots and real output from your own terminal** — never
mock-ups.

```
evidence/
├── README.md             <- this file
├── screenshots/          <- put your PNG screenshots here (.gitkeep keeps the folder in git)
└── terminal-output/      <- optional plain-text copies of command output (.gitkeep)
```

## How to take good screenshots
- Show **the command you typed and its output**, plus the prompt where possible.
- Increase the terminal font size so text is readable on GitHub.
- Use the exact filenames below so the workflow, README and gallery line up.
- **Privacy:** blur or crop IP/MAC addresses (`ip a`), hostnames (prompt, `hostname`), login sources (`w`/`who`), and anything else private **before** committing.

## Required screenshots (28) + 1 optional

| # | Filename | Capture when | Commands visible | What it proves |
|---|----------|--------------|------------------|----------------|
| 00 | `00-environment-info.png` *(optional)* | Step 0.1 | `cat /etc/os-release`, `uname -r`, `whoami` | The system you worked on |
| 01 | `01-a1-pwd-ls-la.png` | Steps 1.1–1.2 | `pwd`, `ls -la` | Working directory shown; hidden files listed in long format |
| 02 | `02-a1-practice-dir-created.png` | Steps 1.3–1.4 | `ls -ld /tmp/practice_dir`, `cd ~`, `pwd` | `practice_dir` exists in `/tmp`; you returned home |
| 03 | `03-a2-demo-txt-created.png` | Steps 2.1–2.2 | `touch demo.txt`, `echo ... > demo.txt`, `cat demo.txt` | `demo.txt` created and contains "Linux is powerful" |
| 04 | `04-a2-editor-open.png` | Step 2.3 (editor open) | `nano demo.txt` / `vim demo.txt` | Another line was added manually in an editor |
| 05 | `05-a2-cat-demo-txt.png` | Step 2.4 | `cat demo.txt` | Final file contains both lines |
| 06 | `06-a3-script-created.png` | Step 3.1 | `touch script.sh`, `echo '...' > script.sh`, `cat script.sh` | `script.sh` contains `echo "Hello Linux"` |
| 07 | `07-a3-permissions-before-after.png` | Steps 3.2–3.3 | `ls -l script.sh` (twice, before/after `chmod u+x`) | Execute bit added for the user only |
| 08 | `08-a3-script-run.png` | Step 3.4 | `./script.sh` | Script runs and prints `Hello Linux` |
| 09 | `09-a4-copy-and-move.png` | Steps 4.1–4.2 | `cp`, `mv`, `ls -l /tmp/practice_dir/`, `ls -l ~` | `demo.txt` copied and `script.sh` moved into `practice_dir` |
| 10 | `10-a4-rename-and-delete.png` | Steps 4.3–4.4 | `mv demo.txt notes.txt`, `rm notes.txt`, `ls` | File renamed, then deleted |
| 11 | `11-a5-whoami-and-who.png` | Steps 5.1–5.2 | `whoami`, `w` or `who` | Current user and logged-in sessions *(redact if needed)* |
| 12 | `12-a5-student1-created-in-sudo.png` | Steps 5.3–5.4 | `sudo useradd ...`, `sudo usermod -aG sudo student1`, `id student1` | `student1` created and in the `sudo` group |
| 13 | `13-a6-background-job.png` | Steps 6.1–6.2 | `sleep 500 &`, `jobs` | Process running in the background |
| 14 | `14-a6-foreground-suspend-resume.png` | Step 6.3 | `fg`, `Ctrl+Z` result, `bg` | Job brought to foreground, then handled |
| 15 | `15-a6-kill-and-verify.png` | Steps 6.4–6.5 | `jobs -l`, `kill <PID>`, `ps aux \| grep sleep` | Process killed by PID and gone from the process list |
| 16 | `16-a7-df-and-free.png` | Steps 7.1–7.2 | `df -h`, `free -h` | Disk and memory usage |
| 17 | `17-a7-find-and-grep.png` | Steps 7.3–7.4 | `find ~ -name "*.sh"`, `grep -r "Linux" /tmp/practice_dir/ --include="*.txt"` | File search and content search results |
| 18 | `18-a8-backup-test-created.png` | Step 8.1 | `mkdir backup_test`, `ls -l backup_test` | Directory with files ready to archive |
| 19 | `19-a8-tar-and-gzip.png` | Steps 8.2–8.3 | `tar -cvf`, `gzip`, `ls -lh backup.tar*` | `backup.tar` created, then compressed to `backup.tar.gz` |
| 20 | `20-a8-extraction-verified.png` | Step 8.4 | `tar -xzvf ... -C extract_test`, `diff -r ...` | Archive extracts back to identical files |
| 21 | `21-a9-ip-a.png` | Step 9.1 | `ip a` | Network interfaces/IP *(redact addresses)* |
| 22 | `22-a9-ping.png` | Step 9.2 | `ping -c 3 google.com` | Connectivity test result (success **or** real error) |
| 23 | `23-a9-ss-and-hostname.png` | Steps 9.3–9.4 | `ss -tulnp`, `hostname` | Listening ports and hostname *(redact if needed)* |
| 24 | `24-a10-dmesg-tail.png` | Step 10.1 | `tail -n 10 /var/log/dmesg` (or documented fallback) | Last 10 kernel log lines (or the real error) |
| 25 | `25-a10-tail-follow.png` | Step 10.2 (running) | `tail -f /var/log/dmesg` | Real-time log monitoring |
| 26 | `26-a10-uptime.png` | Step 10.3 | `uptime` | System uptime and load |
| 27 | `27-a10-top-running.png` | Step 10.4 (running) | `top` | Process list; top CPU process identifiable |
| 28 | `28-final-verification.png` | Step 11.1 | `bash scripts/verify.sh` | End-state checks of the whole lab |

## Optional: save text output
You can also keep plain-text copies of outputs in `terminal-output/` (e.g. `df -h > terminal-output/a7-df.txt`
when run from the repo root, or copy the text in afterwards). Text is searchable on GitHub and complements the screenshots.
Do not include private data.

## Gallery
After capturing screenshots run `bash scripts/generate-gallery.sh` to create `GALLERY.md`, which displays every screenshot that exists.
