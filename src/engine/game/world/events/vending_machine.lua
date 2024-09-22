--- A Vending Machine that sells items for money. \
--- `Vending_Machine` is an [`Interactable`](lua://Interactable.init) - naming an object `vending_machine` on an `objects` layer in a map creates this object. \
--- See this object's Fields for the configurable properties on this object.
---
---@class Vending_Machine : Interactable
---
---@field sprite    Sprite
---@field solid     boolean
---
---@field item      string      *[Property `item`]* The name of the item sold by this vending machine
---@field itemname  string      *[Property `itemname`]* The display name of the item
---@field price     number      *[Property `price`]* The cost of the item in currency
---@field text      string      *[Property `text`]* The text displayed when interacting with the vending machine
---
---@overload fun(...) : Vending_Machine
local Vending_Machine, super = Class(Interactable, "vending_machine")

function Vending_Machine:init(data)
    super.init(self, data.x, data.y, nil, nil, data.properties)

    local properties = data.properties or {}

    self.item = properties["item"] or "cd_bagel"
    self.itemname = properties["itemname"] or Registry.createItem(self.item):getName()
    self.price = properties["price"] or 120
    self.text = properties["text"] or "* (It's a machine that sells refreshments.)\n* (1 " .. self.itemname .. " is $" .. self.price .. ". Buy?)"

    self.solid = true

    self:setOrigin(0.5, 1)
    self:setSprite("world/events/vending_machine")
end

function Vending_Machine:onInteract(player, dir)
    local cutscene = self.world:startCutscene(function(c)
        c:showShop()
        c:text(self.text)
        c:choicer({"Yes", "No"})
        
        if c.choice == 1 then
            if Game.money < self.price then
                c:text("* (You didn't have enough money. Which[wait:1], is surprising.)")
            else
                local item = self.item
                if type(self.item) == "string" then
                    item = Registry.createItem(self.item)
                end
                local success, result_text = Game.inventory:tryGiveItem(item)
                if success then
                    Game.money = Game.money - self.price
                end
                c:text(result_text)
            end
        end
        
        c:hideShop()
    end)
    return true
end

return Vending_Machine
