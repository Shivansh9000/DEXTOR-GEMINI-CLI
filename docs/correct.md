<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# correct

Done — I generated the installer script with your confirmed scope: Ubuntu 24–26 and Debian-family support, all tool bundles A–J, conservative Ollama handling, and guided GPU detection/recommendation for NVIDIA or Intel iGPU machines.[^1][^2][^3][^4][^5]

## What’s included

The script installs a broad dev/homelab baseline: apt essentials, Docker Engine and Compose, Node tooling, Python tooling, VS Code, GitHub CLI, Cloudflare Wrangler, Ollama, and AI/environment scaffolding for Claude and Perplexity workflows. It also creates a report file, supports dry-run mode, and labels the detected profile, distro, and GPU recommendation path so you can audit before changing drivers or CUDA.[^2][^3][^4][^5][^6][^7][^1]

## GPU behavior

For NVIDIA systems, it does **not** force driver/CUDA changes; it detects the GPU and prints a distro-specific recommendation path for Ubuntu or Debian instead, which matches the safer guided mode you asked for. For Intel iGPU systems, it skips NVIDIA-specific changes and continues with the rest of the stack.[^3][^7]

## Files generated

- [ai-dev-setup.sh](sandbox:output/ai-dev-setup.sh)
- [README.txt](sandbox:output/README.txt)


## Next step

Run it first in dry-run mode on each machine class, then decide whether you want a second pass that adds:

- explicit model-pull presets for Ollama,
- optional AMD/ROCm branch,
- and a stricter NVIDIA branch that can install repo-based drivers automatically after a confirmation prompt.[^7][^2]

<div align="center">⁂</div>

[^1]: https://docs.docker.com/engine/install/ubuntu/

[^2]: https://docs.ollama.com/linux

[^3]: https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html

[^4]: https://developers.cloudflare.com/workers/wrangler/install-and-update/

[^5]: https://github.com/imjasonh/gh-cli/blob/trunk/docs/install_linux.md

[^6]: https://docs.docker.com/engine/install/debian/

[^7]: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

