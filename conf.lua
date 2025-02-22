_G.love = require("love")

function love.conf(t)
    t.identity = "data/saves"
    t.version = "11.0.0"

    t.window.icon = "icons/guy1.png"
    t.window.title = "Just a Guy"
    t.window.borderless= false
--    t.window.fullscreen= false
--    t.window.resizable = false
--    t.console = false
--    t.externalstorage = false
--    t.gammacorrect = false
--    t.audio.mic = false
end

