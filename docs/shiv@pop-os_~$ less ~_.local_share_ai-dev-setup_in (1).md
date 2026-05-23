<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# shiv@pop-os:~\$ less ~/.local/share/ai-dev-setup/install.log

Use "fg" to return to nano.

[1]+  Stopped                 less ~/.local/share/ai-dev-setup/install.log
shiv@pop-os:~\$ docker --version
docker compose version
node --version
python3 --version
gh --version
wrangler --version
ollama --version
Docker version 29.5.2, build 79eb04c
Docker Compose version v5.1.4
v18.19.1
Python 3.12.3
Command 'gh' not found, but can be installed with:
sudo apt install gh
wrangler: command not found
ollama version is 0.24.0
shiv@pop-os:~\$ docker run hello-world
code --version
gh auth status || true
wrangler login
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
d5e71e642bf5: Download complete
Digest: sha256:0e760fdfbc48ba8041e7c6db999bb40bfca508b4be580ac75d32c4e29d202ce1
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:

1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
(amd64)
3. The Docker daemon created a new container from that image which runs the
executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it
to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
\$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
[https://hub.docker.com/](https://hub.docker.com/)

For more examples and ideas, visit:
[https://docs.docker.com/get-started/](https://docs.docker.com/get-started/)

1.121.0
f6cfa2ea2403534de03f069bdf160d06451ed282
x64
Command 'gh' not found, but can be installed with:
sudo apt install gh
wrangler: command not found
shiv@pop-os:~\$ sudo apt update
sudo apt install -y gh
[sudo] password for shiv:
Sorry, try again.
[sudo] password for shiv:
Hit:1 [https://download.docker.com/linux/ubuntu](https://download.docker.com/linux/ubuntu) noble InRelease
Hit:2 [https://packages.microsoft.com/repos/code](https://packages.microsoft.com/repos/code) stable InRelease
Hit:3 [http://apt.pop-os.org/proprietary](http://apt.pop-os.org/proprietary) noble InRelease
Hit:4 [http://apt.pop-os.org/release](http://apt.pop-os.org/release) noble InRelease
Hit:5 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble InRelease
Hit:6 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-security InRelease
Hit:7 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-updates InRelease
Hit:8 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-backports InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
22 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
gh
0 upgraded, 1 newly installed, 0 to remove and 22 not upgraded.
Need to get 8,836 kB of archives.
After this operation, 45.4 MB of additional disk space will be used.
Get:1 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-security/universe amd64 gh amd64 2.45.0-1ubuntu0.3 [8,836 kB]
Fetched 8,836 kB in 3s (2,605 kB/s)
Selecting previously unselected package gh.
(Reading database ... 274705 files and directories currently installed.)
Preparing to unpack .../gh_2.45.0-1ubuntu0.3_amd64.deb ...
Unpacking gh (2.45.0-1ubuntu0.3) ...
Setting up gh (2.45.0-1ubuntu0.3) ...
Processing triggers for man-db (2.12.0-4build2) ...
shiv@pop-os:~\$ npm install -g wrangler
npm bin -g
echo "\$PATH"
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'wrangler@4.94.0',
npm WARN EBADENGINE   required: { node: '>=22.0.0' },
npm WARN EBADENGINE   current: { node: 'v18.19.1', npm: '9.2.0' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@cloudflare/kv-asset-handler@0.5.0',
npm WARN EBADENGINE   required: { node: '>=22.0.0' },
npm WARN EBADENGINE   current: { node: 'v18.19.1', npm: '9.2.0' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'miniflare@4.20260521.0',
npm WARN EBADENGINE   required: { node: '>=22.0.0' },
npm WARN EBADENGINE   current: { node: 'v18.19.1', npm: '9.2.0' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'undici@7.24.8',
npm WARN EBADENGINE   required: { node: '>=20.18.1' },
npm WARN EBADENGINE   current: { node: 'v18.19.1', npm: '9.2.0' }
npm WARN EBADENGINE }
npm ERR! code EACCES
npm ERR! syscall mkdir
npm ERR! path /usr/local/lib/node_modules
npm ERR! errno -13
npm ERR! Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules'
npm ERR!  [Error: EACCES: permission denied, mkdir '/usr/local/lib/node_modules'] {
npm ERR!   errno: -13,
npm ERR!   code: 'EACCES',
npm ERR!   syscall: 'mkdir',
npm ERR!   path: '/usr/local/lib/node_modules'
npm ERR! }
npm ERR!
npm ERR! The operation was rejected by your operating system.
npm ERR! It is likely you do not have the permissions to access this file as the current user
npm ERR!
npm ERR! If you believe this might be a permissions issue, please double-check the
npm ERR! permissions of the file and its containing directories, or try running
npm ERR! the command again as root/Administrator.

npm ERR! A complete log of this run can be found in:
npm ERR!     /home/shiv/.npm/_logs/2026-05-23T07_55_13_147Z-debug-0.log
Unknown command: "bin"

To see a list of supported npm commands, run:
npm help
/home/shiv/.local/bin:/home/shiv/Downloads/google-cloud-sdk/bin:/home/shiv/.local/bin:/home/shiv/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
shiv@pop-os:~\$ export PATH="$(npm bin -g):$PATH"
echo 'export PATH="$(npm bin -g):$PATH"' >> ~/.bashrc
source ~/.bashrc
shiv@pop-os:~\$ tail -n 100 ~/.local/share/ai-dev-setup/install.log
Get:7 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-updates/universe amd64 python3-argcomplete all 3.1.4-1ubuntu0.1 [33.8 kB]
Get:8 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/main amd64 python3-platformdirs all 4.2.0-1 [16.1 kB]
Get:9 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 python3-userpath all 1.9.1-1 [9,416 B]
Get:10 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 pipx all 1.4.3-1 [787 kB]
Get:11 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/main amd64 pkg-config amd64 1.8.1-2build1 [7,264 B]
Get:12 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 python3-toml all 0.10.2-1 [16.5 kB]
Get:13 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-security/main amd64 python3-xmltodict all 0.13.0-1ubuntu0.24.04.1 [14.3 kB]
Get:14 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 ripgrep amd64 14.1.0-1 [1,551 kB]
Get:15 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble-updates/main amd64 tmux amd64 3.4-1ubuntu0.1 [480 kB]
Get:16 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 xsel amd64 1.2.1-1 [20.5 kB]
Get:17 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 yq all 3.1.0-3 [16.9 kB]
Get:18 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 shellcheck amd64 0.9.0-1 [2,845 kB]
Get:19 [http://apt.pop-os.org/ubuntu](http://apt.pop-os.org/ubuntu) noble/universe amd64 silversearcher-ag amd64 2.2.0+git20200805-1.1 [42.3 kB]
Fetched 10.0 MB in 5s (1,995 kB/s)
Selecting previously unselected package direnv.
(Reading database ... 274375 files and directories currently installed.)
Preparing to unpack .../00-direnv_2.32.1-2ubuntu0.24.04.3_amd64.deb ...
Unpacking direnv (2.32.1-2ubuntu0.24.04.3) ...
Selecting previously unselected package fzf.
Preparing to unpack .../01-fzf_0.44.1-1ubuntu0.3_amd64.deb ...
Unpacking fzf (0.44.1-1ubuntu0.3) ...
Selecting previously unselected package htop.
Preparing to unpack .../02-htop_3.3.0-4build1_amd64.deb ...
Unpacking htop (3.3.0-4build1) ...
Selecting previously unselected package libevent-core-2.1-7t64:amd64.
Preparing to unpack .../03-libevent-core-2.1-7t64_2.1.12-stable-9ubuntu2_amd64.deb ...
Unpacking libevent-core-2.1-7t64:amd64 (2.1.12-stable-9ubuntu2) ...
Selecting previously unselected package libutempter0:amd64.
Preparing to unpack .../04-libutempter0_1.2.1-3build1_amd64.deb ...
Unpacking libutempter0:amd64 (1.2.1-3build1) ...
Selecting previously unselected package python3-venv.
Preparing to unpack .../05-python3-venv_3.12.3-0ubuntu2.1_amd64.deb ...
Unpacking python3-venv (3.12.3-0ubuntu2.1) ...
Selecting previously unselected package python3-argcomplete.
Preparing to unpack .../06-python3-argcomplete_3.1.4-1ubuntu0.1_all.deb ...
Unpacking python3-argcomplete (3.1.4-1ubuntu0.1) ...
Selecting previously unselected package python3-platformdirs.
Preparing to unpack .../07-python3-platformdirs_4.2.0-1_all.deb ...
Unpacking python3-platformdirs (4.2.0-1) ...
Selecting previously unselected package python3-userpath.
Preparing to unpack .../08-python3-userpath_1.9.1-1_all.deb ...
Unpacking python3-userpath (1.9.1-1) ...
Selecting previously unselected package pipx.
Preparing to unpack .../09-pipx_1.4.3-1_all.deb ...
Unpacking pipx (1.4.3-1) ...
Selecting previously unselected package pkg-config:amd64.
Preparing to unpack .../10-pkg-config_1.8.1-2build1_amd64.deb ...
Unpacking pkg-config:amd64 (1.8.1-2build1) ...
Selecting previously unselected package python3-toml.
Preparing to unpack .../11-python3-toml_0.10.2-1_all.deb ...
Unpacking python3-toml (0.10.2-1) ...
Selecting previously unselected package python3-xmltodict.
Preparing to unpack .../12-python3-xmltodict_0.13.0-1ubuntu0.24.04.1_all.deb ...
Unpacking python3-xmltodict (0.13.0-1ubuntu0.24.04.1) ...
Selecting previously unselected package ripgrep.
Preparing to unpack .../13-ripgrep_14.1.0-1_amd64.deb ...
Unpacking ripgrep (14.1.0-1) ...
Selecting previously unselected package tmux.
Preparing to unpack .../14-tmux_3.4-1ubuntu0.1_amd64.deb ...
Unpacking tmux (3.4-1ubuntu0.1) ...
Selecting previously unselected package xsel.
Preparing to unpack .../15-xsel_1.2.1-1_amd64.deb ...
Unpacking xsel (1.2.1-1) ...
Selecting previously unselected package yq.
Preparing to unpack .../16-yq_3.1.0-3_all.deb ...
Unpacking yq (3.1.0-3) ...
Selecting previously unselected package shellcheck.
Preparing to unpack .../17-shellcheck_0.9.0-1_amd64.deb ...
Unpacking shellcheck (0.9.0-1) ...
Selecting previously unselected package silversearcher-ag.
Preparing to unpack .../18-silversearcher-ag_2.2.0+git20200805-1.1_amd64.deb ...
Unpacking silversearcher-ag (2.2.0+git20200805-1.1) ...
Setting up xsel (1.2.1-1) ...
Setting up htop (3.3.0-4build1) ...
Setting up silversearcher-ag (2.2.0+git20200805-1.1) ...
Setting up python3-platformdirs (4.2.0-1) ...
Setting up shellcheck (0.9.0-1) ...
Setting up python3-xmltodict (0.13.0-1ubuntu0.24.04.1) ...
Setting up python3-venv (3.12.3-0ubuntu2.1) ...
Setting up pkg-config:amd64 (1.8.1-2build1) ...
Setting up direnv (2.32.1-2ubuntu0.24.04.3) ...
Setting up python3-toml (0.10.2-1) ...
Setting up libutempter0:amd64 (1.2.1-3build1) ...
Setting up fzf (0.44.1-1ubuntu0.3) ...
Setting up ripgrep (14.1.0-1) ...
Setting up libevent-core-2.1-7t64:amd64 (2.1.12-stable-9ubuntu2) ...
Setting up python3-argcomplete (3.1.4-1ubuntu0.1) ...
Setting up tmux (3.4-1ubuntu0.1) ...
Setting up python3-userpath (1.9.1-1) ...
Setting up yq (3.1.0-3) ...
Setting up pipx (1.4.3-1) ...
Processing triggers for debianutils (5.17build1) ...
Processing triggers for desktop-file-utils (0.27-2build1) ...
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for gnome-menus (3.36.0-1.1ubuntu3) ...
Processing triggers for libc-bin (2.39-0ubuntu8.7) ...
Processing triggers for man-db (2.12.0-4build2) ...
[INFO] [Docker] Engine + Compose + Buildx
curl: (22) The requested URL returned error: 404
gpg: no valid OpenPGP data found.

That log shows two real issues in the generated pack: the Docker repo step used the wrong GPG URL for this Ubuntu-based Pop!_OS host, and `wrangler` failed because npm tried to install into a root-owned global directory without a user prefix. The good news is that the core environment is fine: Docker, Python, Node, Ollama, and GitHub CLI are now working or installable on the host, so this is a fixable packaging issue rather than a broken machine.[^1][^2][^3]

## What was fixed

- The installer script was patched to use the Ubuntu Docker repository path on Ubuntu-based systems like Pop!_OS, which avoids the 404 you saw on the earlier GPG fetch.[^1]
- The `wrangler` install path was adjusted to use a user-local npm prefix fallback, which avoids the `EACCES` error from `/usr/local/lib/node_modules`.
- The run guide was updated with the exact recovery steps for `gh`, `wrangler`, and the Pop!_OS/Docker repo mismatch.[^2][^4]


## What you should run now

Use these commands on the machine:

```bash
sudo apt update
sudo apt install -y gh
npm config set prefix "$HOME/.local/npm-global"
export PATH="$HOME/.local/npm-global/bin:$PATH"
echo 'export PATH="$HOME/.local/npm-global/bin:$PATH"' >> ~/.bashrc
npm install -g wrangler
wrangler --version
gh --version
```

If you want to re-test the installer after the patch, run:

```bash
./ai-dev-setup.sh --dry-run
```

Then, if the dry-run looks right, run it normally again.

## Updated pack

The pack has been updated with the corrected installer and the expanded run guide.

<div align="center">⁂</div>

[^1]: https://docs.docker.com/engine/install/ubuntu/

[^2]: https://github.com/imjasonh/gh-cli/blob/trunk/docs/install_linux.md

[^3]: https://docs.ollama.com/linux

[^4]: https://developers.cloudflare.com/workers/wrangler/install-and-update/

