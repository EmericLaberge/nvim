return {
  "onsails/lspkind.nvim",
  config = function()
    local lspkind = require("lspkind")
    -- Ne pas utiliser lspkind.init() car cela modifie CompletionItemKind globalement
    -- et cause une duplication d'icônes avec lspkind.cmp_format()
    -- À la place, on définit juste la couleur pour Copilot
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
  end,
}
