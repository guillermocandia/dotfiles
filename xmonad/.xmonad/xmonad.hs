-- {-# OPTIONS_GHC -Wno-deferred-type-errors #-}
-- {-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

-- {-# OPTIONS_GHC -Wno-missing-signatures #-}
-- {-# OPTIONS_GHC -Wno-type-defaults #-}

import XMonad
    ( Default (def)
    , Full (Full)
    , Mirror (Mirror)
    , Tall (Tall)
    , XConfig (focusedBorderColor, layoutHook, modMask, workspaces)
    , mod4Mask
    , spawn
    , windows
    , xmonad
    , (|||)
    )
import XMonad.Hooks.DynamicLog (xmobarColor)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.StatusBar
    ( defToggleStrutsKey
    , statusBarProp
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
import XMonad.Util.Loggers (logTitles)

main =
    xmonad
        . ewmhFullscreen
        . ewmh
        . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
        $ myConfig

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

myXmobarPP :: PP
myXmobarPP =
    def
        { ppCurrent = current . wrap " " " "
        , ppVisible = visible . wrap " " " "
        , ppHidden = hidden . wrap " " " "
        , ppHiddenNoWindows = hiddenNoWindows . wrap " " " "
        , ppUrgent = urgentRed . wrap (urgentYellow "!") (urgentYellow "!")
        , ppTitleSanitize = xmobarStrip
        , ppSep = " "
        , ppWsSep = ""
        , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
        , ppExtras = [logTitles formatFocused formatUnfocused]
        }
    where
        formatFocused = current . wrap "[" "]" . ppWindow

        formatUnfocused = hiddenNoWindows . wrap "[" "]" . ppWindow

        ppWindow :: String -> String
        ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

        urgentRed, urgentYellow, current, visible, hidden, hiddenNoWindows, wsSep :: String -> String
        current = xmobarColor (black myColorScheme) (cyan myColorScheme)
        visible = xmobarColor (black myColorScheme) (blue myColorScheme)
        hidden = xmobarColor (cyan myColorScheme) (black myColorScheme)
        hiddenNoWindows = xmobarColor (blue myColorScheme) (black myColorScheme)

        wsSep = xmobarColor (black myColorScheme) (black myColorScheme)
        urgentYellow = xmobarColor (yellow myColorScheme) ""
        urgentRed = xmobarColor (red myColorScheme) ""

data ColorScheme = ColorScheme
    { black
      , red
      , green
      , yellow
      , blue
      , magenta
      , cyan
      , white
        :: String
    }

myColorScheme :: ColorScheme
myColorScheme =
    ColorScheme
        { black = "#3b4252"
        , red = "#bf616a"
        , green = "#a3be8c"
        , yellow = "#ebcb8b"
        , blue = "#81a1c1"
        , magenta = "#b48ead"
        , cyan = "#88c0d0"
        , white = "#e5e9f0"
        }
