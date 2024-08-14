module Customs (spock, deb, speakers, headphones) where

import ColorScheme (ColorScheme (green, red), myColorScheme)
import Customs.DebianUpdates (DebianUpdates (..))
import Customs.ShowText (ShowText (..))
import Customs.Volume (Volume (..))

spock :: ShowText
spock = ShowText "<fn=1>\xf259</fn>" "spock"

deb :: DebianUpdates
deb = DebianUpdates "<fn=1>\xf058</fn> " "<fn=1>\xf0028</fn> " (green myColorScheme) (red myColorScheme) (10 * 60 * 10)

speakers :: Volume
speakers = Volume "speakers" "<fn=1>\xf04c3</fn> " "<fn=1>\xf04c4</fn> " (green myColorScheme) (red myColorScheme)

headphones :: Volume
headphones = Volume "headphones" "<fn=1>\xf02cb</fn> " "<fn=1>\xf07ce</fn> " (green myColorScheme) (red myColorScheme)
