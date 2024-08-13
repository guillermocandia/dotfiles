{-# LANGUAGE GADTs #-}

module Customs.DebianUpdates (DebianUpdates (..)) where

import System.Exit (ExitCode (ExitFailure, ExitSuccess))
import System.Process (readProcessWithExitCode)
import Xmobar (Exec (alias, rate, run), Rate)

data DebianUpdates where
    DebianUpdates :: String -> String -> String -> String -> Rate -> DebianUpdates
    deriving (Read, Show)

instance Exec DebianUpdates where
    alias (DebianUpdates {}) = "deb"
    rate (DebianUpdates _ _ _ _ r) = r
    run (DebianUpdates iconOk iconPending colorOk colorPending _) = do
        (exit, stdout, stderr) <- readProcessWithExitCode "checkupdates" [] ""
        let (icon, color) = case stdout of
                "0" -> (iconOk, colorOk)
                _ -> (iconPending, colorPending)
        let tag = "<fc=" ++ color ++ ">"
        let endtag = "</fc>"
        return $ case exit of
            ExitFailure 1 -> stderr
            ExitSuccess -> icon ++ tag ++ stdout ++ endtag
            _ -> ""
