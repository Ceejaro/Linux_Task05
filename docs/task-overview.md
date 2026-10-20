# Task Overview — Linux Command Line Activities

## Objective
Practise core Linux command-line skills across ten activities (navigation, files, permissions, users,
processes, searching, archiving, networking, monitoring).

## Exact names used by the task
| Item | Value |
|------|-------|
| Practice directory | `/tmp/practice_dir` |
| Files | `demo.txt`, `script.sh`, `notes.txt` |
| Text to add to `demo.txt` | `Linux is powerful` |
| Line inside `script.sh` | `echo "Hello Linux"` |
| New user | `student1` (add to `sudo` group) |
| Background process | `sleep 500 &` |
| Archive directory / archives | `backup_test`, `backup.tar`, `backup.tar.gz` |
| Ping target / count | `google.com`, 3 times |
| Log file | `/var/log/dmesg` |

## Activities in brief
1. **Navigation** — current directory, `ls` all files long format, create `/tmp/practice_dir`, return home.
2. **File creation & editing** — `touch`, `echo`, `nano`/`vim`, `cat`.
3. **File permissions** — create `script.sh`, check `ls -l`, make executable by the user only, run it.
4. **File operations** — copy, move, rename, delete.
5. **User & group management** — `whoami`, `w`/`who`, create `student1` (sudo), add to `sudo`.
6. **Process management** — `sleep 500 &`, `jobs`, `fg`, kill by PID, verify with `ps aux | grep sleep`.
7. **Disk & searching** — `df -h`, `free -h`, find `.sh` files in home, search "Linux" in `.txt` files in `/tmp/practice_dir/`.
8. **Archiving** — `backup_test` with files, `tar` archive, `gzip`, extract.
9. **Networking** — `ip a`, `ping` 3 times, `ss -tulnp`, hostname.
10. **Monitoring & logs** — `tail` 10 lines of `/var/log/dmesg`, `tail -f`, `uptime`, `top` (identify top CPU process).

## Submission requirements
The task document states **none**. This project therefore provides portfolio-style documentation
(screenshots, command history, outputs, reflection) rather than a formal submission.

## Ambiguities in the task and how this project handles them

| Where | Ambiguity | Decision in this project |
|-------|-----------|--------------------------|
| Activities 2–3 | Where to create `demo.txt` / `script.sh` | Your **home directory** (where Activity 1 leaves you). |
| Activity 4 | Rename and delete `demo.txt`/`notes.txt` — the home original or the copy in `/tmp/practice_dir/`? | The **home-directory original** is renamed to `notes.txt` and deleted. The **copy stays** in `/tmp/practice_dir/` so Activity 7's search of `.txt` files there has something to find. If your instructor meant the copy, adjust and note it. |
| Activity 3 | "Executable by the user only" | `chmod u+x script.sh` — adds execute for the owner and nothing for group/others. |
| Activity 3 | Shebang line | The task says to add only `echo "Hello Linux"`, so no shebang is added. It still runs from bash with `./script.sh`. |
| Activity 5 | Whether `student1` needs a home directory or password | Not specified. `-m` is used so the account has a home; no password is set (not requested). Plain `sudo useradd student1` also satisfies the task. |
| Activity 6 | Killing the job after `fg` | After `fg` the terminal is blocked. `Ctrl+Z` then `bg` returns the job to the background so you can `kill` it by PID. (Alternative: kill from a second terminal.) |
| Activity 7 | `find` for `.sh` in home after moving `script.sh` | May legitimately return nothing (or other `.sh` files, e.g. this repo's scripts if it lives in your home directory). Document whatever you see. |
| Activity 8 | Where `backup_test` lives; what "extract to test" means | Home directory. Extraction goes into a separate `extract_test/` directory so you can compare it with the original. |
| Activity 9 | `ss -tulnp` privileges | Run exactly as written first; process names for other users' sockets only appear with `sudo` (optional extra). |
| Activity 10 | `/var/log/dmesg` may not exist or be readable | Run the commands as written, record the real result, and use the documented fallbacks only if needed. |
