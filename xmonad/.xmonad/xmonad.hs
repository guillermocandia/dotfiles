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
import Data.Maybe (Maybe (Just))
import XMonad
    ( Default (def)
    , Full (Full)
    , ManageHook
    , Mirror (Mirror)
    , ScreenId (S)
    , Tall (Tall)
    , XConfig (borderWidth, focusFollowsMouse, focusedBorderColor, layoutHook, manageHook, modMask, normalBorderColor, workspaces)
    , className
    , doFloat
    , mod4Mask
    , spawn
    , terminal
    , title
    , windows
    , xmonad
    , (|||)
    )
import XMonad.Hooks.DynamicLog (xmobarBorder, xmobarColor)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (isDialog)
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
        , ppVisibleNoWindows
        , ppWsSep
        )
    , filterOutWsPP
    , shorten
    , wrap
    , xmobarColor
    , xmobarRaw
    , xmobarStrip
    )
import XMonad.Hooks.UrgencyHook (NoUrgencyHook (NoUrgencyHook), withUrgencyHook)
import XMonad.Layout.CircleEx (CircleEx (CircleEx, cDelta), circleEx)
import XMonad.Layout.Grid (Grid (Grid))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.OneBig (OneBig (OneBig))
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.ManageHook (composeAll, (-->), (<+>), (=?))
import XMonad.Prelude (Bool (True))
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers (logLayoutOnScreen, logTitlesOnScreen, xmobarColorL)
import XMonad.Util.NamedScratchpad (NamedScratchpad (NS), customFloating, namedScratchpadAction, namedScratchpadManageHook, scratchpadWorkspaceTag)

main :: IO ()
main =
    xmonad
        . ewmhFullscreen
        . ewmh
        . withEasySB myStatusBar defToggleStrutsKey
        . withUrgencyHook NoUrgencyHook
        $ myConfig

myStatusBar = xmobar0 <> xmobar1 <> xmobar2

xmobar0 = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 0" $ pure . f $ myXmobarPP 0

xmobar1 = statusBarPropTo "_XMONAD_LOG_2" "xmobar -x 1" $ pure . f $ myXmobarPP 1

xmobar2 = statusBarPropTo "_XMONAD_LOG_3" "xmobar -x 2" $ pure . f $ myXmobarPP 2

f = filterOutWsPP [scratchpadWorkspaceTag]

myConfig =
    def
        { modMask = mod4Mask
        , workspaces = myWorkspaces
        , terminal = "alacritty"
        , layoutHook = myLayout
        , manageHook = myManageHook
        , normalBorderColor = black myColorScheme
        , focusedBorderColor = cyan myColorScheme
        , borderWidth = 1
        , focusFollowsMouse = True
        }
        `additionalKeysP` myKeys

myLayout =
    avoidStruts . smartBorders $ grid ||| column ||| row ||| full ||| circle ||| onebig
    where
        grid = renamed [Replace "grid"] Grid
        column =
            renamed [Replace "column"] $
                Tall 0 (1 / 2) (3 / 100)
        row =
            renamed [Replace "row"] $
                Mirror column
        full = renamed [Replace "full"] Full
        circle = renamed [Replace "circle"] circleEx
        onebig = renamed [Replace "onebig"] $ Mirror $ OneBig (3 / 4) (3 / 4)

myWorkspaces = map show [1 .. 12]

myKeys =
    [ ("<Print>", spawn "foto")
    , ("<XF86AudioRaiseVolume>", spawn "set-volume speakers +5")
    , ("<XF86AudioLowerVolume>", spawn "set-volume speakers -5")
    , ("S-<XF86AudioRaiseVolume>", spawn "set-volume speakers +1")
    , ("S-<XF86AudioLowerVolume>", spawn "set-volume speakers -1")
    , ("M-<XF86AudioRaiseVolume>", spawn "set-volume headphones +5")
    , ("M-<XF86AudioLowerVolume>", spawn "set-volume headphones -5")
    , ("M-S-<XF86AudioRaiseVolume>", spawn "set-volume headphones +1")
    , ("M-S-<XF86AudioLowerVolume>", spawn "set-volume headphones -1")
    , ("<XF86AudioMute>", spawn "toggle-mute speakers")
    , ("M-<XF86AudioMute>", spawn "toggle-mute headphones")
    , ("M-f", spawn "firefox")
    , ("M-u", namedScratchpadAction myScratchpads "pulsemixer")
    , ("M-o", namedScratchpadAction myScratchpads "obsidian")
    ]
        ++ [ (otherModMasks ++ "M-" ++ key, action tag)
           | (tag, key) <-
                zip myWorkspaces (map (\x -> "<F" ++ show x ++ ">") [1 .. 12])
           , (otherModMasks, action) <-
                [ ("", windows . W.greedyView)
                , ("S-", windows . W.shift)
                ]
           ]

myXmobarPP :: Int -> PP
myXmobarPP n =
    def
        { ppCurrent = current . xmobarBorder "Top" (green myColorScheme) 2 . wrap " " " "
        , ppVisible = visible . xmobarBorder "Top" (magenta myColorScheme) 2 . wrap " " " "
        , ppHidden = hidden . xmobarBorder "Top" (magenta myColorScheme) 2 . wrap " " " "
        , ppVisibleNoWindows = Just (visible . wrap " " " ")
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
        ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 40

        urgentRed, urgentYellow, current, visible, hidden, hiddenNoWindows, wsSep :: String -> String
        current = xmobarColor (black myColorScheme) (cyan myColorScheme)
        visible = xmobarColor (black myColorScheme) (blue myColorScheme)
        hidden = xmobarColor (cyan myColorScheme) (black myColorScheme)
        hiddenNoWindows = xmobarColor (blue myColorScheme) (black myColorScheme)

        wsSep = xmobarColor (black myColorScheme) (black myColorScheme)
        urgentYellow = xmobarColor (yellow myColorScheme) ""
        urgentRed = xmobarColor (red myColorScheme) ""

myManageHook :: ManageHook
myManageHook =
    composeAll
        [ className =? "dmengine" --> doFloat -- Defold
        , isDialog --> doFloat
        ]
        <+> namedScratchpadManageHook myScratchpads

myScratchpads :: [NamedScratchpad]
myScratchpads =
    [ NS "pulsemixer" "alacritty --title=pulsemixer --command pulsemixer" (title =? "pulsemixer") cf
    , NS "obsidian" "obsidian" (className =? "obsidian") cf
    ]
    where
        cf = customFloating $ W.RationalRect (1 / 8) (1 / 8) (6 / 8) (6 / 8)
