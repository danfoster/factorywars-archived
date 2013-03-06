local Gamestate = require("hump.gamestate")
local Game = require("classes.game")

local LobbyState = {}

function LobbyState:init()

    loveframes.basicfont = fontDicks
    local serverLabel = loveframes.Create("text")
    serverLabel:SetText({{255, 255, 255, 255}, "Enter server IP"})
    serverLabel:CenterX()
    serverLabel:SetY(love.graphics.getHeight() / 3, true)
    
    self.editing = 1
    self.strings = {"", ""}
    self.naivetimer = 0
end

function LobbyState:draw()
    love.graphics.setFont(fontTitle)
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf("Factory Wars",0, 10, love.graphics.getWidth(),'center')
    
    self.naivetimer = self.naivetimer + 1
    local printStrings = {self.strings[1], self.strings[2]}
    local caret = ''
    if self.naivetimer < 200 then
        caret = '|'
    elseif self.naivetimer == 400 then
        self.naivetimer = 0
    end
    printStrings[self.editing] = printStrings[self.editing] .. caret
    
    love.graphics.setFont(fontDicks)
    love.graphics.printf(printStrings[1], 0, 200, love.graphics.getWidth(), 'center')
    
    love.graphics.printf("Enter your nickname", 0, 300, love.graphics.getWidth(), 'center')
    love.graphics.printf(printStrings[2], 0, 360, love.graphics.getWidth(), 'center')
end

function LobbyState:enter()
    self.editing = 1
end

function LobbyState:leave()
end

function LobbyState:keypressed(key, unicode)
    if unicode >= 32 and unicode <= 126 then
        self.strings[self.editing] = self.strings[self.editing] .. string.char(unicode)
    elseif key == "backspace" then
        self.strings[self.editing] = self.strings[self.editing]:sub(1, #self.strings[self.editing] - 1)
    elseif key == "return" then
        if self.editing == 1 then
            self.editing = 2
        else
            Gamestate.switch(PlayState)
            PlayState.game = Game(self.strings[1], nil, self.strings[2])
        end
    end
end

return LobbyState
