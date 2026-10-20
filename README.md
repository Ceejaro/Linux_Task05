# Linux Command Line Activities

A hands-on Linux practical covering **10 activities**: navigation, file creation and editing, permissions,
file operations, user/group management, process management, disk usage and searching, archiving,
networking basics, and system monitoring.

This repository is a **workflow + documentation template**. It does not contain completed results.
You run the commands in your own Linux terminal, capture your own screenshots, and paste your own output
into the templates, so the finished repo is genuine portfolio evidence of your work.

> **Author:** `[YOUR NAME]`  |  **Date completed:** `[DATE]`  |  **Linux distribution:** `[FILL IN]`

---

## Objective

Build confidence with everyday Linux command-line skills by completing the ten activities in the uploaded
task, and document each one with commands, expected results and screenshot evidence.

## Activity Requirements

| # | Activity | What you do |
|---|----------|-------------|
| 1 | File & Directory Navigation | Show working directory; list all files (incl. hidden) in long format; go to `/tmp` and create `practice_dir`; return home |
| 2 | File Creation & Editing | Create `demo.txt` with `touch`; add "Linux is powerful" with `echo`; add another line with `nano` or `vim`; show with `cat` |
| 3 | File Permissions | Create `script.sh` containing `echo "Hello Linux"`; check `ls -l`; make it executable by the user only; run it |
| 4 | File Operations | Copy `demo.txt` into `/tmp/practice_dir/`; move `script.sh` there; rename `demo.txt` to `notes.txt`; delete `notes.txt` |
| 5 | User & Group Management | `whoami`; `w` or `who`; create `student1` (sudo required); add `student1` to the `sudo` group |
| 6 | Process Management | `sleep 500 &`; `jobs`; `fg`; kill by PID; verify with `ps aux \| grep sleep` |
| 7 | Disk Usage & File Searching | `df -h`; `free -h`; find all `.sh` files in home; search for "Linux" in `.txt` files in `/tmp/practice_dir/` |
| 8 | Archiving & Compression | Create `backup_test` with files; make `backup.tar`; gzip to `backup.tar.gz`; extract to test |
| 9 | Networking Basics | `ip a`; ping `google.com` 3 times; `ss -tulnp`; show hostname |
| 10 | System Monitoring & Logs | Last 10 lines of `/var/log/dmesg`; `tail -f /var/log/dmesg`; `uptime`; `top` and identify the top CPU process |

## Tools & Commands Used

`pwd`, `ls`, `cd`, `mkdir`, `touch`, `echo`, `nano`/`vim`, `cat`, `chmod`, `cp`, `mv`, `rm`, `whoami`, `w`/`who`,
`sudo`, `useradd`, `usermod`, `id`, `sleep`, `jobs`, `fg`, `bg`, `kill`, `ps`, `grep`, `df`, `free`, `find`,
`tar`, `gzip`, `ip`, `ping`, `ss`, `hostname`, `tail`, `uptime`, `top`

## Prerequisites

- A Linux machine or VM (Ubuntu/Debian assumed; see Troubleshooting for other distributions).
- A normal (non-root) user account with **sudo** rights — Activity 5 needs it.
- A terminal, `nano` or `vim`, and a screenshot tool.
- Internet access for the `ping google.com` step (if unavailable, document what you see).
- **Use a practice VM or a machine you own.** Activity 5 creates a user with sudo rights.

## Environment (fill in after you start)

| Item | Your value |
|------|------------|
| Linux distribution / version | `[FILL IN — from cat /etc/os-release]` |
| Kernel | `[FILL IN — from uname -r]` |
| Running on | `[VM / bare metal / WSL / cloud]` |
| Shell | `[FILL IN — echo $SHELL]` |
| Login user | `[FILL IN — whoami]` |

## Project Structure

```
linux-command-line-activities/
├── README.md                      <- you are here
├── .gitignore
├── docs/
│   ├── README.md
│   ├── task-overview.md           <- the task broken down + ambiguities and decisions
│   └── lessons-learned.md         <- reflection template (write in your own words)
├── workflow/
│   ├── README.md
│   └── workflow.md                <- MAIN GUIDE: step-by-step procedure for all 10 activities
├── commands/
│   ├── README.md
│   └── commands.sh                <- every command in order (reference sheet, not a runnable script)
├── scripts/
│   ├── README.md
│   ├── verify.sh                  <- read-only end-state checker
│   ├── cleanup.sh                 <- optional interactive cleanup after you finish
│   └── generate-gallery.sh        <- builds evidence/GALLERY.md from your real screenshots
├── evidence/
│   ├── README.md                  <- screenshot list, filenames, when to capture, what each proves
│   ├── screenshots/
│   └── terminal-output/
└── submission/
    ├── README.md
    ├── command-history.txt        <- template
    └── final-output.txt           <- template
```

## How to Use This Repository

