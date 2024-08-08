module Monitors (multiCpu, memory, multiCoreTemp, date, locks, eno1, uptime, headphones, speakers, upgradeable, gpu, spock) where

import Xmobar (Command (Com), Date (Date), Locks (Locks'), Monitors (Memory, MultiCoreTemp, MultiCpu, Network, Uptime))
import Custom (ShowText (..))

-- cpu and memory
multiCpu :: Monitors
multiCpu =
    MultiCpu
        [ "-t"
        , "<autototal>"
        , "--ppad"
        , "2"
        , "--padchars"
        , "0"
        , "--Low"
        , "40"
        , "--High"
        , "80"
        , "--low"
        , "lightcyan"
        , "--normal"
        , "cyan"
        , "--high"
        , "red"
        ]
        50

multiCoreTemp :: Monitors
multiCoreTemp =
    MultiCoreTemp
        [ "--template"
        , "<avg>"
        , "--Low"
        , "40"
        , "--High"
        , "80"
        , "--low"
        , "lightcyan"
        , "--normal"
        , "cyan"
        , "--high"
        , "red"
        ]
        10

memory :: Monitors
memory =
    Memory
        [ "--template"
        , "<usedratio>%"
        , "--Low"
        , "20"
        , "--High"
        , "80"
        , "--low"
        , "lightcyan"
        , "--normal"
        , "cyan"
        , "--high"
        , "red"
        ]
        50

-- date
date :: Date
date = Date "%X %d-%m-%Y" "date" 10

-- disks
-- DiskU
--         [("/", "<fn=1>🗄</fn>/:<free>"), ("/home", "/home:<free>")]
--         ["-L", "20", "-H", "50", "-m", "1", "-p", "3"]
--         50

-- locks
locks :: Locks
locks =
    Locks'
        [ ("CAPS", ("<fc=#00ff00>\xf023</fc>", "<fc=#777777>\xf09c</fc>"))
        , ("NUM", ("<fc=#777777>\xf047</fc>", "<fc=#00ff00>\xf047</fc>"))
        , ("SCROLL", ("SlOCK", ""))
        ]

-- network
eno1 :: Monitors
eno1 =
    Network
        "eno1"
        [ "--template"
        , "<fn=1>⬇</fn><fc=cyan><rx></fc><fn=1>⬆</fn><fc=cyan><tx></fc>"
        , "--suffix"
        , "True"
        , "--width"
        , "7"
        ]
        20

-- others
uptime :: Monitors
uptime =
    Uptime
        [ "--template"
        , "<days>d<hours>h<minutes>m<seconds>s"
        , "--suffix"
        , "False"
        , "--minwidth"
        , "2"
        ]
        10

-- customs
gpu :: Command
gpu = Com "/home/zink/.xmonad/scripts/get-gpu.sh" [] "gpu" 50

upgradeable :: Command
upgradeable = Com "/home/zink/.xmonad/scripts/get-upgradeable.sh" [] "upgradeable" 600

speakers :: Command
speakers = Com "/home/zink/.xmonad/scripts/get-volume.sh" ["speakers"] "speakers" 20

headphones :: Command
headphones = Com "/home/zink/.xmonad/scripts/get-volume.sh" ["headphones"] "headphones" 20

spock :: ShowText
spock = ShowText "<fn=1>\xf259</fn>" "spock"
