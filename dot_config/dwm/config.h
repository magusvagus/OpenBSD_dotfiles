/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */

// vanity gaps patch VVV
static const unsigned int gappih    = 0;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 0;       /* vert inner gap between windows */
static const unsigned int gappoh    = 0;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 0;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
// vanity gaps patch |||

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

// top bar patch vvv
static const int vertpad            = 0;       /* vertical padding of bar */
static const int sidepad            = 0;       /* horizontal padding of bar */
// top bar patch |||

static const char *fonts[]          = { "DepartureMono Nerd Font:size=9" };
static const char dmenufont[]       = "DepartureMono Nerd Font:size=10";
// static const char col_gray1[]       = "#222222";
// static const char col_gray2[]       = "#444444";
// static const char col_gray3[]       = "#bbbbbb";
// static const char col_gray4[]       = "#eeeeee";
// static const char col_cyan[]        = "#005577";
// static const char custom_neon[]	    = "#46E0DE";
// static const char custom_neon1[]    = "#1f2335";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char custom_neon[]	    = "#534f47";
static const char custom_neon1[]    = "#3c3c34";
static const char testing[]    =      "#ffffff";
static const char *colors[][3]      = {
	/*                fg           bg            border      */
	/*             text left   left bg color bar  window inactive   */
	/*             text middle mid fg color bar  window active */
	[SchemeNorm] = { "#737373", "#101010", "#101010" },
	[SchemeSel]  = { "#737373", "#1f1f1f", "#1f1f1f"  },
};
/* tagging */ 
static const char *tags[] = {"󰘧", "2", "3", "4"};
//static const char *tags[] = {"󰐅", "2", "3", "4", "5"};
//static const char *tags[] = {"󰔈", "2", "3", "4"};
//static const char *tags[] = {"", "2", "3", "4", "5"};
//static const char *tags[] = {"󰐼", "2", "3", "4", "5"};
//static const char *tags[] = {"󰣨", "2", "3", "4", "5"};
//static const char *tags[] = {"1", "2", "3", "4", "5"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",       NULL,       NULL,       0,            1,           -1 },
	{ "qutebrowser",NULL,       NULL,  1 << 2,            0,           -1 },
	{ "Firefox",    NULL,       NULL,  1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */

static const char *dmenucmd[] = { "dmenu_run", "-m", 
				   dmenumon, "-fn", 
				   dmenufont, "-nb", 
				   "#101010", "-nf", /*left right field bg*/
				   "#737373", "-sb", /*right text*/
				   "#1f1f1f", "-sf", /*border and middle bg*/ 
		           "#737373",  		 /*middle text*/
				   NULL 
			        };
static const char *termcmd[] = { "sh", "-c", "LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 exec st", NULL };   
//static const char *termcmd[]  			= { "st", NULL };
// static const char *picom_trans_plus[]  = { "picom-trans", "-c", "+5", NULL };
// static const char *picom_trans_minus[]  = { "picom-trans", "-c", "-5", NULL };
static const char *picom_trans_toggle[] = { "picom-trans", "-ct", NULL };
static const char *mpc_prev[]  			= { "mpc","prev", NULL };
static const char *mpc_next[]  			= { "mpc", "next", NULL };
static const char *mpc_play_pause[]		= { "mpc", "toggle", NULL };
static const char *mpc_stop[]  			= { "mpc", "seek", "0", NULL };
//static const char *mpc_pause[]			= { "mpc-remote", "--pause", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	// { MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	// { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	// { MODKEY,                       XK_b,      togglebar,      {0} },
	// { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	// { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	// { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },
	// { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	// { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },

// rotate stack patch (rotate windows) VVV
	{ MODKEY,             XK_k,      rotatestack,    {.i = +1 } },
	{ MODKEY,             XK_j,      rotatestack,    {.i = -1 } },

	// these two commands keep the current window
	// focus position at the same space
	{ MODKEY,							XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,							XK_k,      focusstack,     {.i = -1 } },

// rotate stack patch (rotate windows) |||

// fake fullscreen patch VVV
	{ MODKEY,             XK_f,      fullscreen,     {0} },
// fake fullscreen patch |||
	
// vanity gaps patch ***
	{ MODKEY|ControlMask,				XK_h,      incrgaps,       {.i = +5 } },
	{ MODKEY|ControlMask,              XK_l,      incrgaps,       {.i = -5 } },
	// { MODKEY|Mod4Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +1 } },
	// { MODKEY|Mod4Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -1 } },
	// { MODKEY|Mod4Mask|ControlMask,  XK_h,      incrigaps,      {.i = +1 } },
	// { MODKEY|Mod4Mask|ControlMask,  XK_l,      incrigaps,      {.i = -1 } },
	// { MODKEY,			   XK_g,      togglegaps,     {0} },
	// { MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	// { MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
	// { MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
	// { MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
	// { MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },
	// { MODKEY|Mod4Mask,              XK_y,      incrohgaps,     {.i = +1 } },
	// { MODKEY|Mod4Mask,              XK_o,      incrohgaps,     {.i = -1 } },
	// { MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },
// vanity gaps patch **
	
	// { MODKEY,                       XK_Return, zoom,           {0} },
	//{ MODKEY,                       XK_Tab,    view,           {0} },
	// { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	// { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	// { MODKEY,                       XK_space,  setlayout,      {0} },
	//{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	//{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,				XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },

	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

	TAGKEYS(                        XK_q,                      0)
	TAGKEYS(                        XK_w,                      1)
	TAGKEYS(                        XK_e,                      2)
	TAGKEYS(                        XK_r,                      3)

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)

	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

	// kill dwm
	//{ MODKEY|ControlMask,           XK_q,      quit,           {0} },

	// kill window
	{ MODKEY|ControlMask,             XK_q,      killclient,     {0} }, 
	{ MODKEY,             			  XK_BackSpace,      killclient,     {0} }, 

	// restart
	// { MODKEY|ShiftMask,             XK_r,      restart,        {0} }, // might prob

	// cycle through layout
	// { MODKEY,                       XK_comma,  cyclelayout,    {.i = -1 } }, // might be prob
	// { MODKEY,                       XK_period, cyclelayout,    {.i = +1 } },

	// reset layout to base
	{ MODKEY|ControlMask,             XK_r,  setlayout,      {.v = &layouts[0]} },

    // mpc control
	{ MODKEY|ShiftMask,    			XK_n,    spawn,          {.v = mpc_prev } },
	{ MODKEY,						XK_n,    spawn,          {.v = mpc_next } },
	{ MODKEY,						XK_p,    spawn,          {.v = mpc_play_pause } },
	{ MODKEY|ShiftMask,				XK_p,    spawn,          {.v = mpc_stop } },
	//{ MODKEY|ControlMask,           XK_c,    spawn,          {.v = mpc_pause } },
    

	// toggle to previous workspace
	{ MODKEY,                       XK_Tab,    view,           {0} },

	// rotate panes
	// { MODKEY,                           XK_k,       movestack,      {.i = +1 } }, // might be prob
	// { MODKEY,                           XK_j,       movestack,      {.i = -1 } },

	// chace pane sizes
	{ MODKEY|ShiftMask,                 XK_h,       setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,                 XK_l,       setmfact,       {.f = +0.05} },
	//{ MODKEY|ShiftMask,                 XK_j,       setcfact,       {.f = +0.25} }, // might be prob
	//{ MODKEY|ShiftMask,                 XK_k,       setcfact,       {.f = -0.25} },

	// shift view
	//{ MODKEY,                           XK_Left,    shiftview,      {.i = -1 } }, // might be a prob
	//{ MODKEY,                           XK_Right,   shiftview,      {.i = +1 } },

	// move focus clockwise/counter clockwise
	{ MODKEY,                           XK_space,   focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,                 XK_space,   focusstack,     {.i = -1 } },
	{ MODKEY,                           XK_Return,   focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,                 XK_Return,   focusstack,     {.i = -1 } },

	// toggle stuff
	{ MODKEY,                           XK_b,       togglebar,      {0} },
	{ MODKEY,                           XK_g,       fullgaps,     {0} },

	// can be toggled with the mouse!!
	//{ MODKEY|ShiftMask,                 XK_f,       togglefloating, {0} },
	//{ MODKEY,                           XK_f,       togglefullscr,  {0} }, // might be a prob
    
    // change picom opacity
	{ MODKEY,                           XK_o,       spawn,          {.v = picom_trans_toggle }},

	// start terminal
    
    // turned off for ergonomic keyboard
	// { MODKEY,                           XK_Return,  spawn,          {.v = termcmd }},
	{ MODKEY,                           XK_t,       spawn,          {.v = termcmd }},
	{ MODKEY|ShiftMask,                 XK_t,       spawn,          SHCMD("xterm -fa 'DejaVu Sans Mono' -fs 8")},

	// start dmenu
	{ MODKEY,			    XK_d,       spawn,          {.v = dmenucmd } },

	// screenshot fullscreen, focused window and cropped 
	{MODKEY,                          XK_s,       spawn, SHCMD("scrot -z ~/screenshots/%b%d_%H%M%S.png")},
	{MODKEY|ShiftMask,                XK_s,       spawn, SHCMD("scrot -u -z ~/screenshots/%b%d_%H%M%S.png")},
	{MODKEY|ControlMask,              XK_s,       spawn, SHCMD("pkill xbanish; scrot -z -s --freeze ~/screenshots/%b%d_%H%M%S.png; xbanish -st 2 -m nw &")},

	// set keyboard to US
	{MODKEY|ShiftMask,                          XK_l,       spawn, SHCMD("setxkbmap us")},
	// switch keyboard layout
	// {MODKEY,                          XK_Page_Up,       spawn, SHCMD("/home/ed/.system_scripts/kb_layout.ksh up &")},
	// {MODKEY,                          XK_Page_Down,       spawn, SHCMD("/home/ed/.system_scripts/kb_layout.ksh down &")},
	{MODKEY,                          XK_comma,       spawn, SHCMD("/home/ed/.system_scripts/kb_layout.ksh up &")},
	{MODKEY,                          XK_period,       spawn, SHCMD("/home/ed/.system_scripts/kb_layout.ksh down &")},
	
	// set to monocle and remove bar
	// { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },
	// { MODKEY,                       XK_f,      togglebar,      {0} },
	// { MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[0]} },
	// { MODKEY|ShiftMask,             XK_f,      togglebar,      {0} },


};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	// { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	// { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	//{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

