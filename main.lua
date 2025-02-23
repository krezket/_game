_G.love = require("love")

function love.load()
    _G.anim8 = require 'libraries/anim8'

    -- fit the screen --
    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    love.window.setMode(screenWidth, screenHeight, {fullscreen = false, resizable = true})

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.graphics.setBackgroundColor(1, 1, 1)

    _G.guy = {}
    guy.x = screenWidth / 2
    guy.y = 300
    guy.speed = 3
    guy.spriteSheet = love.graphics.newImage("sprites/new-player-sheet.png")
    guy.grid = anim8.newGrid(12, 18, guy.spriteSheet:getWidth(), guy.spriteSheet:getHeight())
    guy.animations = {}
    guy.animations.down = anim8.newAnimation( guy.grid('1-4', 1), 0.2 )
    guy.animations.left = anim8.newAnimation( guy.grid('1-4', 2), 0.2 )
    guy.animations.right = anim8.newAnimation( guy.grid('1-4', 3), 0.2 )
    guy.animations.up = anim8.newAnimation( guy.grid('1-4', 4), 0.2 )

    guy.anim = guy.animations.down

    _G.circle = {}
    circle.x = screenWidth / 2
    circle.y = screenHeight * 2.2
    circle.radius = screenWidth
    circle.angle = 0 -- Initial angle
    circle.speed = 0.3 -- Rotation speed

    _G.numLines = 8
end

function love.update(dt)
    local isMoving = false

    -- Rotate left
    if love.keyboard.isDown("left") then
        circle.angle = circle.angle + circle.speed * dt
    end

    -- Rotate right
    if love.keyboard.isDown("right") then
        circle.angle = circle.angle - circle.speed * dt
    end

    if love.keyboard.isDown("right") then
        guy.x = guy.x + guy.speed
        guy.anim = guy.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        guy.x = guy.x - guy.speed
        guy.anim = guy.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        guy.y = guy.y + guy.speed
        guy.anim = guy.animations.down
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        guy.y = guy.y - guy.speed
        guy.anim = guy.animations.up
        isMoving = true
    end

    if isMoving == false then
        guy.anim:gotoFrame(2)
    end

    guy.anim:update(dt)
end

function love.draw()
    guy.anim:draw(guy.spriteSheet, guy.x, guy.y, nil, 5)
    love.graphics.print("x: " .. guy.x, 0, 0)
    love.graphics.print("y: " .. guy.y, 0, 15)

    love.graphics.push() -- Save transformation state
    love.graphics.translate(circle.x, circle.y) -- Move to circle center
    love.graphics.rotate(circle.angle) -- Rotate around center

    love.graphics.setColor(0, 0, 0) -- White color
    love.graphics.circle("line", 0, 0, circle.radius) -- Draw circle at origin

    love.graphics.setColor(1, 0, 0) -- Red color
    for i = 1, numLines do
        local angle = (i / numLines) * (2 * math.pi)
        local x = math.cos(angle) * circle.radius
        local y = math.sin(angle) * circle.radius
        love.graphics.line(0, 0, x, y)
    end

    love.graphics.pop() -- Restore transformation state
end
