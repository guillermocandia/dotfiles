Config {
          overrideRedirect = False
        , font = "Dejavu Sans Mono Bold 8"
        , additionalFonts = ["Noto Color Emoji Regular"]
        , bgColor = "black"
        , fgColor = "darkgrey"
        , position = Top
        , border = NoBorder
        , lowerOnStart = False
        , commands = [  Run Locks
                      , Run DiskU    [ ("/", "<fn=1>🗄</fn>/:<free>"), ("/home", "/home:<free>")]
                                     [  "-L", "20", "-H", "50", "-m", "1", "-p", "3"] 50
                      , Run MultiCpu [  "--template", "<fn=1>🤖</fn> <autototal>"
                                      , "--ppad", "2"
                                      , "--padchars", "0"
                                      , "--Low", "40"
                                      , "--High", "80"
                                      , "--low", "lightcyan"
                                      , "--normal", "cyan"
                                      , "--high", "red"] 10
                      , Run CoreTemp [  "--template", "<fn=1>🌡</fn><core0>ºC"
                                      , "--Low", "40"
                                      , "--High", "80"
                                      , "--low", "lightcyan"
                                      , "--normal", "cyan"
                                      , "--high", "red"] 20
                      , Run Memory   [  "--template", "<fn=1>🐘</fn><usedratio>%"
                                      , "--Low", "20"
                                      , "--High", "80"
                                      , "--low", "lightcyan"
                                      , "--normal", "cyan"
                                      , "--high", "red"] 20
                      -- , Run Volume "default" "Master" ["--template", "<volume> <status>"] 10 TODO reemplazar con pulsemixer get, hacer un script perzoalizado y correr con COM
                      -- , Run Volume "sink-53" "PCM" ["--template", "<volume> <status>"] 10
                      , Run Network "eno1" [  "--template", "<fn=1>⬇</fn><fc=cyan><rx></fc><fn=1>⬆</fn><fc=cyan><tx></fc>"
                                            , "--suffix", "True"
                                            , "--width", "7"] 20
                      , Run Uptime    [ "--template", "<fn=1>😄</fn><fc=cyan><days></fc>d<fc=cyan><hours></fc>h<fc=cyan><minutes></fc>m<fc=cyan><seconds></fc>s"
                                      , "--suffix", "False"
                                      , "--minwidth", "2"] 10
                      , Run Date "<fn=1>⌛</fn><fc=cyan>%X %d-%m-%Y</fc>" "date" 10
                      , Run XMonadLog
                    ]
         , sepChar = "%"
         , alignSep = "}{"
         , template = "%XMonadLog% }{ %locks% %disku% %multicpu% %coretemp% %memory% %eno1% %uptime% %date% <fn=1>🖖</fn>"
         }
