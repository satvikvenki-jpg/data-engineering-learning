# Windows Setup

## Purpose

Run Python in an isolated environment, without changing any work project. The first four weeks use Python's standard library and need no third-party packages.

## Prerequisites

- A local copy of this repository.
- PowerShell and a text editor.
- Python 3.12 or newer; Python 3.12 is used by the starter CI workflow.

## Steps

1. Open PowerShell in the repository root: the folder containing this README, `data/`, and `exercises/`.
2. Check for Python:

   ```powershell
   py --version
   ```

   If `py` is unavailable, try `python --version`. If neither works, install a supported Python release from the [official Python site](https://www.python.org/downloads/windows/) and reopen PowerShell. Use the installer's supported command setup rather than downloading an unofficial installer.

3. Create an isolated environment with the command that works on your machine:

   ```powershell
   py -m venv .venv
   ```

   If you have `python` rather than `py`, use `python -m venv .venv`.

4. Verify the environment directly. Activation is optional:

   ```powershell
   .\.venv\Scripts\python.exe --version
   .\.venv\Scripts\python.exe -m pip --version
   ```

5. Run the example:

   ```powershell
   .\.venv\Scripts\python.exe exercises/week01/row_counts.py
   ```

## Expected Result

```text
Source rows: 120
Target rows: 118
Missing rows: 2
```

This is a toy count comparison, not a database reconciliation tool. It does not connect to a database or modify data.

## Troubleshooting

- **Command not found:** reopen PowerShell after installation, or use the full path to your Python executable.
- **Cannot find the exercise:** check that you are in the repository root.
- **Activation is blocked:** use `.\.venv\Scripts\python.exe` directly; changing execution policy is unnecessary.
- **Python is bundled with your assistant:** it can be used by full path to create the environment. A personal installation is still useful outside the assistant.
- **No internet access:** do Weeks 1-4 using an already installed interpreter; leave package installation for a later session.

## Checkpoint

Explain the difference between a Python interpreter, a `.py` file, a virtual environment, and a third-party package. Explain why `.venv/` should not be committed.

Record your result in [PROGRESS.md](../PROGRESS.md), then continue to [Week 1](curriculum.md#week-1-compare-row-counts).
