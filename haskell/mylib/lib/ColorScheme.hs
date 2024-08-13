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
