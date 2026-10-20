# scripts/

The lab itself is intentionally **manual**: typing the commands is the learning, and several steps are
interactive or create users and delete files. So there is **no "run everything" script**.
These scripts only help with checking, documenting and tidying up.

| Script | Purpose | Changes the system? | Run as |
|--------|---------|---------------------|--------|
| `verify.sh` | Checks the end state of the lab (files, `student1`, archive, no leftover `sleep 500`) and prints PASS/FAIL/INFO | **No** (read-only) | normal user |
| `generate-gallery.sh` | Builds `evidence/GALLERY.md` from the screenshots that really exist in `evidence/screenshots/` | Writes one file inside this repo | normal user |
| `cleanup.sh` | Optionally removes lab files and the `student1` user, asking before each step | **Yes** (deletes; uses sudo for `userdel`) | normal user (it calls sudo itself) |

## Usage

```bash
# from the repository root
bash scripts/verify.sh
bash scripts/generate-gallery.sh
bash scripts/cleanup.sh      # only AFTER you have captured all evidence
```

## Notes
- `verify.sh` checks end state only; it does not replace screenshots. It never runs your `script.sh`.
- `verify.sh` assumes the choices documented in `docs/task-overview.md` (e.g. the home-directory `demo.txt` was the one renamed and deleted; `[INFO]` lines mark places where your interpretation may differ).
- `cleanup.sh` refuses to run as root and only touches the fixed paths listed in the script.
