local Class = require("hump.class")

local Networking = require("classes.networking")

local Client = Class {}

function Client:init(networking, deck)
    self.networking = networking
    self.deck = deck

    self.players = {}
end

function Client:addPlayer(player)
    table.insert(self.players, player)
end

function Client:receiveHand(player, cards)
    player:clearHand()

    for i, id in pairs(cards) do
        local card = self.deck:get(id)
        
        player:addCard(card)

        print(i, card.program, card.priority)
    end

    -- test
    local card = player.hand[1]
    self.players[1]:setRegister(1, card)
    self.players[1]:clearRegister(1)
end

function Client:setRegister(player, id, card)
    local message = {
        command = Networking.ClientCommands.SetRegister,
        value = {
            registerId = id,
            programCardId = card.id,
        },
    }

    self.networking:send(message)
end

function Client:clearRegister(player, id)
    local message = {
        command = Networking.ClientCommands.ClearRegister,
        value = {
            registerId = id,
        },
    }

    self.networking:send(message)
end

function Client:serverMessage(message)
    print('Server: ' .. message)
end

return Client
