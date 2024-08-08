{-# LANGUAGE GADTs #-}
module Customs.ShowText(ShowText(..)) where

import Xmobar (Exec (alias, run))

data ShowText where
  ShowText :: String -> String -> ShowText
  deriving (Read, Show)

instance Exec ShowText where
    alias (ShowText _ a) = a
    run (ShowText t _) = return t
