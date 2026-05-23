---
title: "Plain English Mode"
description: "How technical errors in DEXTOR-GEMINI-CLI are translated into simple terms for everyone."
---

The environment features a **Plain English Narrator** (`scripts/utils/plain-english-narrator.sh`). This is designed to make technical issues understandable to non-technical users, ensuring that the system is transparent and approachable.

## Why it Matters

Users judge applications by their visual impact and clarity. By translating cryptic error messages (like `EACCES` or `docker_down`) into clear, actionable English, the environment feels modern, "alive," and polished.

## Sample Translations

| Technical Event | Plain English Explanation |
| :--- | :--- |
| `docker_down` | "The 'Docker' app is currently sleeping. You might need to start it up before you can work." |
| `git_auth_fail` | "Your GitHub keys aren't working right now. It's like the project's front door is locked." |
| `cloudflare_offline` | "Cloudflare (the project's security guard) is currently away from its post." |
| `session_locked` | "Your 1Password vault is currently locked. I can't reach your secret keys until you unlock it." |

## What to do if you see an alert?

Don't worry! Most messages will tell you exactly what's wrong. You can usually fix the issue by:
1.  Checking your internet connection.
2.  Unlocking your secret vault (1Password).
3.  Restarting the computer.
