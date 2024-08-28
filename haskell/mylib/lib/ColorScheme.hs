{-# LANGUAGE GADTs #-}

module ColorScheme (ColorScheme (..), myColorScheme) where

data ColorScheme where
    ColorScheme
        :: { black
             , red
             , green
             , yellow
             , blue
             , magenta
             , cyan
             , white
                :: String
           }
        -> ColorScheme

myColorScheme :: ColorScheme
myColorScheme = _oxocarbon

_nord :: ColorScheme
_nord =
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

_night :: ColorScheme
_night =
    ColorScheme
        { black = "#393b44"
        , red = "#c94f6d"
        , green = "#81b29a"
        , yellow = "#dbc074"
        , blue = "#719cd6"
        , magenta = "#9d79d6"
        , cyan = "#63cdcf"
        , white = "#dfdfe0"
        }

_carbon :: ColorScheme
_carbon =
    ColorScheme
        { black = "#282828"
        , red = "#ee5396"
        , green = "#25be6a"
        , yellow = "#08bdba"
        , blue = "#78a9ff"
        , magenta = "#be95ff"
        , cyan = "#33b1ff"
        , white = "#dfdfe0"
        }

_oxocarbon :: ColorScheme
_oxocarbon =
    ColorScheme
        { black = "#262626"
        , magenta = "#ff7eb6"
        , green = "#42be65"
        , yellow = "#ffe97b"
        , blue = "#33b1ff"
        , red = "#ee5396"
        , cyan = "#3ddbd9"
        , white = "#dde1e6"
        }

_xterm :: ColorScheme
_xterm =
    ColorScheme
        { black = "#000000"
        , red = "#cd0000"
        , green = "#00cd00"
        , yellow = "#cdcd00"
        , blue = "#0000ee"
        , magenta = "#cd00cd"
        , cyan = "#00cdcd"
        , white = "#e5e5e5"
        }
