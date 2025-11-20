{-# LANGUAGE GADTs #-}

module Customs.Volume (Volume (..)) where

import Control.Monad (forever)
import Data.List.Split (splitOn)
import System.IO (BufferMode (LineBuffering), hGetLine, hSetBuffering)
import System.Process (StdStream (CreatePipe), createProcess, readProcess, shell, std_out)
import Xmobar (Exec (start), alias)

data Volume where
    Volume :: String -> String -> String -> String -> String -> Volume
    deriving (Read, Show)

instance Exec Volume where
    alias (Volume device _ _ _ _) = device
    start (Volume device iconOn iconOff colorOn colorOff) cb = do
        formatVolume (getVolume device) iconOn iconOff colorOn colorOff >>= cb
        (_, Just hout, _, _) <- createProcess (shell shellCommand) {std_out = CreatePipe}
        hSetBuffering hout LineBuffering

        forever $ do
            _ <- hGetLine hout
            formatVolume (getVolume device) iconOn iconOff colorOn colorOff >>= cb
        where
            shellCommand = "pactl subscribe|grep --line-buffered \"sink #" ++ sink ++ "\""
            sink = case device of
                "headphones" -> "0"
                "speakers" -> "1"
                _ -> undefined

getVolume :: String -> IO String
getVolume device = readProcess "get-volume" [device] ""

formatVolume :: IO String -> String -> String -> String -> String -> IO String
formatVolume io iconOn iconOff colorOn colorOff = do
    s <- io
    let l = splitOn " " s
    let volume = head l
    let mute = l !! 1
    let (icon, color) = case mute of
            "0" -> (iconOn, colorOn)
            "1" -> (iconOff, colorOff)
            [] -> ("", "")
            _ -> ("error", "error")
    let tag = "<fc=" ++ color ++ ">"
    let endtag = "</fc>"
    return $ icon ++ tag ++ volume ++ endtag
