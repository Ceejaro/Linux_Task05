# commands/

[`commands.sh`](commands.sh) lists every command for the lab **in order**, with comments.

⚠️ It is a **reference sheet, not a script to execute**. It exits immediately if you try to run it, because
several steps are interactive (`nano`, `fg`, `top`, `tail -f`), one needs a real PID, and others create users
and delete files. Copy the commands section by section into your terminal while following
[`../workflow/workflow.md`](../workflow/workflow.md).

Markers used in the file: `[SUDO]`, `[INTERACTIVE]`, `[NEEDS REAL PID]`, `[OPTIONAL]`, `[FALLBACK]`.
