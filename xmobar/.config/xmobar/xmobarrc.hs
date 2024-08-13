{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}

import ColorScheme
    ( ColorScheme
        ( black
        -- , blue
        , cyan
        -- , green
        , magenta
        -- , red
        -- , white
        -- , yellow
        )
    , myColorScheme
    )
import Customs (deb, headphones, speakers, spock)
import Monitors (date, diskio, disku, eno1, gpu, locks, memory, multiCoreTemp, multiCpu, top, uptime)
import System.Environment (getArgs)
import Xmobar
    ( Border (NoBorder)
    , Config
        ( additionalFonts
        , alignSep
        , allDesktops
        , alpha
        , bgColor
        , border
        , borderColor
        , borderWidth
        , commands
        , fgColor
        , font
        , hideOnStart
        , lowerOnStart
        , overrideRedirect
        , persistent
        , pickBroadest
        , position
        , sepChar
        , template
        , textOffset
        , verbose
        )
    , Runnable (Run)
    , XMonadLog (XPropertyLog)
    , XPosition (OnScreen, TopH)
    , defaultConfig
    , xmobar
    )

main :: IO ()
main =
    getArgs >>= \case
        ["-x", n] -> xmobar . config $ read n
        _ -> xmobar . config $ 0

config :: Int -> Config
config n =
    defaultConfig
        { font = "Inconsolata Nerd Font Mono Bold 10"
        , additionalFonts = ["Inconsolata Nerd Font Mono Bold 18", "Noto Color Emoji Regular"]
        , bgColor = black ColorScheme.myColorScheme
        , fgColor = cyan ColorScheme.myColorScheme
        , position = OnScreen n $ TopH 18
        , textOffset = 0
        , border = NoBorder
        , borderColor = black ColorScheme.myColorScheme
        , borderWidth = 0
        , alpha = 255
        , hideOnStart = False
        , allDesktops = False
        , overrideRedirect = False
        , pickBroadest = False
        , lowerOnStart = False
        , persistent = True
        , commands = myCommands
        , sepChar = "%"
        , alignSep = "}{"
        , template = myTemplate n
        , verbose = False
        }

myCommands :: [Runnable]
myCommands =
    [ Run multiCpu
    , Run multiCoreTemp
    , Run memory
    , Run disku
    , Run diskio
    , Run date
    , Run locks
    , Run eno1
    , Run uptime
    , Run gpu
    , Run speakers
    , Run headphones
    , Run $ XPropertyLog "_XMONAD_LOG_1"
    , Run $ XPropertyLog "_XMONAD_LOG_2"
    , Run $ XPropertyLog "_XMONAD_LOG_3"
    , Run spock
    , Run deb
    , Run top
    ]

myTemplate :: Int -> String
myTemplate n = left n ++ "}" ++ middle n ++ "{" ++ right n

left :: Int -> String
left 0 = "%_XMONAD_LOG_1%"
left 1 = "%_XMONAD_LOG_2%"
left 2 = "%_XMONAD_LOG_3%"
left _ = ""

middle :: Int -> String
middle 0 = "%spock%"
middle _ = ""

right :: Int -> String
-- right n = r !! n >>= \c -> if c == ' ' then separator else pure c
right n =
    ( case n of
        0 -> "%locks%-%uptime%-%speakers% %headphones%-%date% "
        1 -> "%multicpu%-%multicoretemp%-%memory%-%date% "
        2 -> "%top%-%diskio%-%disku%-%eno1%-%deb%-%date% "
        _ -> ""
    )
        >>= \c -> if c == '-' then separator else pure c

-- unused %gpu

separator :: String
separator = "<fn=0><fc=" ++ magenta ColorScheme.myColorScheme ++ "," ++ black ColorScheme.myColorScheme ++ "> ┊ </fc></fn>"
