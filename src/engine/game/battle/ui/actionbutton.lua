local ActionButton, super = Class(Object)

function ActionButton:init(type, x, y, battler, actbox)
    super:init(self, x, y)

    self.type = type
    self.battler = battler
    self.actbox = actbox

    self.texture = Assets.getTexture("ui/battle/btn/"..type)
    self.hovered_texture = Assets.getTexture("ui/battle/btn/"..type.."_h")
    self.special_texture = Assets.getTexture("ui/battle/btn/"..type.."_a")

    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()

    self:setOriginExact(self.width/2, 13)

    self.hovered = false
    self.selectable = true
end

function ActionButton:select()
    if self.type == "fight" then
        Game.battle:setState("ENEMYSELECT", "ATTACK")
    elseif self.type == "act" then
        Game.battle:setState("ENEMYSELECT", "ACT")
    elseif self.type == "magic" then
        Game.battle.menu_items = {}

        -- First, register X-Actions as menu items.

        if Game.battle.encounter.default_xactions then
            local item = {
                ["name"] = self.battler.chara.xact_name or "X-Action",
                ["tp"] = 0,
                ["color"] = self.battler.chara.xact_color or self.battler.chara.color,
                ["data"] = {
                    ["name"] = Game.battle.enemies[Game.battle.selected_enemy]:getXAction(self.battler),
                    ["target"] = "xact",
                    ["id"] = 0,
                    ["default"] = true,
                    ["party"] = {},
                    ["tp"] = 0
                }
            }
            table.insert(Game.battle.menu_items, item)
        end

        for id, action in ipairs(Game.battle.xactions) do
            if action.party == self.battler.chara.id then
                local item = {
                    ["name"] = action.name,
                    ["tp"] = action.tp or 0,
                    ["description"] = action.description,
                    ["color"] = action.color or {1, 1, 1, 1},
                    ["data"] = {
                        ["name"] = action.name,
                        ["target"] = "xact",
                        ["id"] = id,
                        ["default"] = false,
                        ["party"] = {},
                        ["tp"] = action.tp or 0
                    }
                }
                table.insert(Game.battle.menu_items, item)
            end
        end

        -- Now, register SPELLs as menu items.
        for _,spell_id in ipairs(self.battler.chara.spells) do
            local spell = Registry.getSpell(spell_id)
            local color = spell.color or {1, 1, 1, 1}
            if spell.pacify then
                local has_tired = false
                for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                    if enemy.tired then
                        has_tired = true
                        break
                    end
                end
                if has_tired then
                    color = {0, 178/255, 1, 1}
                end
            end
            local item = {
                ["name"] = spell.name,
                ["tp"] = spell.cost,
                ["description"] = spell.effect,
                ["party"] = spell.party,
                ["color"] = color,
                ["data"] = spell
            }
            table.insert(Game.battle.menu_items, item)
        end

        Game.battle:setState("MENUSELECT", "SPELL")
    elseif self.type == "item" then
        Game.battle.menu_items = {}
        for i,item in ipairs(Game.inventory:getStorage("item")) do
            local menu_item = {
                ["name"] = item.name,
                ["unusable"] = item.usable_in ~= "all" and item.usable_in ~= "battle",
                ["description"] = item.effect,
                ["data"] = {index = i, item = item}
            }
            table.insert(Game.battle.menu_items, menu_item)
        end
        if #Game.battle.menu_items > 0 then
            Game.battle:setState("MENUSELECT", "ITEM")
        end
    elseif self.type == "spare" then
        Game.battle:setState("ENEMYSELECT", "SPARE")
    elseif self.type == "defend" then
        Game.battle:commitAction("DEFEND", nil, {tp = -16})
    end
end

function ActionButton:unselect()
    -- Do nothing ?
end

function ActionButton:hasSpecial()
    if self.type == "magic" then
        if self.battler then
            local has_tired = false
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.tired then
                    has_tired = true
                    break
                end
            end
            if has_tired then
                local has_pacify = false
                for _,spell_id in ipairs(self.battler.chara.spells) do
                    local spell = Registry.getSpell(spell_id)
                    if spell and spell.pacify then
                        has_pacify = true
                        break
                    end
                end
                return has_pacify
            end
        end
    elseif self.type == "spare" then
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.mercy >= 100 then
                return true
            end
        end
    end
    return false
end

function ActionButton:draw()
    if self.selectable and self.hovered then
        love.graphics.draw(self.hovered_texture or self.texture)
    else
        love.graphics.draw(self.texture)
        if self.selectable and self.special_texture and self:hasSpecial() then
            local r,g,b,a = self:getDrawColor()
            love.graphics.setColor(r,g,b,a * (0.4 + math.sin((love.timer.getTime() * 30) / 6) * 0.4))
            love.graphics.draw(self.special_texture)
        end
    end

    super:draw(self)
end

return ActionButton