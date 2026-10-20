# submission/

## What the task requires
The uploaded task lists **no formal submission requirements**. This folder packages your results for **GitHub portfolio
documentation**. Complete it with your own real output.

## What to prepare

| Item | Where | Notes |
|------|-------|-------|
| Screenshots | `../evidence/screenshots/` | 28 required + 1 optional; names in `../evidence/README.md` |
| Command history | `command-history.txt` | The commands you actually typed |
| Final output | `final-output.txt` | Key outputs pasted as text, plus short notes |
| Reflection | `../docs/lessons-learned.md` | In your own words |
| Environment table + results tick-list | `../README.md` | Fill in placeholders |

## Capturing command history
Run this in the **same terminal session** where you did the lab:

```bash
history | sed 's/^ *[0-9]* *//' | tail -n 200 > ~/command-history-raw.txt
```

- `sed` strips the history numbers; adjust `200` to cover the whole lab.
- Open `~/command-history-raw.txt`, delete commands unrelated to the lab, then paste the cleaned list into `command-history.txt`.
- If you used several terminals, merge them. History is written when a shell exits; `history -a` flushes the current session to `~/.bash_history`.
- Text typed *inside* `nano`/`vim` is not shell history — that is fine.
- **Remove anything private** before publishing.

## Final Verification Checklist
- [ ] All 10 activities completed
- [ ] 28 screenshots saved with the correct names (and the optional one if you took it)
- [ ] Screenshots reviewed for private data (IPs, MACs, hostnames, remote logins)
- [ ] `command-history.txt` filled in (no placeholders left)
- [ ] `final-output.txt` filled in (no placeholders left)
- [ ] `docs/lessons-learned.md` written
- [ ] README environment table filled in and Results Summary ticked
- [ ] `bash scripts/verify.sh` run; any `[FAIL]` understood
- [ ] `bash scripts/generate-gallery.sh` run
- [ ] Repository pushed to GitHub and checked in the browser
