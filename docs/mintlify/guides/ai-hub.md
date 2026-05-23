---
title: "AI Hub"
description: "Centralized local LLM management in DEXTOR-GEMINI-CLI for Ollama and LM Studio."
---

The **DEXTOR-GEMINI-CLI** uses a centralized hub to manage and share local AI models across all your projects in the `~/Projects` directory.

## Centralized Storage

All models are stored in a hidden directory within your Projects folder:
`~/Projects/.ai-hub`

- **Ollama:** Models are stored in `.ai-hub/ollama/models`.
- **LM Studio:** Models are stored in `.ai-hub/lm-studio/models`.

## Management Utility

We provide a utility script to manage this centralization:
`scripts/utils/ai-hub-manager.sh`

### Initial Setup
To set up the hub and configure your environment variables:
```bash
bash scripts/utils/ai-hub-manager.sh setup
```

### Migrating Models
To move your existing Ollama models from `~/.ollama` to the centralized hub:
```bash
bash scripts/utils/ai-hub-manager.sh move
```

## Configuring Tools

### Ollama
The installer automatically sets the `OLLAMA_MODELS` environment variable in your `.bashrc`. After setup, simply restart your terminal or run `source ~/.bashrc`.

### LM Studio
To point LM Studio to the centralized hub:
1. Open **LM Studio**.
2. Go to **Settings** > **Models**.
3. Locate the **Model Path** field.
4. Set it to: `/home/your-username/Projects/.ai-hub/lm-studio/models`.
