_G.love = require("love")
Push = require("libraries.push")

function love.load()
    _G.anim8 = require 'libraries/anim8'

    -- SCREEN --
    love.graphics.setBackgroundColor(1, 1, 1)
    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    love.window.setMode(screenWidth, screenHeight)
    local cowCenterX = screenWidth / 2
    local cowCenterY = screenHeight / 2
    -- -- -- --

    -- SCALE COW --
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- -- -- --

    -- COW TABLE --
    _G.cow = {}
    cow.x = cowCenterX
    cow.y = cowCenterY
    cow.speed = 5
    cow.spriteSheet = love.graphics.newImage("sprites/cow.png")
    cow.grid = anim8.newGrid(640, 1136, cow.spriteSheet:getWidth(), cow.spriteSheet:getHeight())
    cow.animations = {}
    cow.animations.down = anim8.newAnimation( cow.grid('1-7', 1), 0.1 )
    cow.animations.up = anim8.newAnimation( cow.grid('1-7', 1), 0.1 )
    cow.animations.left = anim8.newAnimation( cow.grid('1-7', 1), 0.1 )
    cow.animations.right = anim8.newAnimation( cow.grid('1-7', 1), 0.1 )
    cow.anim = cow.animations.down
    -- -- -- --
end

function love.update(dt)
    local isMoving = false

    -- SPRINT --
    if love.keyboard.isDown("lshift") then
        cow.speed = 10
    else
        cow.speed = 3
    end

    -- MOVEMENT --
    if love.keyboard.isDown("right") then
        cow.x = cow.x + cow.speed
        cow.anim = cow.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        cow.x = cow.x - cow.speed
        cow.anim = cow.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        cow.y = cow.y + cow.speed
        cow.anim = cow.animations.down
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        cow.y = cow.y - cow.speed
        cow.anim = cow.animations.up
        isMoving = true
    end

    -- STOP ANIMATION --
    if isMoving == false then
        cow.anim:gotoFrame(2)
    end

    cow.anim:update(dt)
end

function love.draw()
    love.graphics.scale(scale, scale)
    -- DRAW COW --
    cow.anim:draw(cow.spriteSheet, cow.x, cow.y, nil, 0.2, 0.2)

    love.graphics.print("x: " .. cow.x, 0, 0)
    love.graphics.print("y: " .. cow.y, 0, 15)
end