1. Read [`docs/task-overview.md`](docs/task-overview.md), especially the *Ambiguities* table.
2. Follow [`workflow/workflow.md`](workflow/workflow.md) in your terminal, one activity at a time.
3. Take each screenshot as you go, using the filenames in [`evidence/README.md`](evidence/README.md).
4. Run `bash scripts/verify.sh`, then `bash scripts/generate-gallery.sh`.
5. Fill in [`submission/`](submission/) and [`docs/lessons-learned.md`](docs/lessons-learned.md).
6. Review for private information, then publish to GitHub (see below).

## Results Summary (tick as you complete each activity)

| # | Activity | Done | Screenshots captured |
|---|----------|:----:|:--------------------:|
| 1 | File & Directory Navigation | ☐ | ☐ |
| 2 | File Creation & Editing | ☐ | ☐ |
| 3 | File Permissions | ☐ | ☐ |
| 4 | File Operations | ☐ | ☐ |
| 5 | User & Group Management | ☐ | ☐ |
| 6 | Process Management | ☐ | ☐ |
| 7 | Disk Usage & File Searching | ☐ | ☐ |
| 8 | Archiving & Compression | ☐ | ☐ |
| 9 | Networking Basics | ☐ | ☐ |
| 10 | System Monitoring & Logs | ☐ | ☐ |

## Commands Used

The complete, commented, ordered list is in [`commands/commands.sh`](commands/commands.sh).
**Do not run that file as a script** — it is a reference sheet, and several steps are interactive (nano, `fg`, `top`).

## Expected Results (what "done" looks like)

- `/tmp/practice_dir/` exists and contains the copied `demo.txt` and the moved `script.sh`.
- `script.sh` printed `Hello Linux` and is executable by its owner only.
- `student1` exists and is a member of `sudo`.
- The `sleep 500` process was killed by PID and no longer appears in `ps aux | grep sleep` (apart from the `grep` line itself).
- `backup.tar.gz` exists and extracts back to the original files.
- You captured the output of every networking and monitoring command, or recorded honestly what happened if one was unavailable.

## Evidence Requirements

Screenshots go in `evidence/screenshots/`. The full list (28 screenshots + 1 optional) with filenames and
what each one proves is in [`evidence/README.md`](evidence/README.md).

<!-- After capturing screenshots, run: bash scripts/generate-gallery.sh
     then link the gallery here, e.g.:
     See the full [screenshot gallery](evidence/GALLERY.md). -->

## Submission Requirements

The uploaded task lists **no formal submission requirements**. This repo packages your work for GitHub portfolio
documentation: screenshots, a command history, pasted outputs, and a reflection. Details in
[`submission/README.md`](submission/README.md).

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `sudo: unknown group 'sudo'` / group `sudo` not found | RHEL/Fedora/CentOS use `wheel`: `sudo usermod -aG wheel student1`. Note this deviation in your documentation. |
| `useradd: user 'student1' already exists` | Check `id student1`. If it is a leftover from an earlier attempt, see `scripts/cleanup.sh`. |
| `./script.sh: Permission denied` | You have not yet run `chmod u+x script.sh`, or you are in a different directory (`pwd`). |
| `fg` seems to freeze the terminal | Expected: `sleep 500` now runs in the foreground. Press `Ctrl+Z`, then `bg`, then continue (see workflow, Phase 6). |
| `grep sleep` shows a line even after killing | That line is the `grep sleep` command itself. Look for a line containing `sleep 500`. |
| `find ~ -name "*.sh"` prints nothing | Normal if `script.sh` was already moved to `/tmp/practice_dir/` in Activity 4 and you have no other `.sh` files in home. |
| `/var/log/dmesg` does not exist or is unreadable | Common on newer systems / WSL. See workflow Phase 10 for documented fallbacks. Record exactly what happened. |
| `ping: command not found` / `ip: command not found` | Install: `sudo apt install iputils-ping iproute2`. |
| `ping google.com` fails | No internet, DNS problem, or ICMP blocked. Screenshot the error — do not fake success. |
| `/tmp/practice_dir` is gone | `/tmp` is cleared on reboot on many systems. Do Activities 1–7 in one session. |

## Safety, Permission & Privacy Notes

- Activity 5 creates a user and grants it `sudo`. Do this on a lab VM or your own machine and remove the user afterwards (`scripts/cleanup.sh`).
- `rm` is permanent. Only delete `notes.txt` as the task says.
- `kill` — double-check the PID before running it. Kill only your own `sleep 500`.
- **Before publishing, check screenshots and text for private data:** IP addresses and MAC addresses (`ip a`), hostnames (`hostname`, shell prompt), logged-in users and remote IPs (`w`/`who`), listening services (`ss -tulnp`). Crop or blur anything you do not want public.
- Do not commit passwords.

## Publishing to GitHub

```bash
cd linux-command-line-activities
git init
git add .
git status                      # review what will be committed
git commit -m "Add Linux command line activities documentation"
git branch -M main
git remote add origin https://github.com/<your-username>/linux-command-line-activities.git
git push -u origin main
```

Suggested repo description: *Hands-on Linux command line practical: navigation, permissions, users, processes, archiving, networking and monitoring, documented with commands and screenshots.*
Suggested topics: `linux` `bash` `command-line` `sysadmin` `terminal` `permissions` `process-management` `networking` `learning-in-public`
