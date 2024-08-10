{-# LANGUAGE LambdaCase #-}

import Customs (deb, spock)
import Monitors (date, eno1, gpu, headphones, locks, memory, multiCoreTemp, multiCpu, speakers, uptime)
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
    , XPosition (OnScreen, Top)
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
        { font = "Inconsolata Nerd Font Mono Bold 9"
        , additionalFonts = ["Inconsolata Nerd Font Mono Bold 18", "Noto Color Emoji Regular"]
        , bgColor = black myColorScheme
        , fgColor = cyan myColorScheme
        , position = OnScreen n Top
        , textOffset = 0
        , border = NoBorder
        , borderColor = black myColorScheme
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
    ]

myTemplate :: Int -> String
myTemplate n = left n ++ "}" ++ middle n ++ "{" ++ right n

left :: Int -> String
left 0 = "%_XMONAD_LOG_1%"
left 1 = "%_XMONAD_LOG_2%"
left 2 = "%_XMONAD_LOG_3%"
left _ = undefined

middle :: Int -> String
middle n = concat $ replicate (n + 1) "%spock%"

right :: Int -> String
right n = r !! n >>= \c -> if c == ' ' then separator else pure c

r :: [String]
r =
    [ "%locks% %speakers% %headphones% %uptime% %date%"
    , "%multicpu% %multicoretemp% %memory% %gpu% %eno1% %date%"
    , "%deb% %date%"
    ]

separator :: String
separator = "┊"

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
