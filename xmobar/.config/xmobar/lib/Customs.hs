module Customs (spock, deb, speakers, headphones) where

import Customs.DebianUpdates (DebianUpdates (..))
import Customs.ShowText (ShowText (..))
import Customs.Volume (Volume(..))

spock :: ShowText
spock = ShowText "<fn=1>\xf259</fn>" "spock"

deb :: DebianUpdates
deb = DebianUpdates (10 * 60 * 10)

speakers :: Volume
speakers = Volume "speakers" "a" "a" "a" "a"

headphones :: Volume
headphones = Volume "headphones" "a" "a" "a" "a"
