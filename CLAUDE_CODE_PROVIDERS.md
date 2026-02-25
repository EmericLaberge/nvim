# Configuration Claude Code avec Multi-Provider

Ce guide explique comment configurer Claude Code dans Neovim pourswitcher entre Anthropic et MiniMax.

## Fichiers à créer

### 1. Scripts provider

Créer le dossier `~/.local/bin/claude-providers/` et les fichiers suivants:

**`claude-anthropic`** (Anthropic par défaut):
```bash
#!/usr/bin/env bash
# Claude Anthropic provider
unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL API_TIMEOUT_MS ANTHROPIC_API_KEY
exec /CHEMIN/VERS/CLAUDE "$@"
```

**`claude-minimax`** (MiniMax M2.5):
```bash
#!/usr/bin/env bash
# Claude MiniMax provider
# La clé API est définie dans ~/.zshrc (variable $MINIMAX_KEY)
unset ANTHROPIC_API_KEY ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL API_TIMEOUT_MS
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_KEY"
export ANTHROPIC_BASE_URL="https://api.minimax.io/anthropic"
export ANTHROPIC_MODEL="MiniMax-M2.5"
export API_TIMEOUT_MS="3000000"
exec /CHEMIN/VERS/CLAUDE "$@"
```

**`claude-anthropic-yolo`** (Anthropic sans permissions):
```bash
#!/usr/bin/env bash
unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL API_TIMEOUT_MS ANTHROPIC_API_KEY
exec /CHEMIN/VERS/CLAUDE --dangerously-skip-permissions "$@"
```

**`claude-minimax-yolo`** (MiniMax sans permissions):
```bash
#!/usr/bin/env bash
# La clé API est définie dans ~/.zshrc (variable $MINIMAX_KEY)
unset ANTHROPIC_API_KEY ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_MODEL API_TIMEOUT_MS
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_KEY"
export ANTHROPIC_BASE_URL="https://api.minimax.io/anthropic"
export ANTHROPIC_MODEL="MiniMax-M2.5"
export API_TIMEOUT_MS="3000000"
exec /CHEMIN/VERS/CLAUDE --dangerously-skip-permissions "$@"
```

Rendre les scripts exécutables:
```bash
chmod +x ~/.local/bin/claude-providers/claude-*
```

### 2. Trouver le chemin du binaire Claude

**Sur Linux:**
```bash
which claude
# ou
ls ~/.local/bin/claude -> ~/.local/share/claude/versions/X.X.X
```

**Sur Mac:**
```bash
which claude
# ou
ls ~/.local/bin/claude
# ou souvent: ~/Library/Caches/claude-ai/... ou ~/Library/Application Support/claude
```

### 3. Config Neovim

Le fichier `lua/Emeric/plugins/claude-code.lua` contient déjà la configuration. Mettre à jour `PROVIDER_SCRIPTS` avec les bons chemins:

```lua
local PROVIDER_SCRIPTS = {
  anthropic = "/home/emeric/.local/bin/claude-providers/claude-anthropic",  -- Linux
  -- ou sur Mac:
  anthropic = "/Users/username/.local/bin/claude-providers/claude-anthropic",
  ...
}
```

## Utilisation

| Raccourci | Action |
|-----------|--------|
| `<leader>cc` | Choisir le provider via menu |
| `<leader>cca` | Anthropic (défaut) |
| `<leader>ccm` | MiniMax |
| `<leader>cay` | Anthropic YOLO |
| `<leader>cmy` | MiniMax YOLO |

## Troubleshooting

Si ça ne marche pas, vérifier que:
1. Les scripts sont exécutables: `ls -la ~/.local/bin/claude-providers/`
2. Le chemin vers le binaire claude est correct
3. Les variables d'environnement sont bien unset avant de définir les nouvelles
