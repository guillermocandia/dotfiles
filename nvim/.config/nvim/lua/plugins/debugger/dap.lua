return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local widgets = require("dap.ui.widgets")
    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<F5>", function()
      dap.continue()
    end, { desc = "Continue" })
    vim.keymap.set("n", "<F10>", function()
      dap.step_over()
    end, { desc = "Step over" })
    vim.keymap.set("n", "<F11>", function()
      dap.step_into()
    end, { desc = "Step into" })
    vim.keymap.set("n", "<F12>", function()
      dap.step_out()
    end, { desc = "Step out" })
    vim.keymap.set("n", "<Leader>db", function()
      dap.toggle_breakpoint()
    end, { desc = "Toggle breakepoint" })
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Set breakpoint message" })
    vim.keymap.set("n", "<Leader>dr", function()
      dap.repl.open()
    end, { desc = "Replay" })
    vim.keymap.set("n", "<Leader>dl", function()
      dap.run_last()
    end, { desc = "Run last" })
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      widgets.hover()
    end, { desc = "Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>dw", function()
      widgets.preview()
    end, { desc = "Preview" })
    vim.keymap.set("n", "<Leader>df", function()
      widgets.centered_float(widgets.frames)
    end, { desc = "Frames" })
    vim.keymap.set("n", "<Leader>ds", function()
      widgets.centered_float(widgets.scopes)
    end, { desc = "Scopes" })
  end,
}
