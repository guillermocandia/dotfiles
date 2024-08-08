module Customs (spock, deb) where
import Customs.ShowText (ShowText (..))
import Customs.DebianUpdates(DebianUpdates(..))


spock :: ShowText
spock = ShowText "<fn=1>\xf259</fn>" "spock"

deb :: DebianUpdates
deb = DebianUpdates (10 * 60 * 10)
