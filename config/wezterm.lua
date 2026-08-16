local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- 隐藏菜单栏
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "Windows"

-- 默认启动 Git Bash
config.default_prog = { "D:\\Program Files\\Git\\bin\\bash.exe", "--login" }

-- 字体（适合 neovim）
-- 显式指定中文回退字体并 scale，避免 CJK 字宽不足 2 格导致行号错位
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono NF", weight = "Medium" },
    { family = "Microsoft YaHei UI", scale = 1.25 },
})
config.font_size = 12.0

-- 窗口外观
config.window_background_opacity = 0.95
config.win32_system_backdrop = "Disable"

local f11_maximized = false
config.keys = {
    -- F11 最大化切换（保留系统任务栏）
    {
      key = "F11",
      action = wezterm.action_callback(function(window, _)
        if f11_maximized then
          window:restore()
          f11_maximized = false
        else
          window:maximize()
          f11_maximized = true
        end
      end),
    },

    -- Alt+<num> 切换到第 num 个 tab
    { key = "1", mods = "ALT", action = act.ActivateTab(0) },
    { key = "2", mods = "ALT", action = act.ActivateTab(1) },
    { key = "3", mods = "ALT", action = act.ActivateTab(2) },
    { key = "4", mods = "ALT", action = act.ActivateTab(3) },
    { key = "5", mods = "ALT", action = act.ActivateTab(4) },
    { key = "6", mods = "ALT", action = act.ActivateTab(5) },
    { key = "7", mods = "ALT", action = act.ActivateTab(6) },
    { key = "8", mods = "ALT", action = act.ActivateTab(7) },
    { key = "9", mods = "ALT", action = act.ActivateTab(8) },

    -- Ctrl+Alt+左右方向键: 左移/右移当前 tab
    { key = "LeftArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(-1) },
    { key = "RightArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },

    -- Ctrl+D: 智能关闭
    -- shell 下没有运行 TUI（如 neovim）→ 关闭 pane
    -- shell 下运行了 TUI 或非 shell 应用 → 透传 Ctrl+D
    {
      key = "d",
      mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
        local cursor = pane:get_cursor_position()
        local zone = pane:get_semantic_zone_at(cursor.x - 1, cursor.y)
        if zone and zone.semantic_type == "Prompt" then
          window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
        elseif zone and zone.semantic_type == "Input" then
          window:perform_action(act.SendKey({ key = "d", mods = "CTRL" }), pane)
        else
          local process = pane:get_foreground_process_name()
          local lower = process and string.lower(process) or ""
          local shells = {
            "powershell.exe", "pwsh.exe", "cmd.exe",
            "bash.exe", "zsh.exe", "wsl.exe", "nu.exe",
          }
          local is_shell = false
          for _, s in ipairs(shells) do
            if string.find(lower, s) then is_shell = true; break end
          end
          if is_shell and not pane:is_alt_screen_active() then
            window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
          else
            window:perform_action(act.SendKey({ key = "d", mods = "CTRL" }), pane)
          end
        end
      end),
    },
  }


return config
