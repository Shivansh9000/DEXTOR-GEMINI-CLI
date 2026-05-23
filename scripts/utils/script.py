from pathlib import Path
p = Path('output/ai-dev-agent.sh')
s = p.read_text()
helper = '''
open_url(){
  local url="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[DRY ] xdg-open %s\n' "$url"
    return 0
  fi
  if has xdg-open; then
    xdg-open "$url" >/dev/null 2>&1 || true
  else
    warn "xdg-open not available; open this manually: $url"
  fi
}
'''
s = s.replace('pause_if_live(){ if [[ "$DRY_RUN" -eq 0 ]]; then read -r -p "$1" _; fi }\n', 'pause_if_live(){ if [[ "$DRY_RUN" -eq 0 ]]; then read -r -p "$1" _; fi }\n'+helper)
s = s.replace('      sudo pro attach || true\n      echo "Follow the on-screen link and code in your browser, sign in with Ubuntu One, complete verification, then return here."\n      pause_if_live "Press Enter after Ubuntu Pro attach completes in the terminal..."\n      sudo pro status || true\n', '      echo "Opening Ubuntu Pro attach page in your default browser..."\n      open_url "https://ubuntu.com/pro/attach"\n      sudo pro attach || true\n      echo "Follow the on-screen code from the terminal, sign in with Ubuntu One, complete verification, and return here."\n      pause_if_live "Press Enter after Ubuntu Pro attach completes in the terminal..."\n      sudo pro status || true\n')
s = s.replace('  if has wrangler; then\n    echo "A browser login may open locally or provide a local URL for Cloudflare auth."\n    wrangler login || true\n  else\n', '  if has wrangler; then\n    echo "Opening Cloudflare dashboard in your default browser before Wrangler login..."\n    open_url "https://dash.cloudflare.com/"\n    pause_if_live "Press Enter after the dashboard opens, then the agent will start Wrangler login..."\n    echo "A browser login may open locally or provide a local URL such as http://localhost:8787 for Cloudflare auth."\n    wrangler login || true\n    echo "Opening Cloudflare AI Gateway area in your browser..."\n    open_url "https://dash.cloudflare.com/?to=/:account/ai/ai-gateway"\n  else\n')
p.write_text(s)

g = Path('output/ai-dev-agent-guide.md')
text = g.read_text()
extra = '\n\n## Browser automation\n\nThe agent now uses `xdg-open` on Linux desktop systems to open the Ubuntu Pro attach page, the Cloudflare dashboard, and the Cloudflare AI Gateway area in the default browser when those guided steps begin.[cite:79][cite:60] This matches the documented Ubuntu Pro browser attach flow and complements Wrangler\'s own browser-based login behavior, which can open a browser or direct the user to a local URL during authentication.[cite:60][cite:41][cite:64]\n\nDuring Ubuntu Pro setup, the agent opens the attach page first, then runs `sudo pro attach` so the operator can paste the terminal code into the browser flow and complete Ubuntu One sign-in and verification.[cite:60][cite:65] During Cloudflare setup, the agent opens the dashboard before starting `wrangler login`, then opens the AI Gateway area so account-scoped configuration can be finished in the browser after CLI authentication.[cite:41][cite:46][cite:64]\n'
if '## Browser automation' not in text:
    text += extra
g.write_text(text)
print('patched agent')