#r "C:\Users\m\scoop\apps\workspacer\current\workspacer.Shared.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.Gap\workspacer.Gap.dll"
#r "C:\Users\m\scoop\apps\workspacer\current\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"

using System;
using workspacer;
using workspacer.ActionMenu;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.FocusIndicator;
using workspacer.Gap;
using workspacer.TitleBar;

Action<IConfigContext> doConfig = (context) =>
{
    var fontSize = 9;
    var barHeight = 19;
    var fontName = "FiraCode NF";

    var gap = 4;
    var gapPlugin = context.AddGap(new GapPluginConfig() { InnerGap = gap, OuterGap = gap / 2, Delta = gap / 2 });

    context.AddBar(new BarPluginConfig()
    {
        FontName = fontName,
        LeftWidgets = () => new IBarWidget[] {
            new WorkspaceWidget(), new TextWidget(""), new TitleWidget() {
                IsShortTitle = true
            }, new TextWidget("")
        },
        RightWidgets = () => new IBarWidget[] {
            new TimeWidget(60 * 1000, "dd MMMM HH:mm"),
            new ActiveLayoutWidget()
        }
    });

    Func<ILayoutEngine[]> defaultLayouts = () => new ILayoutEngine[] {
        new FocusLayoutEngine(),
        new DwindleLayoutEngine(),
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

    context.WindowRouter.AddFilter((win) => !win.Title.Contains("(DEBUG)"));

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
    };
    setKeybindings();

    context.CanMinimizeWindows = false; // false by default

    var titleBarPluginConfig = new TitleBarPluginConfig();
    titleBarPluginConfig.SetWindowProcessName("gvim", new TitleBarStyle(showTitleBar: false, showSizingBorder: false));
    titleBarPluginConfig.SetWindowProcessName("WindowsTerminal", new TitleBarStyle(showTitleBar: false, showSizingBorder: false));
    context.AddTitleBar(titleBarPluginConfig);

    // Uncomment to switch update branch (or to disable updates)
    context.Branch = Branch.None;
};
return doConfig;
