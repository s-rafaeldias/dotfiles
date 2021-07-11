local dap = require 'dap'
local vimp = require 'vimp'

vim.fn.sign_define('DapBreakpoint',
                   {text = '🛑', texthl = '', linehl = '', numhl = ''})

require('dapui').setup {
    sidebar = {
        width = 100,
        elements = {"breakpoints", "stacks", "watches", "scopes"}
    }
}

-- Adapters
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {
        os.getenv('HOME') .. '/tmp/dap/vscode-node-debug2/out/src/nodeDebug.js'
    }
}

dap.adapters.go = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/tmp/dap/vscode-go/dist/debugAdapter.js'}
}

dap.configurations.go = {
    {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath('dlv'), -- Adjust to where delve is installed
        skipFiles = {"/usr/local/go/src/runtime/**"},
        console = 'integratedTerminal'
    }
}

dap.configurations.typescript = {
    {
        name = "Attach to server",
        type = 'node2',
        request = 'attach',
        protocol = 'inspector',
        address = 'localhost',
        port = 9229,
        stopOnEntry = true,
        preLaunchTask = "npm build",
        program = "${workspaceFolder}/server.ts",
        cwd = "${workspaceFolder}/",
        restart = true,
        smartSteps = true,
        sourceMaps = true,
        console = 'integratedTerminal',
        outFiles = {"${workspaceFolder/dist/**/*.js}"},
        skipFiles = {"<node_internals>/**", "node_modules/**"}
    }, {
        name = "Jest all files",
        type = 'node2',
        request = 'launch',
        protocol = 'inspector',
        port = 9229,
        smartSteps = true,
        sourceMaps = true,
        console = 'integratedTerminal',
        env = {
            FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099",
            ENV = "TEST",
            DEBUG = 1
        },
        cwd = "${workspaceFolder}/",
        runtimeArgs = {
            "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest",
            "--runInBand", "--detectOpenHandles", "--forceExit"
        },
        skipFiles = {"<node_internals>/**", "node_modules/**"}
    }, {
        name = "Jest current test file",
        type = 'node2',
        request = 'launch',
        protocol = 'inspector',
        port = 9229,
        smartSteps = true,
        sourceMaps = true,
        -- console = 'integratedTerminal',
        env = {
            FIREBASE_AUTH_EMULATOR_HOST = "localhost:9099",
            ENV = "TEST",
            DEBUG = 1
        },
        cwd = "${workspaceFolder}/",
        runtimeArgs = {
            "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest",
            "${file}", "--runInBand", "--detectOpenHandles", "--forceExit"
        },
        skipFiles = {"<node_internals>/**", "node_modules/**"}
    }
}

-- Configurations
local function debug_go_with_custom_args()
    local config = dap.configurations.go[1]
    local command = vim.fn.input("Args to run (whitespace separeted): ")
    local args = {}

    for arg in command:gmatch("%S+") do table.insert(args, arg) end

    config.args = args
    return config
end

-- Mappings
vimp.nnoremap({'override'}, '<Leader>ds',
              function() dap.run(debug_go_with_custom_args()) end)
vimp.nnoremap({'override'}, '<Leader>dd', function() dap.continue() end)
vimp.nnoremap({'override'}, '<F4>', function() dap.toggle_breakpoint() end)

vimp.nnoremap({'override'}, '<F8>', function() dap.step_out() end)
vimp.nnoremap({'override'}, '<F9>', function() dap.step_into() end)
vimp.nnoremap({'override'}, '<F10>', function() dap.step_over() end)
