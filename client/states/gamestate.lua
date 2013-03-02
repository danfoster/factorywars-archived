function GameState:init()
end


function GameState:enter()
end

function GameState:draw()
    self.game:draw()
end

function GameState:update(dt)
    if self.game.updatingView then
        self.game.cam.x = self.game.cam.x - (love.mouse.getX() - self.game.oldMouseX)/self.game.cam.scale 
        self.game.cam.y = self.game.cam.y - (love.mouse.getY() - self.game.oldMouseY)/self.game.cam.scale
        self.game.oldMouseX = love.mouse.getX()
        self.game.oldMouseY = love.mouse.getY()
    end
end


function GameState:mousepressed(x,y,button)
    if button == 'r' then
        self.game.updatingView = true
        self.game.oldMouseX = x
        self.game.oldMouseY = y
    elseif button == 'wd' then
        self.game.cam.scale = math.max(self.game.cam.scale / 1.2, 0.1)
    elseif button == 'wu' then
        self.game.cam.scale = math.min(self.game.cam.scale * 1.1, 5)
    end
end

function GameState:mousereleased(x,y,button)
    if button == 'r' then
        self.game.updatingView = false
    end
end

function GameState:keypressed(key)
    local x = self.game.robot.x
    local y = self.game.robot.y
    local o = self.game.robot.orient
    if key == "w" then
        x,y = self.game.robot:move(1)
    elseif key == "a" then
        x,y = self.game.robot:move(0, -1)
    elseif key == "s" then
        o = self.game.robot:rotate(2)
    elseif key == "d" then
        x,y = self.game.robot:move(0, 1)
    elseif key == "q" then
        o = self.game.robot:rotate(-1)
    elseif key == "e" then
        o = self.game.robot:rotate(1)
    elseif key == "i" then
        self.game:executeCard(self.game.fCard, self.game.robot)
        x = self.game.robot.x
        y = self.game.robot.y
    end
    self.game.robot.x = x
    self.game.robot.y = y
    self.game.robot.orient = o
end


