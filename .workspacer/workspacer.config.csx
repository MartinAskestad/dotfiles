#region imports
#r "C:\Users\m\scoop\apps\workspacer\current\workspacer.Shared.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Gap\workspacer.Gap.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using workspacer;
using workspacer.ActionMenu;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.FocusIndicator;
using workspacer.Gap;
using workspacer.TitleBar;

var gapPluginConfig = new GapPluginConfig()
{
    InnerGap = 0,
    OuterGap = 0,
    Delta = 0
};

var focusIndicatorConfig = new FocusIndicatorPluginConfig()
{
    BorderColor = new Color(241, 133, 75),
    TimeToShow = 360
};

var barPluginConfig = new BarPluginConfig()
{
    FontName = "FiraCode NF",
    LeftWidgets = () => new IBarWidget[] {
               new WorkspaceWidget(),
               new TextWidget(""),
               new TitleWidget() {
                 IsShortTitle = false
               },
               new TextWidget("")
             },
    RightWidgets = () => new IBarWidget[] {
               new TimeWidget(60 * 1000, "dd MMMM HH:mm"),
               new ActiveLayoutWidget()
             },
};

var noTitleBarNoSizingBorder = new TitleBarStyle(showTitleBar: false, showSizingBorder: false);
var titleBarPluginConfig = new TitleBarPluginConfig()
{
    Rules = new List<TitleBarRule>() {
        new TitleBarRule(w => w.ProcessName.Contains("gvim"), noTitleBarNoSizingBorder),
        new TitleBarRule(w => w.ProcessName.Contains("WindowsTerminal"), noTitleBarNoSizingBorder),
        new TitleBarRule(w => w.Class.Contains("ConsoleWindowClass"), noTitleBarNoSizingBorder)
    }
};

var defaultLayouts = () => new ILayoutEngine[] {
    new DwindleLayoutEngine(),
        new FocusLayoutEngine(),
        new FullLayoutEngine()
  };

var bindKeys = (IConfigContext context) =>
    {
        var altCtrlWin = KeyModifiers.LAlt | KeyModifiers.Control | KeyModifiers.Win;
        var shiftAltCtrlWin = KeyModifiers.Shift | altCtrlWin;
        var binds = context.Keybinds;
        binds.UnsubscribeAll();
        binds.Subscribe(altCtrlWin, Keys.H, () => context.Workspaces.SwitchToPreviousWorkspace(), "Switch to previous workspace");
        binds.Subscribe(shiftAltCtrlWin, Keys.H, () => context.Workspaces.MoveFocusedWindowAndSwitchToPreviousWorkspace(), "Move focused window to previous workspace");
        binds.Subscribe(altCtrlWin, Keys.J, () => context.Workspaces.FocusedWorkspace.FocusPreviousWindow(), "Focus previous window");
        binds.Subscribe(shiftAltCtrlWin, Keys.J, () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "Swap previous window");
        binds.Subscribe(altCtrlWin, Keys.K, () => context.Workspaces.FocusedWorkspace.FocusNextWindow(), "Focus next window");
        binds.Subscribe(shiftAltCtrlWin, Keys.K, () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "Swap next window");
        binds.Subscribe(altCtrlWin, Keys.L, () => context.Workspaces.SwitchToNextWorkspace(), "Switch to next workspace");
        binds.Subscribe(shiftAltCtrlWin, Keys.L, () => context.Workspaces.MoveFocusedWindowAndSwitchToNextWorkspace(), "Move focused window to next workspace");
        binds.Subscribe(altCtrlWin, Keys.Y, () => context.Workspaces.FocusedWorkspace.SwapFocusAndPrimaryWindow(), "Make focused window primary window");
        binds.Subscribe(altCtrlWin, Keys.A, () => context.Workspaces.FocusedWorkspace.ExpandPrimaryArea(), "Expand primary window size");
        binds.Subscribe(shiftAltCtrlWin, Keys.A, () => context.Workspaces.FocusedWorkspace.IncrementNumberOfPrimaryWindows(), "Increment number of primary windows");
        binds.Subscribe(altCtrlWin, Keys.S, () => context.Workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "Shrink primary window size");
        binds.Subscribe(shiftAltCtrlWin, Keys.S, () => context.Workspaces.FocusedWorkspace.DecrementNumberOfPrimaryWindows(), "Decrement number of primary windows");
        binds.Subscribe(altCtrlWin, Keys.Q, () => context.Quit());
        binds.Subscribe(shiftAltCtrlWin, Keys.Q, () => context.Enabled = !context.Enabled);
        binds.Subscribe(shiftAltCtrlWin, Keys.U, () => context.Windows.DumpWindowDebugOutputForFocusedWindow());
    };

