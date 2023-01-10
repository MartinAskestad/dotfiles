#r "C:\Users\m\scoop\apps\workspacer\current\workspacer.Shared.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Gap\workspacer.Gap.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"

using System;
using System.Collections.Generic;
using workspacer;
using workspacer.ActionMenu;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.FocusIndicator;
using workspacer.Gap;
using workspacer.TitleBar;

Action<IConfigContext> doConfig = (context) =>
{
    var fontName = "FiraCode NF";

    var gap = 6;
    var gapPlugin = context.AddGap(new GapPluginConfig() { InnerGap = gap, OuterGap = gap / 2, Delta = gap / 2 });

    context.AddBar(new BarPluginConfig()
    {
        FontName = fontName,
        LeftWidgets = () => new IBarWidget[] {
            new WorkspaceWidget(), new TextWidget(""), new TitleWidget() {
                IsShortTitle = false
            }, new TextWidget("")
        },
        RightWidgets = () => new IBarWidget[] {
            new TimeWidget(60 * 1000, "dd MMMM HH:mm"),
            new ActiveLayoutWidget()
        }
    });

    Func<ILayoutEngine[]> defaultLayouts = () => new ILayoutEngine[] {
            new DwindleLayoutEngine(),
                new FocusLayoutEngine(),
                new VertLayoutEngine()
    };
    context.DefaultLayouts = defaultLayouts;

    var secondaryLayout = new ILayoutEngine[] {
        new TallLayoutEngine(),
        new DwindleLayoutEngine()
    };

    (string, ILayoutEngine[])[] myWorkspaces = {
        ("コード", defaultLayouts()),
        ("メール", secondaryLayout)
    };
    foreach ((string name, ILayoutEngine[] layouts) in myWorkspaces)
    {
        context.WorkspaceContainer.CreateWorkspace(name, layouts);
    }
    context.WindowRouter.RouteProcessName("Discord", "メール");
    context.WindowRouter.RouteProcessName("OUTLOOK", "メール");
    context.WindowRouter.RouteProcessName("Teams", "メール");
    context.WindowRouter.RouteTitle("post", "メール");
    context.WindowRouter.RouteProcessName("mail", "メール");
    context.WindowRouter.RouteWindowClass("HxOutlook", "メール");
    context.WindowRouter.AddRoute((window) => window.Title.Contains("post") ? context.WorkspaceContainer["メール"] : null);
    context.WindowRouter.IgnoreTitleMatch("^.+\\(DEBUG\\)$");
    context.WindowRouter.IgnoreWindowClass("ApplicationFrameWindow");
    context.WindowRouter.AddRoute((window) => (window.Class.Equals("ApplicationFrameWindow") && (window.Title.Contains("Inkorgen") || window.Title.Contains("post")) ? context.WorkspaceContainer["メール"] : null));
    context.WindowRouter.IgnoreTitleMatch("winrun");

    var actionMenu = context.AddActionMenu();
    Func<ActionMenuItemBuilder> createActionMenuBuilder = () =>
    {
        var menuBuilder = actionMenu.Create();
        // Move window to workspace
        /* menuBuilder.AddMenu("move", () => */
        /* { */
        /*     var moveMenu = actionMenu.Create(); */
        /*     var focusedWorkspace = context.Workspaces.FocusedWorkspace; */
        /*     var workspaces = context.WorkspaceContainer.GetWorkspaces(focusedWorkspace).ToArray(); */
        /*     Func<int, Action> createChildMenu = (index) => () => { context.Workspaces.MoveFocusedWindowToWorkspace(index); }; */
        /*     for (int i = 0; i < workspaces.Length; i++) */
        /*     { */
        /*         moveMenu.Add(workspaces[i].Name, createChildMenu(i)); */
        /*     } */
        /*     return moveMenu; */
        /* }); */
        menuBuilder.Add("toggle keybind helper", () => context.Keybinds.ShowKeybindDialog());
        menuBuilder.Add("toggle enabled", () => context.Enabled = !context.Enabled);
        menuBuilder.Add("toggle console", () => context.ToggleConsoleWindow());
        menuBuilder.Add("restart", () => context.Restart());
        menuBuilder.Add("quit", () => context.Quit());
        return menuBuilder;
    };
    var actionMenuBuilder = createActionMenuBuilder();

    // keybindings
    Action setKeybindings = () =>
    {
        var winCtrlAlt = KeyModifiers.Win | KeyModifiers.Control | KeyModifiers.LAlt;
        var winCtrlAltShift = winCtrlAlt | KeyModifiers.Shift;
        var manager = context.Keybinds;
        var workspaces = context.Workspaces;
        manager.UnsubscribeAll();
        manager.Subscribe(winCtrlAlt, Keys.Q, () => context.Quit(), "Quit");
        manager.Subscribe(winCtrlAltShift, Keys.Q, () => context.Enabled = !context.Enabled, "Toggle enabled/disabled");
        manager.Subscribe(winCtrlAlt, Keys.J, () => workspaces.FocusedWorkspace.FocusPreviousWindow(), "Focus previous window");
        manager.Subscribe(winCtrlAlt, Keys.K, () => workspaces.FocusedWorkspace.FocusNextWindow(), "Focus next window");
        manager.Subscribe(winCtrlAltShift, Keys.J, () => workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "Swap focus and next window");
        manager.Subscribe(winCtrlAltShift, Keys.K, () => workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "Swap focus and next window");
        manager.Subscribe(winCtrlAltShift, Keys.D0, () => workspaces.SwitchToWorkspace(0), "Siwtch to first workspace");
        manager.Subscribe(winCtrlAltShift, Keys.D1, () => workspaces.SwitchToWorkspace(1), "Siwtch to second workspace");
        manager.Subscribe(winCtrlAlt, Keys.P, () => workspaces.FocusedWorkspace.SwapFocusAndPrimaryWindow(), "Swap focus and primary window");
        manager.Subscribe(winCtrlAlt, Keys.A, () => workspaces.FocusedWorkspace.ExpandPrimaryArea(), "Expand primary area");
        manager.Subscribe(winCtrlAlt, Keys.S, () => workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "Shrink primary area");
        manager.Subscribe(winCtrlAlt, Keys.I, () => actionMenu.ShowMenu(actionMenuBuilder), "Toggle console window");
        manager.Subscribe(winCtrlAlt, Keys.Y, () => workspaces.FocusedWorkspace.IncrementNumberOfPrimaryWindows(), "Increment number of primary windows");
        manager.Subscribe(winCtrlAlt, Keys.U, () => workspaces.FocusedWorkspace.DecrementNumberOfPrimaryWindows(), "Decrement number of primary windows");
    };
    setKeybindings();

    context.CanMinimizeWindows = false; // false by default

    var titleBarPluginConfig = new TitleBarPluginConfig();
    titleBarPluginConfig.SetWindowProcessName("gvim", new TitleBarStyle(showTitleBar: false, showSizingBorder: false));
    titleBarPluginConfig.SetWindowProcessName("WindowsTerminal", new TitleBarStyle(showTitleBar: false, showSizingBorder: false));
    titleBarPluginConfig.SetWindowProcessName("neovide", new TitleBarStyle(showTitleBar: false, showSizingBorder: false));
    context.AddTitleBar(titleBarPluginConfig);

    context.AddFocusIndicator();

    // Uncomment to switch update branch (or to disable updates)
    context.Branch = Branch.None;

    context.ConsoleLogLevel = LogLevel.Trace;
    // context.FileLogLevel = LogLevel.Trace;
};
return doConfig;
