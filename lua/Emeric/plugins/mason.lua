return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Ensure mason is initialized before mason-lspconfig uses it
		require("mason").setup()

		-- Use shared settings from Emeric.lsp_setup
		local ok, lsp_setup = pcall(require, "Emeric.lsp_setup")
		local servers = {}
		if ok and lsp_setup.servers then
			servers = lsp_setup.servers
		end

		-- If no servers were provided by the shared lsp_setup, fall back to a large
		-- default list (from user-provided desired servers). This ensures we have
		-- a concrete list to validate against mason's available packages.
		if #servers == 0 then
			servers = {
				"templ", "vectorcode_server", "mesonlsp", "terraformls", "verible",
				"air", "millet", "angularls", "ginko_ls", "gitlab_ci_ls", "move_analyzer",
				"ansiblels", "antlersls", "neocmake", "steep", "stimulus_ls", "phpactor",
				"stylelint_lsp", "arduino_language_server", "nextflow_ls", "nextls", "asm_lsp",
				"just", "pkgbuild_language_server", "nickel_ls", "ast_grep", "kcl", "postgres_lsp",
				"powershell_es", "astro", "nimls", "autotools_ls", "kotlin_language_server",
				"awk_ls", "prismals", "cssmodules_ls", "cucumber_language_server",
				"solidity_ls_nomicfoundation", "remark_ls", "dagger", "rescriptls", "prosemd_lsp",
				"rnix", "cypher_ls", "laravel_ls", "robotframework_ls", "protols", "rome",
				"lelwel_ls", "solargraph", "omnisharp_mono", "stylua", "solidity", "fsautocomplete",
				"clarity_lsp", "solc", "rubocop", "biome", "ruby_lsp", "somesass_ls",
				"purescriptls", "gh_actions_ls", "sorbet", "ruff", "sourcery", "bright_script",
				"spectral", "hdl_checker", "spyglassmc_language_server", "pylyzer", "salt_ls",
				"herb_ls", "sqlls", "hoon_ls", "serve_d", "html", "pyre", "bzl", "standardrb",
				"htmx", "starlark_rust", "pylsp", "starpls", "qmlls", "hyprls", "shopify_theme_ls",
				"quick_lint_js", "theme_check", "openscad_lsp", "clangd", "gopls", "oxlint",
				"r_language_server", "marksman", "omnisharp", "perlnavigator", "pyright", "sqls",
				"texlab", "slangd", "reason_ls", "pest_ls", "emmet_ls", "buf_ls", "emmylua_ls",
				"erg_language_server", "textlsp", "tflint", "erlangls", "esbonio", "eslint",
				"thriftls", "expert", "facility_language_server", "lexical", "jdtls", "zls",
				"fennel_language_server", "tofu_ls", "fennel_ls", "docker_language_server", "ltex_plus",
				"tombi", "fish_lsp", "dprint", "dotls", "ltex", "flux_lsp", "lua_ls", "ts_query_ls",
				"glsl_analyzer", "earthlyls", "luau_lsp", "lwc_ls", "clojure_lsp", "zk",
				"markdown_oxide", "yamlls", "cmake", "denols", "slint_lsp", "wgsl_analyzer",
				"veryl_ls", "golangci_lint_ls", "pbls", "efm", "elp", "vuels", "smithy_ls",
				"vls", "fortls", "azure_pipelines_ls", "foam_ls", "vimls", "intelephense",
				"codebook", "hls", "tsp_server", "snakeskin_ls", "java_language_server",
				"visualforce_ls", "snyk_ls", "elmls", "twiggy_language_server", "opencl_ls",
				"ocamllsp", "solidity_ls", "bacon_ls", "ts_ls", "codeqlls", "raku_navigator",
				"docker_compose_language_service", "typos_lsp", "gradle_ls", "solang", "emmet_language_server",
				"pyrefly", "vtsls", "psalm", "dhall_lsp_server", "grammarly", "rpmspec",
				"vue_ls", "jedi_language_server", "julials", "puppet", "diagnosticls", "bashls",
				"dockerls", "copilot", "jqls", "bsl_ls", "bazelrc_lsp", "basedpyright",
				"superhtml", "coq_lsp", "haxe_language_server", "harper_ls", "beancount", "swift_mesonls",
				"svelte", "matlab_ls", "mm0_ls", "jsonls", "svlangserver", "hydra_lsp",
				"motoko_lsp", "unocss", "svls", "nil_ls", "nim_langserver", "bicep", "groovyls",
				"jinja_lsp", "graphql", "vhdl_ls", "helm_ls", "jsonnet_ls", "ember", "pico8_ls",
				"systemd_ls", "elixirls", "lemminx", "crystalline", "cobol_ls", "ols", "v_analyzer",
				"tailwindcss", "csharp_ls", "custom_elements_ls", "cairo_ls", "taplo", "cspell_ls",
				"kotlin_lsp", "rust_analyzer", "vala_ls", "cssls", "teal_ls", "nginx_language_server",
				"glint", "vale_ls", "mutt_ls", "css_variables", "mdx_analyzer",
			}
		end

		local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
		if not ok_mlsp or not mlsp then
			vim.notify("mason-lspconfig not available; skipping mason integration", vim.log.levels.WARN)
			mlsp = nil
		end

		-- Try to get the list of available server names from mason-lspconfig using the
		-- API shape you reported (get_available_servers, get_installed_servers, get_mappings).
		local available = nil
		local mappings = nil

		if type(mlsp.get_available_servers) == "function" then
			local ok, res = pcall(mlsp.get_available_servers)
			if ok and type(res) == "table" then
				available = res
			end
		end

		if not available then
			-- Backwards-compatible probes for older/newer APIs
			local probes = { "available_servers", "get_available_server_names", "get_servers" }
			for _, fn in ipairs(probes) do
				if mlsp[fn] and type(mlsp[fn]) == "function" then
					local ok, res = pcall(mlsp[fn])
					if ok and type(res) == "table" then
						available = res
						break
					end
				end
			end
		end

		-- Try to get mappings (if provided) so we can translate between requested lsp names
		-- and mason's names. Be defensive: mapping shapes may vary so handle both directions.
		if type(mlsp.get_mappings) == "function" then
			local ok, res = pcall(mlsp.get_mappings)
			if ok and type(res) == "table" then
				mappings = res
			end
		end

		-- Known manual mappings (fallbacks for renamed/deprecated server names)
		local name_map = {
			tsserver = "ts_ls",
			-- reverse fallback in case lspconfig still provides the old name
			ts_ls = "tsserver",
		}

 		-- Build the list of lspconfig server names we should ensure are installed.
 		-- mason-lspconfig expects lspconfig server names in ensure_installed.
 		-- Use mapping tables to translate between mason package names and lspconfig names.
 		local ensure_lsp_names = {}
 		local lsp_to_pkg = nil
 		local pkg_to_lsp = nil
		if mappings then
			lsp_to_pkg = mappings.lspconfig_to_package or mappings.lsp_to_pkg or mappings.lsp_to_package
			pkg_to_lsp = mappings.package_to_lspconfig or mappings.pkg_to_lsp or mappings.package_to_lsp
		end

		local function contains(tbl, val)
			for _, v in ipairs(tbl) do if v == val then return true end end
			return false
		end

		if available then
			for _, name in ipairs(servers) do
				local lsp_name = nil

				-- If the name is an lspconfig name (maps to a mason package), accept it
				if lsp_to_pkg and lsp_to_pkg[name] then
					lsp_name = name
				end

				-- If the name is a mason package, map it back to lspconfig name
				if not lsp_name and pkg_to_lsp and pkg_to_lsp[name] then
					lsp_name = pkg_to_lsp[name]
				end

				-- If the name itself appears in the available packages (i.e., it's a mason pkg)
				-- but we don't have a mapping, skip it because ensure_installed expects lspconfig names.
				if not lsp_name and contains(available, name) then
					-- no mapping to lspconfig; skip with a warning
					vim.notify("mason-lspconfig: package '" .. name .. "' has no lspconfig mapping; skipping", vim.log.levels.WARN)
					lsp_name = nil
				end

				-- Manual fallback mapping (e.g., tsserver -> ts_ls)
				if not lsp_name and name_map[name] then
					local candidate = name_map[name]
					-- ensure candidate maps to an available package if possible
					if lsp_to_pkg and lsp_to_pkg[candidate] and contains(available, lsp_to_pkg[candidate]) then
						lsp_name = candidate
					else
						-- candidate might already be an lspconfig name (no package check)
						lsp_name = candidate
					end
				end

				-- As a last resort, if we can detect it's a valid lspconfig server (via lsp_to_pkg or pkg_to_lsp), accept it
				if not lsp_name then
					if lsp_to_pkg and lsp_to_pkg[name] then lsp_name = name end
					if pkg_to_lsp and pkg_to_lsp[name] then lsp_name = pkg_to_lsp[name] end
				end

				if lsp_name then
					-- avoid dupes
					if not vim.tbl_contains(ensure_lsp_names, lsp_name) then
						table.insert(ensure_lsp_names, lsp_name)
					end
				else
					vim.notify("mason-lspconfig: skipping unknown/unsupported server '" .. tostring(name) .. "' (no lspconfig name)", vim.log.levels.WARN)
				end
			end
		else
			vim.notify("mason-lspconfig: could not probe available servers; skipping ensure_installed and relying on automatic_installation", vim.log.levels.WARN)
		end

		if mlsp and type(mlsp.setup) == "function" then
			if #ensure_lsp_names > 0 then
				mlsp.setup({ ensure_installed = ensure_lsp_names, automatic_installation = true })
			else
				mlsp.setup({ automatic_installation = true })
			end
		else
			vim.notify("mason-lspconfig.setup not available; skipping ensure_installed", vim.log.levels.WARN)
		end

		-- If we have the shared on_attach/flags, register handlers here so mason-lspconfig
		-- is fully available when handlers are set.
		if ok and lsp_setup.on_attach and lsp_setup.lsp_flags then
			local lsp_flags = lsp_setup.lsp_flags
			local on_attach = lsp_setup.on_attach

			-- Some versions of mason-lspconfig may not expose setup_handlers.
			-- Configure servers manually via lspconfig to be robust.
			-- Prefer the new API: vim.lsp.config (see :help lspconfig-nvim-0.11). Fallback to require('lspconfig').
			local lspconfig_api = nil
			-- Prefer using the built-in vim.lsp.config API when present to avoid
			-- triggering the deprecation warning emitted by requiring 'lspconfig'.
			if vim and vim.lsp and vim.lsp.config then
				lspconfig_api = { kind = "vim_lsp_config", api = vim.lsp.config }
			else
				local ok_lsp, lspconfig = pcall(require, "lspconfig")
				if ok_lsp and lspconfig then
					lspconfig_api = { kind = "lspconfig", api = lspconfig }
				else
					vim.notify("lspconfig not available; skipping server setup", vim.log.levels.WARN)
					return
				end
			end

			-- Cache a direct lspconfig table (if available) to avoid requiring it multiple times
			local cached_lspconfig = nil
			if lspconfig_api and lspconfig_api.kind == "lspconfig" then
				cached_lspconfig = lspconfig_api.api
			end

			for _, requested in ipairs(servers) do
				-- Build a small ordered list of candidate lspconfig server names to try.
				-- Candidates can be:
				--  - a name mapped from a mason package -> lspconfig (pkg_to_lsp)
				--  - the requested name itself (it might already be the lspconfig name)
				--  - a manual fallback from name_map
				--  - any pkg_to_lsp reverse match
				local candidates = {}
				local seen = {}

				local function add_candidate(c)
					if not c or seen[c] then return end
					seen[c] = true
					table.insert(candidates, c)
				end

				-- If requested is a mason package, pkg_to_lsp will map it to the lsp name.
				if pkg_to_lsp and pkg_to_lsp[requested] then
					add_candidate(pkg_to_lsp[requested])
				end

				-- Try the requested name itself
				add_candidate(requested)

				-- If lsp_to_pkg maps requested -> package, then the lsp name is requested.
				if lsp_to_pkg and lsp_to_pkg[requested] then
					add_candidate(requested)
				end

				-- manual fallback
				if name_map[requested] then
					add_candidate(name_map[requested])
				end

				-- If mappings contain package_to_lspconfig table, try reverse lookup for packages referencing this requested name.
				if pkg_to_lsp then
					for pkg, lspname in pairs(pkg_to_lsp) do
						if lspname == requested then
							add_candidate(lspname)
						end
					end
				end

				-- Try candidates in order and attempt to configure each until one succeeds.
				local chosen = nil
				for _, cand in ipairs(candidates) do
					local cfg = { on_attach = on_attach, flags = lsp_flags }
					local configured = false
					-- Try lspconfig server setup (cached) if available
					if cached_lspconfig and cached_lspconfig[cand] and type(cached_lspconfig[cand].setup) == "function" then
						pcall(function() cached_lspconfig[cand].setup(cfg) end)
						configured = true
					end
					-- Try vim.lsp.config[cand].setup
					if not configured and vim.lsp and vim.lsp.config and vim.lsp.config[cand] and type(vim.lsp.config[cand].setup) == "function" then
						pcall(function() vim.lsp.config[cand].setup(cfg) end)
						configured = true
					end
					-- Try setup_default for new API
					if not configured and lspconfig_api and lspconfig_api.kind == "vim_lsp_config" and type(lspconfig_api.api.setup_default) == "function" then
						local ok, _ = pcall(function() lspconfig_api.api.setup_default(cand, cfg) end)
						if ok then configured = true end
					end
					if configured then chosen = cand break end
				end

				if requested == "jdtls" then
					-- jdtls requires a data directory per project; skip automatic setup.
				elseif requested == "phpactor" or chosen == "phpactor" then
					local cfg = { on_attach = on_attach, flags = lsp_flags, init_options = { ["language_server_phpstan.enabled"] = false, ["language_server_psalm.enabled"] = false, } }
					local configured = false
					-- Try lspconfig phpactor setup (cached) first
					if cached_lspconfig and cached_lspconfig.phpactor and type(cached_lspconfig.phpactor.setup) == "function" then
						pcall(function() cached_lspconfig.phpactor.setup(cfg) end)
						configured = true
					end
					-- Try vim.lsp.config
					if not configured and vim.lsp and vim.lsp.config and vim.lsp.config.phpactor and type(vim.lsp.config.phpactor.setup) == "function" then
						pcall(function() vim.lsp.config.phpactor.setup(cfg) end)
						configured = true
					end
					-- Try setup_default as last resort
					if not configured and lspconfig_api and lspconfig_api.kind == "vim_lsp_config" and type(lspconfig_api.api.setup_default) == "function" then
						pcall(function() lspconfig_api.api.setup_default("phpactor", cfg) end)
						configured = true
					end
					if not configured then
						vim.notify("phpactor: failed to configure via available lsp APIs", vim.log.levels.WARN)
					end
				elseif chosen then
					local cfg = { on_attach = on_attach, flags = lsp_flags }
					local configured = false
					-- Try lspconfig server setup (cached) if available
					if cached_lspconfig and cached_lspconfig[chosen] and type(cached_lspconfig[chosen].setup) == "function" then
						pcall(function() cached_lspconfig[chosen].setup(cfg) end)
						configured = true
					end
					-- Try vim.lsp.config[chosen].setup
					if not configured and vim.lsp and vim.lsp.config and vim.lsp.config[chosen] and type(vim.lsp.config[chosen].setup) == "function" then
						pcall(function() vim.lsp.config[chosen].setup(cfg) end)
						configured = true
					end
					-- Try setup_default for new API
					if not configured and lspconfig_api and lspconfig_api.kind == "vim_lsp_config" and type(lspconfig_api.api.setup_default) == "function" then
						local ok, _ = pcall(function() lspconfig_api.api.setup_default(chosen, cfg) end)
						if ok then configured = true end
					end
					if not configured then
						vim.notify("Failed to setup server: " .. tostring(chosen) .. " (requested: " .. tostring(requested) .. ")", vim.log.levels.WARN)
					end
				else
					vim.notify("No candidate lsp server found for requested: " .. tostring(requested) .. "; attempted: " .. vim.inspect(candidates), vim.log.levels.WARN)
				end
			end
		end
	end,
}
