return {
  "Bekaboo/dropbar.nvim",
  -- Charge le plugin seulement quand on ouvre un fichier (optimisation)
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("dropbar").setup({
      bar = {
        -- Désactive l'affichage si on scrolle trop vite ou pour éviter le flash
        update_interval = 30,
        hover = true,
      },
      icons = {
        ui = {
          bar = {
            separator = "  ",
            extends = "…",
          },
        },
      },
    })
  end,
}
