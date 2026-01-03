-- Script de diagnostic pour le formatage
-- Exécutez : :source diagnose_format.lua

local function diagnose_format()
  print("=== DIAGNOSTIC DU FORMATAGE ===\n")
  
  -- 1. Vérifier si Conform est chargé
  local conform_ok, conform = pcall(require, "conform")
  if conform_ok then
    print("✅ Conform est chargé")
  else
    print("❌ Conform n'est PAS chargé: " .. tostring(conform))
    return
  end
  
  -- 2. Vérifier le PATH Mason
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  local path = vim.env.PATH or ""
  if string.find(path, mason_bin, 1, true) then
    print("✅ PATH Mason configuré: " .. mason_bin)
  else
    print("❌ PATH Mason NON configuré")
    print("   Attendu: " .. mason_bin)
    print("   PATH actuel: " .. path)
  end
  
  -- 3. Vérifier les formateurs installés
  print("\n=== FORMATEURS ===")
  local formatters = {
    "stylua",
    "black",
    "isort",
    "prettier",
    "sqlfluff",
  }
  
  for _, formatter in ipairs(formatters) do
    local found = false
    -- Vérifier dans le PATH système
    if vim.fn.executable(formatter) == 1 then
      print("✅ " .. formatter .. " (système)")
      found = true
    end
    -- Vérifier dans Mason
    local mason_path = mason_bin .. "/" .. formatter
    if vim.fn.filereadable(mason_path) == 1 then
      print("✅ " .. formatter .. " (Mason)")
      found = true
    end
    if not found then
      print("❌ " .. formatter .. " NON TROUVÉ")
    end
  end
  
  -- 4. Vérifier le type de fichier actuel
  print("\n=== BUFFER ACTUEL ===")
  local ft = vim.bo.filetype
  if ft == "" then
    print("⚠️  Aucun type de fichier détecté")
  else
    print("Type de fichier: " .. ft)
    local formatters_for_ft = conform.formatters_by_ft[ft]
    if formatters_for_ft then
      print("Formateurs configurés: " .. vim.inspect(formatters_for_ft))
    else
      print("⚠️  Aucun formateur configuré pour ce type de fichier")
    end
  end
  
  -- 5. Tester le formatage
  print("\n=== TEST ===")
  print("Appuyez sur <leader>f pour tester le formatage")
  print("Ou exécutez: :lua require('conform').format()")
end

diagnose_format()
