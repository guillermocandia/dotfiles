module Monitors (multiCpu, memory, multiCoreTemp, date, locks, eno1, uptime, disku, gpu, diskio, top) where

import Xmobar (Command (Com), Date (Date), Locks (Locks'), Monitors (DiskIO, DiskU, Memory, MultiCoreTemp, MultiCpu, Network, TopProc, Uptime))

-- cpu and memory
multiCpu :: Monitors
multiCpu =
    MultiCpu
        [ "-t"
        , "<fn=1>\xf4bc</fn> <autototal>"
        , "--ppad"
        , "2"
        , "--padchars"
        , "0"
        , "--High"
        , "80"
        -- , "--low"
        -- , "lightcyan"
        -- , "--normal"
        -- , "cyan"
        -- , "--high"
        -- , "red"
        ]
        10

multiCoreTemp :: Monitors
multiCoreTemp =
    MultiCoreTemp
        [ "--template"
        , "<fn=1>\xf2c9</fn> <avg><fn=1>\xf0504</fn>"
        , "--Low"
        , "40"
        , "--High"
        , "80"
        -- , "--low"
        -- , "lightcyan"
        -- , "--normal"
        -- , "cyan"
        -- , "--high"
        -- , "red"
        ]
        10

memory :: Monitors
memory =
    Memory
        [ "--template"
        , "<fn=1>\xefc5</fn> <usedratio>%"
        , "--Low"
        , "20"
        , "--High"
        , "80"
        -- , "--low"
        -- , "lightcyan"
        -- , "--normal"
        -- , "cyan"
        -- , "--high"
        -- , "red",
        ]
        (10 * 2)

-- date
date :: Date
date = Date "<fn=1>\xf0954</fn> %X <fn=1>\xf073</fn> %d-%m-%Y" "date" 10

-- disk use
disku :: Monitors
disku =
    DiskU
        [ ("/", "<fn=1>\xf02ca</fn> /:<free>/<size>")
        , ("/home", "/home:<free>/<size>")
        ]
        []
        (10 * 10)

-- disk io
diskio :: Monitors
diskio =
    DiskIO
        [ ("/", "<fn=1>\xf02ca</fn> /:<read>/<write>")
        , ("/home", "/home:<read>/<write>")
        ]
        [ "--minwidth"
        , "4"
        , "--suffix"
        , "True"
        ]
        (10 * 2)

-- load
top :: Monitors
top =
    TopProc
        [ "--template"
        , "<fn=1>\xf05a1</fn> <both1> <mboth1>"
        , "--width"
        , "20"
        , "--suffix"
        , "True"
        ]
        (10 * 5)

-- locks
locks :: Locks
locks =
    Locks'
        [ ("CAPS", ("<fn=1>\xf100d</fn>", "<fn=1>\xf002c</fn>"))
        , ("NUM", ("<fn=1>\xf03a0</fn>", "<fn=1>\xf19d3</fn>"))
        , ("SCROLL", ("SlOCK", ""))
        ]

-- network
eno1 :: Monitors
eno1 =
    Network
        "eno1"
        [ "--template"
        , "<fn=1>\xf0c66</fn><rx> <fn=1>\xf0cd8</fn><tx>"
        , "--suffix"
        , "True"
        , "--width"
        , "7"
        ]
        (10 * 2)

-- others
uptime :: Monitors
uptime =
    Uptime
        [ "--template"
        , "<fn=1>\xf1ae0</fn> <days>:<hours>:<minutes>:<seconds>"
        , "--suffix"
        , "False"
        , "--minwidth"
        , "2"
        , "--padchars"
        , "0"
        ]
        10

-- customs
gpu :: Command
gpu = Com "/home/zink/.xmonad/scripts/get-gpu.sh" [] "gpu" 50
