{-# LANGUAGE GADTs #-}

module Customs.Volume (Volume (..)) where

import Control.Monad (forever)
import System.IO (BufferMode (LineBuffering), hGetLine, hSetBuffering)
import System.Process (StdStream (CreatePipe), createProcess, readProcess, shell, std_out)
import Xmobar (Exec (start), alias)

data Volume where
    Volume :: String -> String -> String -> String -> String -> Volume
    deriving (Read, Show)

instance Exec Volume where
    alias (Volume device _ _ _ _) = device
    start (Volume device iconOff iconOn colorOff colorOn) cb = do
        print shellCommand
        (_, Just hout, _, _) <- createProcess (shell shellCommand) {std_out = CreatePipe}
        hSetBuffering hout LineBuffering

        forever $ do
            formatVolume (getVolume (hGetLine hout)) >>= cb
        where
            shellCommand = "pactl subscribe|grep --line-buffered \"sink #" ++ sink ++ "\""
            sink = case device of
                "headphones" -> "0"
                "speakers" -> "1"
                _ -> undefined
            getVolume :: IO String -> IO String
            getVolume hout = do
                _ <- hout
                readProcess "get-volume" [device] ""

formatVolume :: IO String -> IO String
formatVolume hout = do
    s <- hout
    let r = concat $ replicate 1 s
    return r
