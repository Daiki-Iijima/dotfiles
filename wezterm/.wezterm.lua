local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ──────────────────────────────────────────────
-- フォント
-- ──────────────────────────────────────────────
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Hack Nerd Font",
	"Menlo",
})
config.font_size = 14.0
config.line_height = 1.2

-- ──────────────────────────────────────────────
-- カラースキーム
-- ──────────────────────────────────────────────
config.color_scheme = "Tokyo Night"

-- ──────────────────────────────────────────────
-- ウィンドウ
-- ──────────────────────────────────────────────
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.initial_cols = 220
config.initial_rows = 50

-- ──────────────────────────────────────────────
-- タブバー
-- ──────────────────────────────────────────────
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.colors = {
	tab_bar = {
		background = "#1a1b26",
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1a1b26",
			fg_color = "#565f89",
		},
		inactive_tab_hover = {
			bg_color = "#24283b",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#565f89",
		},
		new_tab_hover = {
			bg_color = "#24283b",
			fg_color = "#c0caf5",
		},
	},
}

-- ──────────────────────────────────────────────
-- スクロール
-- ──────────────────────────────────────────────
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- ──────────────────────────────────────────────
-- カーソル
-- ──────────────────────────────────────────────
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- ──────────────────────────────────────────────
-- ベル無効化
-- ──────────────────────────────────────────────
config.audible_bell = "Disabled"

-- ──────────────────────────────────────────────
-- キーバインド (Leader = Ctrl+Space)
-- ──────────────────────────────────────────────
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- ペイン: 縦分割
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- ペイン: 横分割
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- ペイン移動 (hjkl)
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	-- ペイン: リサイズモード
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	-- ペイン: 閉じる
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	-- ペイン: ズーム (全画面トグル)
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	-- タブ: 新規
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- タブ: 次/前
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	-- タブ: 番号指定 (1-9)
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	-- タブ: 名前変更
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Tab name:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- コピーモード (tmuxの[に相当)
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	-- フォントサイズ
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	-- クイック選択 (URL・パスなどをマウスなしで選択)
	{ key = "Space", mods = "LEADER|SHIFT", action = act.QuickSelect },
}

-- リサイズモード用キーテーブル
config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "Escape", action = act.PopKeyTable },
		{ key = "q", action = act.PopKeyTable },
	},
}

-- ──────────────────────────────────────────────
-- マウス
-- ──────────────────────────────────────────────
config.mouse_bindings = {
	-- Cmd+クリックでURLを開く
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

-- ──────────────────────────────────────────────
-- タブタイトルにペイン情報を表示
-- ──────────────────────────────────────────────
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	local index = string.format(" %d: ", tab.tab_index + 1)
	local truncated = wezterm.truncate_right(title, max_width - #index - 1)
	return index .. truncated .. " "
end)

return config
