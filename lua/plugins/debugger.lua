return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
     "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- =====================
    -- 🚀 UI SETUP
    -- =====================
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- =====================
    -- ⌨️ Keybindings
    -- =====================
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>ds", dap.step_over)
    vim.keymap.set("n", "<leader>di", dap.step_into)
    vim.keymap.set("n", "<leader>do", dap.step_out)
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)
    vim.keymap.set("n", "<Leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
    vim.keymap.set("n", "<Leader>dr", dap.repl.open)
    vim.keymap.set("n", "<Leader>dt", dap.terminate)
    vim.keymap.set("n", "<Leader>du", dapui.toggle)

    -- =====================
    -- 🟦 C / C++
    -- =====================
    dap.adapters.lldb = {
      type = "executable",
      command = "lldb-vscode", -- Change if needed
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch C/C++",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    -- =====================
    -- 🟨 C# (.NET Core)
    -- =====================
    local netcoredbg_path = "C:/tools/netcoredbg/netcoredbg.exe" -- 🔁 Change this
    dap.adapters.coreclr = {
      type = "executable",
      command = netcoredbg_path,
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Launch .NET",
        request = "launch",
        program = function()
          return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    -- =====================
    -- 🐍 Python
    -- =====================
    dap.adapters.python = function(cb, config)
      cb({
        type = "executable",
        command = os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python" or "python",
        args = { "-m", "debugpy.adapter" },
      })
    end

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "python"
          end
        end,
      },
    }

    -- =====================
    -- 🟩 Go (Delve)
    -- =====================
    dap.adapters.delve = function(callback, config)
      callback({
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
          detached = vim.fn.has("win32") == 0,
        },
      })
    end

    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug Test",
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug Module Test",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }

    -- =====================
    -- 🟦 Node.js (JavaScript/TypeScript)
    -- =====================
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = {
        vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
      },
    }

    dap.configurations.javascript = {
      {
        name = "Launch Node.js",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
    }

    -- =====================
    -- 🔶 Lua (Neovim runtime)
    -- =====================
    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = "127.0.0.1", port = 8086 })
    end

    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = function() return "127.0.0.1" end,
        port = function() return 8086 end,
      },
    }

    -- =====================
    -- ⚛️ React Native – Manual Setup Needed
    -- =====================
    -- For React Native, use VS Code or `nvim-dap-vscode-js` (very complex setup)
    -- If you want that added, let me know and I’ll guide you
  end,
}

