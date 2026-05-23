# What is this project doing?

Hi! This page explains how this project looks after itself in simple terms.

## The Helpers (Our "Guards")

We have three special helpers that run in the background to make sure everything is working correctly. If they find a problem, they will send a message to the computer screen.

### 1. Sentinel (The Tool Helper)
- **What it does:** It checks if the "Docker" app is running. Docker is like a specialized toolbox that holds all the project's tools.
- **Why it matters:** If Docker isn't running, the project can't start.
- **Message you might see:** "The 'Docker' app is currently sleeping..."

### 2. Forge (The Work Helper)
- **What it does:** It makes sure the project can talk to "GitHub" (where we save our work) and checks if there are any "disagreements" between different versions of the work.
- **Why it matters:** This makes sure no work gets lost or confused.
- **Message you might see:** "Your GitHub keys aren't working right now..." or "There's a disagreement between your work and the saved version."

### 3. Aegis (The Internet Helper)
- **What it does:** It checks if the computer can talk to the internet securely through a service called "Cloudflare."
- **Why it matters:** This keeps the project safe and connected.
- **Message you might see:** "Cloudflare is currently away from its post."

## What to do if you see a message?
Don't worry! Most of the time, the message will tell you exactly what's wrong. You can usually just restart the computer or check the internet connection to fix it.