var buildMenu = (IConfigContext context, ActionMenuPlugin actionMenu) =>
{
    var builder = actionMenu.Create();
    // switch between workspaces
    builder.AddMenu("Switch between workspaces", () =>
    {
        var workspacesMenu = actionMenu.Create();
        context.WorkspaceContainer.GetAllWorkspaces()
        .ToList()
        .ForEach(w =>
        {
            workspacesMenu.Add(w.Name, () => context.Workspaces.SwitchToWorkspace(w));
        });
        return workspacesMenu;
    });
    // Move window to workspace
    builder.AddMenu("Move to workspace", () =>
    {
        var moveMenu = actionMenu.Create();
        context.WorkspaceContainer.GetAllWorkspaces()
        .Select((workspace, idx) => new { workspace = workspace, idx = idx })
        .ToList()
        .ForEach(w => { moveMenu.Add(w.workspace.Name, () => context.Workspaces.MoveFocusedWindowToWorkspace(w.idx)); });
        return moveMenu;
    });
    // Create a new workspace
    builder.AddFreeForm("Create new workspace", (name) => context.WorkspaceContainer.CreateWorkspace(name, defaultLayouts()));
    // Create a new full screen workspace
    builder.AddFreeForm("Create new full screen workspace", (name) => context.WorkspaceContainer.CreateWorkspace(name, new ILayoutEngine[] { new FullLayoutEngine() }));
    // Remove workspace
    builder.Add("Remove workspace", () => context.WorkspaceContainer.RemoveWorkspace(context.Workspaces.FocusedWorkspace));
    // Toggle enabled
    builder.Add("Toggle enabled/disabled", () => context.Enabled = !context.Enabled);
    // Quit workspacer
    builder.Add("Quit", () => context.Quit());
    builder.Add("Toggle console window", () => context.ToggleConsoleWindow());
    return builder;
};

var routeWindows = (IConfigContext context) =>
{
    // Routes
    context.WindowRouter.RouteProcessName("Discord", "メール");
    context.WindowRouter.RouteProcessName("OUTLOOK", "メール");
    context.WindowRouter.RouteProcessName("Teams", "メール");
    context.WindowRouter.RouteProcessName("HxOutlook", "メール");
    // Filters
    context.WindowRouter.IgnoreTitleMatch("vimrun");
    context.WindowRouter.AddFilter(w =>
    {
        var godotWindows = context.Workspaces.FocusedWorkspace.Windows.Count(_w => _w.ProcessName.Equals("godot", StringComparison.InvariantCultureIgnoreCase));
        if (godotWindows > 0)
        {
            return false;
        }
        return true;
    });
};

Action<IConfigContext> config = (context) =>
{
    var actionMenu = context.AddActionMenu();
    var menu = buildMenu(context, actionMenu);
    var gapPlugin = context.AddGap(gapPluginConfig);
    var titleBarPlugin = context.AddTitleBar(titleBarPluginConfig);
    context.AddFocusIndicator(focusIndicatorConfig);
    context.AddBar(barPluginConfig);
    context.DefaultLayouts = defaultLayouts;
    context.WorkspaceContainer.CreateWorkspaces("コード", "メール");
    bindKeys(context);
    routeWindows(context);
    context.Keybinds.Subscribe(KeyModifiers.LAlt | KeyModifiers.Control | KeyModifiers.Win, Keys.P, () => actionMenu.ShowMenu(menu), "Show action menu");
    context.Branch = Branch.None;
    // context.ConsoleLogLevel = LogLevel.Debug;
    // context.FileLogLevel = LogLevel.Debug;
};
return config;
