return {
    {
        "frankroeder/parrot.nvim",
        commit = "8a0d1b02b9e69e7d0165b8014a34855f7904bb21",
        dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
        config = function()
            local parrot = require("parrot")
            parrot.setup({
                providers = {
                    custom = {
                        style = "openai",
                        api_key = os.getenv "OPENROUTER_API_KEY",
                        endpoint = "https://openrouter.ai/api/v1/chat/completions",
                        models = { 
                            "anthropic/claude-3.7-sonnet", 
                        },
                        topic = {
                            model = "google/gemini-2.0-flash-001",
                            params = { max_completion_tokens = 64 },
                        },
                        params = {
                            chat = { temperature = 1.1, top_p = 1 },
                            command = { temperature = 1.1, top_p = 1 },
                        },
                    },
                }
            })
        end,
    },
}
