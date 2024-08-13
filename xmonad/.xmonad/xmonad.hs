import ColorScheme
    ( ColorScheme
        ( black
        , blue
        , cyan
        , green
        , magenta
        , red
        , white
        , yellow
        )
    , myColorScheme
    )
import XMonad
    ( Default (def)
    , Full (Full)
    , Mirror (Mirror)
    , ScreenId (S)
    , Tall (Tall)
    , XConfig (focusedBorderColor, layoutHook, modMask, workspaces)
    , mod4Mask
    , spawn
    , windows
    , xmonad
    , (|||)
    )
import XMonad.Hooks.DynamicLog (xmobarBorder, xmobarColor)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.StatusBar
    ( defToggleStrutsKey
    , statusBarPropTo
    , withEasySB
    )
import XMonad.Hooks.StatusBar.PP
    ( PP
        ( ppCurrent
        , ppExtras
        , ppHidden
        , ppHiddenNoWindows
        , ppOrder
        , ppSep
        , ppTitleSanitize
        , ppUrgent
        , ppVisible
        , ppWsSep
        )
    , shorten
    , wrap
    , xmobarColor
    , xmobarRaw
    , xmobarStrip
    )
import XMonad.Layout.Magnifier (magnifiercz')
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers (logLayoutOnScreen, logTitlesOnScreen, xmobarColorL)

main =
    xmonad
        . ewmhFullscreen
        . ewmh
        . withEasySB myStatusBar defToggleStrutsKey
        $ myConfig

myStatusBar = xmobar0 <> xmobar1 <> xmobar2

xmobar0 = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 0" $ pure (myXmobarPP 0)

xmobar1 = statusBarPropTo "_XMONAD_LOG_2" "xmobar -x 1" $ pure (myXmobarPP 1)

xmobar2 = statusBarPropTo "_XMONAD_LOG_3" "xmobar -x 2" $ pure (myXmobarPP 2)

myConfig =
    def
        { modMask = mod4Mask
        , layoutHook = myLayout
        , workspaces = myWorkspaces
        , focusedBorderColor = "cyan"
        }
        `additionalKeysP` myKeys

myLayout =
    avoidStruts . noBorders $ tiled ||| Mirror tiled ||| Full ||| threeCol
    where
        threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
        tiled = Tall nmaster delta ratio
        nmaster = 1 -- Default number of windows in the master pane
        ratio = 1 / 2 -- Default proportion of screen occupied by master pane
        delta = 3 / 100 -- Percent of screen to increment by when resizing panes

myWorkspaces = map show [1 .. 12]

myKeys =
    [ ("M-S-<Return>", spawn "$HOME/.cargo/bin/alacritty")
    , ("<Print>", spawn "$HOME/bin/foto")
    , ("<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh speakers +5")
    , ("<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh speakers -5")
    , ("S-<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh speakers +1")
    , ("S-<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh speakers -1")
    , ("M-<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh headphones +5")
    , ("M-<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh headphones -5")
    , ("M-S-<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh headphones +1")
    , ("M-S-<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/scripts/set-volume.sh headphones -1")
    , ("<XF86AudioMute>", spawn "$HOME/.xmonad/scripts/toggle-mute.sh speakers")
    , ("M-<XF86AudioMute>", spawn "$HOME/.xmonad/scripts/toggle-mute.sh headphones")
    ]
        ++ [ (otherModMasks ++ "M-" ++ key, action tag)
           | (tag, key) <-
                zip myWorkspaces (map (\x -> "<F" ++ show x ++ ">") [1 .. 12])
           , (otherModMasks, action) <-
                [ ("", windows . W.greedyView) -- or W.view
                , ("S-", windows . W.shift)
                ]
           ]

myXmobarPP :: Int -> PP
myXmobarPP n =
    def
        { ppCurrent = current . wrap " " " "
        , ppVisible = visible . wrap " " " "
        , ppHidden = hidden . wrap " " " "
        , ppHiddenNoWindows = hiddenNoWindows . wrap " " " "
        , ppUrgent = urgentRed . wrap (urgentYellow "!") (urgentYellow "!")
        , ppTitleSanitize = xmobarStrip
        , ppSep = " "
        , ppWsSep = ""
        , ppOrder = \[ws, _, _, wins, l] -> [ws, l, wins]
        , ppExtras = [titles, layout]
        }
    where
        titles = logTitlesOnScreen (S n) formatFocused formatUnfocused
        layout = xmobarColorL (black myColorScheme) (blue myColorScheme) $ logLayoutOnScreen (S n)
        formatFocused = xmobarColor (black myColorScheme) (cyan myColorScheme) . wrap "[" "]" . ppWindow
        formatUnfocused = hiddenNoWindows . wrap "[" "]" . ppWindow
        ppWindow :: String -> String
        ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

        urgentRed, urgentYellow, current, visible, hidden, hiddenNoWindows, wsSep :: String -> String
        current = xmobarColor (black myColorScheme) (cyan myColorScheme) . xmobarBorder "Top" (magenta myColorScheme) 2
        visible = xmobarColor (black myColorScheme) (blue myColorScheme) . xmobarBorder "Top" (magenta myColorScheme) 2
        hidden = xmobarColor (cyan myColorScheme) (black myColorScheme) . xmobarBorder "Top" (magenta myColorScheme) 2
        hiddenNoWindows = xmobarColor (blue myColorScheme) (black myColorScheme)

        wsSep = xmobarColor (black myColorScheme) (black myColorScheme)
        urgentYellow = xmobarColor (yellow myColorScheme) ""
        urgentRed = xmobarColor (red myColorScheme) ""
