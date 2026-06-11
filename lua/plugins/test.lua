-- ~/.config/nvim/lua/plugins/test.lua
-- Test runner: neotest with Go + Python adapters.
--   * Go uses neotest-golang; debugging tests routes through nvim-dap-go
--     (dap_mode = "dap-go" is the adapter's default — verified June 2026).
--   * Python uses neotest-python with pytest + debugpy.
-- Add adapters for other languages here as needed (see neotest's wiki).
return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "fredrikaverpil/neotest-golang",
            "nvim-neotest/neotest-python",
        },
        keys = {
            { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
            { "<leader>ta", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run all (cwd)" },
            { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last" },
            {
                "<leader>td",
                function() require("neotest").run.run({ strategy = "dap" }) end,
                desc = "Debug nearest test",
            },
            { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary tree" },
            {
                "<leader>to",
                function() require("neotest").output.open({ enter = true, auto_close = true }) end,
                desc = "Show test output",
            },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test run" },
            { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Watch file" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang")({
                        go_test_args = { "-v", "-race", "-count=1" },
                    }),
                    require("neotest-python")({
                        runner = "pytest",
                        dap = { justMyCode = false },
                    }),
                },
                output = { open_on_run = true },
                quickfix = { open = false },
            })
        end,
    },
}
