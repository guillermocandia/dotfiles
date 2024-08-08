import Customs(spock)
import Monitors (date, eno1, gpu, headphones, locks, memory, multiCoreTemp, multiCpu, speakers, upgradeable, uptime)
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
    , XMonadLog (XMonadLog)
    , XPosition (Top)
    , defaultConfig
    , xmobar
    )

main :: IO ()
main = xmobar config

config :: Config
config =
    defaultConfig
        { font = "Inconsolata Nerd Font Mono Bold 9"
        , additionalFonts = ["Inconsolata Nerd Font Mono Bold 18", "Noto Color Emoji Regular"]
        , bgColor = black myColorScheme
        , fgColor = cyan myColorScheme
        , position = Top
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
        , template = "%XMonadLog% }{ %locks% %multicpu% %multicoretemp% %memory% %eno1% %gpu% %upgradeable% %speakers% %headphones% %uptime% %date%│%spock%"
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
    , Run upgradeable
    , Run gpu
    , Run speakers
    , Run headphones
    , Run XMonadLog
    , Run spock
    ]

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
