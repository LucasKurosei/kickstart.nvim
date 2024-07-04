-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<Down>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<Right>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<Up>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>dd', dap.terminate, { desc = 'Debug: terminate debug session' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '', collapsed = '', circular = '' },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      -- Use this to override mappings for specific elements
      element_mappings = {},
      expand_lines = true,
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.33 },
            { id = 'breakpoints', size = 0.17 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 0.33,
          position = 'right',
        },
        {
          elements = {
            { id = 'repl', size = 0.55 },
            { id = 'console', size = 0.45 },
          },
          size = 0.27,
          position = 'bottom',
        },
      },
      controls = {
        enabled = true,
        -- Display controls in this element
        element = 'repl',
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }
    dap.configurations.rust = {
      {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = vim.fn.getcwd() .. '/target/debug/' .. vim.fn.getcwd():match '([^/]+)$',
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }
  end,
}
