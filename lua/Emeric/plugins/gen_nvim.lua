vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>', { desc = "Run Gen" })
require('gen').setup {
    opts = {
        model = "llama3.1",
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        quit_map = "q", -- set keymap for close the response window
        retry_map = "<c-r>", -- set keymap to re-send the current prompt
        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = {model = options.model, stream = true}
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model, $system, $context, $options
        -- For example: "ollama run $model '$prompt'"
        -- The command is executed in the background and receives the prompt as stdin.
        -- The response is read from stdout and opened in a new window.
        display_mode = "split", -- The display mode. Can be "float", "split", "vsplit", "tab"
        show_prompt = false, -- Shows the prompt submitted to Ollama in the response window
        show_model = false, -- Displays the model name in the response window
        no_auto_close = false, -- Never closes the window automatically after Ollama responds
        debug = false -- Prints errors and the command which is run.
    }
}
