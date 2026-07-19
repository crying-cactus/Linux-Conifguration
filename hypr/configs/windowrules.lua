----------------------
---- WINDOWRULES  ----
----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Split-screen gamescope spanning rule (this is what floats/sizes/positions
-- the gamescope window across both DP-3 and DP-4 for dual-monitor split-screen)
hl.window_rule({
  name  = "gamescope-span-dual-monitor",
  match = { class = "gamescope" },
  float     = true,
  size      = "5120 1440",
  move      = "0 0",
  rounding_power = 10,
  border_size = 0,
})

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})
