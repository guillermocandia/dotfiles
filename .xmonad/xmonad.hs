import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops

import qualified XMonad.StackSet as W


myWorkspaces = map show [1..12]

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.xmonad/xmobarrc.hs" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask    = mod4Mask
    , layoutHook = myLayout
    , workspaces = myWorkspaces
    }
  `additionalKeysP` myKeys

myKeys =
    [ ("M-S-<Return>", spawn "xterm -class UXTerm -u8 -xrm '*allowSendEvents:true'")
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
    ++
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key)  <- zip myWorkspaces (map (\x -> "<F" ++ show x ++ ">") [1..12])
        , (otherModMasks, action) <- [ ("", windows . W.greedyView) -- or W.view
                                     , ("S-", windows . W.shift)]
    ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = " "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = current . wrap " " " "
    , ppVisible         = visible . wrap " " " "
    , ppHidden          = hidden . wrap " " " "
    , ppHiddenNoWindows = hiddenNoWindows . wrap " " " "
    , ppWsSep           = wsSep ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = current . wrap "[" "]" . ppWindow
    formatUnfocused = hiddenNoWindows . wrap "[" "]" . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    red, yellow, current, visible, hidden, hiddenNoWindows, wsSep :: String -> String
    current             = xmobarColor "black" "cyan"
    visible             = xmobarColor "black" "lightcyan"
    hidden              = xmobarColor "black" "darkgrey"
    hiddenNoWindows     = xmobarColor "darkgrey" "black"
    wsSep               = xmobarColor "black" "black"
    yellow              = xmobarColor "#f1fa8c" ""
    red                 = xmobarColor "#ff5555" ""
