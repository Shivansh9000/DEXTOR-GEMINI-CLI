# AI Dev Agent Guide

This package upgrades the earlier installer into a more interactive agent-style setup script. It still installs the developer, container, AI, and local LLM runtime stack first, and then continues into guided account-linked steps for Ubuntu Pro and Cloudflare browser authentication where those services require web-based sign-in and verification.[cite:57][cite:60][cite:41][cite:64]

## What this agent adds

The new script keeps the original machine-prep flow, including Docker, Node, Python, VS Code, GitHub CLI, Wrangler, Ollama, and AI environment scaffolding.[cite:26][cite:20][cite:39][cite:44][cite:16] After that baseline is in place, it can guide an Ubuntu-family host through Ubuntu Pro setup and then prompt for Cloudflare browser login so the machine can be linked to a developer account and prepared for AI Gateway usage.[cite:57][cite:58][cite:60][cite:41]

## Ubuntu Pro flow

Ubuntu Pro can be attached either by pasting a token directly with `sudo pro attach YOUR_TOKEN` or by starting `sudo pro attach` without a token and completing the browser-based attach flow using the code shown in the terminal.[cite:58][cite:60] Canonical’s documentation also notes that access to Ubuntu Pro portals is handled through Ubuntu One Single Sign On, so browser login and account verification are part of the normal attach workflow.[cite:62][cite:65]

In this agent, the Ubuntu Pro section is designed to:
- Ask whether to use browser/web login or a token.
- Install or update the Ubuntu Pro client first.
- Pause so the operator can complete Ubuntu One login and verification in a browser.
- Run `pro status` afterward for confirmation.[cite:60][cite:61]

## Cloudflare flow

Cloudflare’s Wrangler CLI uses browser-based authentication for first-time sign-in, and the Cloudflare documentation notes that the login step can open a browser or direct the user to a local login URL during CLI setup.[cite:41][cite:64] Because AI Gateway configuration is account-specific, the agent does not fabricate a gateway configuration automatically; instead, it performs the CLI login step and then gives browser instructions for creating or confirming the gateway and recording the gateway endpoint in the generated environment file.[cite:41][cite:46][cite:64]

## How to run

Make the script executable:

```bash
chmod +x ai-dev-agent.sh
```

Dry-run first:

```bash
./ai-dev-agent.sh --dry-run
```

Run normally:

```bash
./ai-dev-agent.sh
```

Force a machine label when needed:

```bash
./ai-dev-agent.sh --profile=laptop
./ai-dev-agent.sh --profile=workstation
./ai-dev-agent.sh --profile=vm
```

## What to expect during execution

On Ubuntu-family systems, the script can prompt for Ubuntu Pro setup after the base packages are installed. If browser mode is chosen, the terminal will show the link-and-code attach flow documented by Canonical, and the operator should complete the Ubuntu One sign-in and verification in the browser before returning to the terminal.[cite:60][cite:65]

Later, when the Cloudflare section starts, the script attempts `wrangler login`. On first use, that login may open the browser or give a local browser URL, after which the operator signs in to Cloudflare and returns to the terminal to continue.[cite:41][cite:64]

## Notes and limitations

- Ubuntu Pro is only meaningful on Ubuntu-family hosts, so the agent skips it on non-Ubuntu systems.[cite:57][cite:60]
- Ubuntu Pro account access is mediated through Ubuntu One SSO, which means email, password, and account verification are handled by Canonical’s web flow rather than by the local script directly.[cite:62][cite:65]
- Cloudflare AI Gateway setup remains account-specific and browser-driven; the agent can prepare CLI login and environment files, but the exact gateway resource still needs to be created or selected in the Cloudflare account context.[cite:41][cite:46][cite:64]
- NVIDIA/CUDA remains recommendation-driven in guided mode rather than fully automated because hardware-specific driver changes are riskier than the rest of the stack.[cite:12]


## Browser automation

The agent now uses `xdg-open` on Linux desktop systems to open the Ubuntu Pro attach page, the Cloudflare dashboard, and the Cloudflare AI Gateway area in the default browser when those guided steps begin.[cite:79][cite:60] This matches the documented Ubuntu Pro browser attach flow and complements Wrangler's own browser-based login behavior, which can open a browser or direct the user to a local URL during authentication.[cite:60][cite:41][cite:64]

During Ubuntu Pro setup, the agent opens the attach page first, then runs `sudo pro attach` so the operator can paste the terminal code into the browser flow and complete Ubuntu One sign-in and verification.[cite:60][cite:65] During Cloudflare setup, the agent opens the dashboard before starting `wrangler login`, then opens the AI Gateway area so account-scoped configuration can be finished in the browser after CLI authentication.[cite:41][cite:46][cite:64]
