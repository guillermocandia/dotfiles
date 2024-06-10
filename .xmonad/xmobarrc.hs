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
                      , Run Network "eno1" [  "--template", "<fn=1>⬇</fn><fc=cyan><rx></fc><fn=1>⬆</fn><fc=cyan><tx></fc>"
                                            , "--suffix", "True"
                                            , "--width", "7"] 20
                      , Run Com "/home/zink/.xmonad/scripts/get-gpu.sh" [] "gpu" 10
                      , Run Com "/home/zink/.xmonad/scripts/get-upgradeable.sh" [] "upgradeable" 100
                      , Run Com "/home/zink/.xmonad/scripts/get-volume.sh" ["speakers"] "speakers" 10
                      , Run Com "/home/zink/.xmonad/scripts/get-volume.sh" ["headphones"] "headphones" 10
                      , Run Uptime    [ "--template", "<fn=1>😄</fn><fc=cyan><days></fc>d<fc=cyan><hours></fc>h<fc=cyan><minutes></fc>m<fc=cyan><seconds></fc>s"
                                      , "--suffix", "False"
                                      , "--minwidth", "2"] 10
                      , Run Date "<fn=1>⌛</fn><fc=cyan>%X %d-%m-%Y</fc>" "date" 10
                      , Run XMonadLog
                    ]
         , sepChar = "%"
         , alignSep = "}{"
         , template = "%XMonadLog% }{ %locks% %disku% %multicpu% %coretemp% %memory% %eno1% %gpu% %upgradeable% %speakers% %headphones% %uptime% %date% <fn=1>🖖</fn>"
         }
