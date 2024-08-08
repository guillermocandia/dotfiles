module Custom (ShowText(..)) where

import Xmobar (Exec (alias, run))

data ShowText = ShowText String String
    deriving (Read, Show)

instance Exec ShowText where
    alias (ShowText _ a) = a
    run (ShowText t _) = return t
