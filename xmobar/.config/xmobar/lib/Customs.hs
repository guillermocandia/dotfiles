module Customs (spock, deb, speakers, headphones, headphonesBattery) where

import ColorScheme (ColorScheme (green, red, yellow), myColorScheme)
import Customs.DebianUpdates (DebianUpdates (..))
import Customs.HeadphonesBattery (HeadphonesBattery (..))
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

headphonesBattery :: HeadphonesBattery
headphonesBattery =
    HeadphonesBattery
        ("<fn=1>\xf125e</fn> ", "<fn=1>\xf12a1</fn> ", "<fn=1>\xf12a2</fn> ", "<fn=1>\xf12a3</fn> ")
        (red myColorScheme, red myColorScheme, yellow myColorScheme, green myColorScheme)
        (10 * 60)
