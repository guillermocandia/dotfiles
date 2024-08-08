{-# LANGUAGE GADTs #-}

module Customs.DebianUpdates (DebianUpdates (..)) where

import System.Exit (ExitCode (ExitFailure, ExitSuccess))
import System.Process (readProcessWithExitCode)
import Xmobar (Exec (alias, rate, run), Rate)

data DebianUpdates where
    DebianUpdates :: Rate -> DebianUpdates
    deriving (Read, Show)

instance Exec DebianUpdates where
    alias (DebianUpdates _) = "deb"
    rate (DebianUpdates r) = r
    run (DebianUpdates _) = do
        (exit, stdout, stderr) <- readProcessWithExitCode "checkupdates" [] ""
        return $ case exit of
            ExitFailure 1 -> stderr
            ExitSuccess -> stdout
            _ -> ""
