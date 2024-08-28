{-# LANGUAGE GADTs #-}

module Customs.HeadphonesBattery (HeadphonesBattery (..)) where

import Data.List.Split (splitOn)
import System.Exit (ExitCode (ExitFailure, ExitSuccess))
import System.Process (readProcessWithExitCode)
import Xmobar (Exec (alias, rate, run), Rate)

data HeadphonesBattery where
    HeadphonesBattery :: (String, String, String, String) -> (String, String, String, String) -> Rate -> HeadphonesBattery
    deriving (Read, Show)

instance Exec HeadphonesBattery where
    alias (HeadphonesBattery {}) = "headphonesBattery"
    rate (HeadphonesBattery _ _ r) = r
    run (HeadphonesBattery icons colors _) = do
        (exit, stdout, stderr) <- readProcessWithExitCode "get-headphones-battery" [] ""
        return $ case exit of
            ExitFailure 1 -> stderr
            ExitSuccess -> formatted stdout
            _ -> ""
        where
            formatted stdout = format stdout icons colors

format :: String -> (String, String, String, String) -> (String, String, String, String) -> String
format s (iconOff, iconLow, iconMedium, iconHigh) (colorOff, colorLow, colorMedium, colorHigh) = r
    where
        r = icon ++ tag ++ volume ++ endtag
        tag = "<fc=" ++ color ++ ">"
        volume = l !! 1
        endtag = "</fc>"
        l = splitOn " " s
        status = head l
        (color, icon) = case status of
            "0" -> (colorOff, iconOff)
            "1" -> (colorVolume, iconVolume)
            [] -> ("", "")
            _ -> ("", "error")
        (iconVolume, colorVolume) = case read volume :: Integer of
            var
                | var <= 20 -> (iconLow, colorLow)
                | var <= 80 -> (iconMedium, colorMedium)
                | otherwise -> (iconHigh, colorHigh)
