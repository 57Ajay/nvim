-- ~/.config/nvim/lua/plugins/dap.lua
-- Debugging: nvim-dap + UI. Adapters are managed by mason:
--   delve    → Go        (needs the Go toolchain installed)
--   debugpy  → Python    (needs python3)
--   codelldb → Rust / Zig / C / C++ (prebuilt download)
--
-- Workflow: set breakpoints with <leader>db, start with <leader>dc (or <F5>),
-- step with <F10>/<F11>/<F12>, inspect with <leader>de, UI toggles via <leader>du.
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
            "theHamsta/nvim-dap-virtual-text",
            { "jay-babu/mason-nvim-dap.nvim", dependencies = { "mason-org/mason.nvim" } },
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                desc = "Conditional breakpoint",
            },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue / start" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step over" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate session" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
            { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Eval expression" },
            { "<F5>", function() require("dap").continue() end, desc = "DAP continue" },
            { "<F10>", function() require("dap").step_over() end, desc = "DAP step over" },
            { "<F11>", function() require("dap").step_into() end, desc = "DAP step into" },
            { "<F12>", function() require("dap").step_out() end, desc = "DAP step out" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Adapter installation + default setup via mason.
            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "python", "codelldb" },
                automatic_installation = false,
                handlers = {
                    function(config) -- default: codelldb and anything else
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    -- Go and Python get richer setups from dedicated plugins below.
                    delve = function() end,
                    python = function() end,
                },
            })

            -- Go (delve): debug configs + debugging closest test via require("dap-go").debug_test()
            require("dap-go").setup()

            -- Python (debugpy): prefer mason's debugpy venv, fall back to system python3.
            local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(vim.uv.fs_stat(debugpy) and debugpy or "python3")

            -- Inline variable values while stepping.
            require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol" })

            -- UI opens/closes with the session.
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Gutter signs
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
            vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "Visual" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DiagnosticError" })
        end,
    },
}
