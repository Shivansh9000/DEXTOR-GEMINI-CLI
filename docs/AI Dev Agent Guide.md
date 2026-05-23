<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# AI Dev Agent Guide

This package upgrades the earlier installer into a more interactive agent-style setup script. It still installs the developer, container, AI, and local LLM runtime stack first, and then continues into guided account-linked steps for Ubuntu Pro and Cloudflare browser authentication where those services require web-based sign-in and verification.[^1][^2][^3][^4]

## What this agent adds

The new script keeps the original machine-prep flow, including Docker, Node, Python, VS Code, GitHub CLI, Wrangler, Ollama, and AI environment scaffolding. After that baseline is in place, it can guide an Ubuntu-family host through Ubuntu Pro setup and then prompt for Cloudflare browser login so the machine can be linked to a developer account and prepared for AI Gateway usage.[^2][^3][^5][^6][^7][^8][^9][^10][^1]

## Ubuntu Pro flow

Ubuntu Pro can be attached either by pasting a token directly with `sudo pro attach YOUR_TOKEN` or by starting `sudo pro attach` without a token and completing the browser-based attach flow using the code shown in the terminal. Canonical’s documentation also notes that access to Ubuntu Pro portals is handled through Ubuntu One Single Sign On, so browser login and account verification are part of the normal attach workflow.[^10][^11][^12][^2]

In this agent, the Ubuntu Pro section is designed to:

- Ask whether to use browser/web login or a token.
- Install or update the Ubuntu Pro client first.
- Pause so the operator can complete Ubuntu One login and verification in a browser.
- Run `pro status` afterward for confirmation.[^13][^2]


## Cloudflare flow

Cloudflare’s Wrangler CLI uses browser-based authentication for first-time sign-in, and the Cloudflare documentation notes that the login step can open a browser or direct the user to a local login URL during CLI setup. Because AI Gateway configuration is account-specific, the agent does not fabricate a gateway configuration automatically; instead, it performs the CLI login step and then gives browser instructions for creating or confirming the gateway and recording the gateway endpoint in the generated environment file.[^3][^4][^14]

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

On Ubuntu-family systems, the script can prompt for Ubuntu Pro setup after the base packages are installed. If browser mode is chosen, the terminal will show the link-and-code attach flow documented by Canonical, and the operator should complete the Ubuntu One sign-in and verification in the browser before returning to the terminal.[^12][^2]

Later, when the Cloudflare section starts, the script attempts `wrangler login`. On first use, that login may open the browser or give a local browser URL, after which the operator signs in to Cloudflare and returns to the terminal to continue.[^4][^3]

## Notes and limitations

- Ubuntu Pro is only meaningful on Ubuntu-family hosts, so the agent skips it on non-Ubuntu systems.[^1][^2]
- Ubuntu Pro account access is mediated through Ubuntu One SSO, which means email, password, and account verification are handled by Canonical’s web flow rather than by the local script directly.[^11][^12]
- Cloudflare AI Gateway setup remains account-specific and browser-driven; the agent can prepare CLI login and environment files, but the exact gateway resource still needs to be created or selected in the Cloudflare account context.[^14][^3][^4]
- NVIDIA/CUDA remains recommendation-driven in guided mode rather than fully automated because hardware-specific driver changes are riskier than the rest of the stack.[^15]


## Browser automation

The agent now uses `xdg-open` on Linux desktop systems to open the Ubuntu Pro attach page, the Cloudflare dashboard, and the Cloudflare AI Gateway area in the default browser when those guided steps begin. This matches the documented Ubuntu Pro browser attach flow and complements Wrangler's own browser-based login behavior, which can open a browser or direct the user to a local URL during authentication.[^16][^2][^3][^4]

During Ubuntu Pro setup, the agent opens the attach page first, then runs `sudo pro attach` so the operator can paste the terminal code into the browser flow and complete Ubuntu One sign-in and verification. During Cloudflare setup, the agent opens the dashboard before starting `wrangler login`, then opens the AI Gateway area so account-scoped configuration can be finished in the browser after CLI authentication.[^2][^3][^4][^12][^14]
<span style="display:none">[^17][^18][^19][^20][^21][^22][^23][^24][^25][^26]</span>

<div align="center">⁂</div>

[^1]: https://documentation.ubuntu.com/pro/attach-tutorial/

[^2]: https://ubuntu.com/server/docs/tutorial/attach-your-ubuntu-pro-subscription/

[^3]: https://developers.cloudflare.com/workers/get-started/guide/

[^4]: https://developers.cloudflare.com/workers/wrangler/

[^5]: https://docs.docker.com/engine/install/ubuntu/

[^6]: https://docs.docker.com/engine/install/debian/

[^7]: https://developers.cloudflare.com/workers/wrangler/install-and-update/

[^8]: https://github.com/imjasonh/gh-cli/blob/trunk/docs/install_linux.md

[^9]: https://docs.ollama.com/linux

[^10]: https://documentation.ubuntu.com/pro-client/en/v30/howtoguides/get_token_and_attach/

[^11]: https://documentation.ubuntu.com/pro/_sources/account-setup.rst.txt

[^12]: https://documentation.ubuntu.com/pro/account-setup/

[^13]: https://documentation.ubuntu.com/landscape/how-to-guides/ubuntu-pro/attach-ubuntu-pro/

[^14]: https://developers.cloudflare.com/workers/wrangler/commands/

[^15]: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

[^16]: https://manpages.ubuntu.com/manpages/focal/man1/xdg-open.1.html

[^17]: https://github.com/cloudflare/workers-sdk/issues/2874

[^18]: https://www.youtube.com/watch?v=_T9Y-Seux2k

[^19]: https://github.com/cloudflare/workers-sdk/issues/10696

[^20]: https://labex.io/tutorials/linux-linux-xdg-open-command-with-practical-examples-423013

[^21]: https://www.youtube.com/watch?v=ZyM7s6iFMrE

[^22]: https://www.youtube.com/watch?v=czDKJxfJWQo

[^23]: https://news.ycombinator.com/item?id=28642652

[^24]: https://www.facebook.com/ubuntulinux/videos/ubuntu-pro-for-wsl-is-a-windows-application-that-automates-the-attachment-of-you/1366705492132355/

[^25]: https://docs.piral.io/guidelines/deploy/cloudflare

[^26]: https://oneuptime.com/blog/post/2026-03-02-how-to-attach-ubuntu-pro-to-your-server/view

