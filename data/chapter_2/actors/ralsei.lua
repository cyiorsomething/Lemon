return {
    name = "Ralsei",
    id = "ralsei",

    width = 19,
    height = 40,

    hitbox = {0, 27, 19, 14},

    color = {0, 1, 0},

    path = "party/ralsei/dark",
    default = "walk",

    text_sound = "ralsei",
    portrait_path = "face/ralsei",
    portrait_offset = {-15, -10},

    animations = {
        -- Movement animations
        ["slide"]               = {"slide", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spell", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"walk/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},

        -- Cutscene animations
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},

        ["laugh"]               = {"laugh", 4/30, true},

        ["hug"]                 = {"hug", 2/9, false},
        ["hug_stop"]            = {"hug_stop", 2/9, false},

        ["wave_start"]          = {"wave_start", 5/30, false, next="wave_down"},
        ["wave_down"]           = {"wave_down", 5/30, true}
    },

    offsets = {
        -- Movement offsets
        ["walk/down"] = {1, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {1, 0},

        ["walk_blush/down"] = {1, 0},
        ["walk_blush/left"] = {0, 0},
        ["walk_blush/right"] = {0, 0},
        ["walk_blush/up"] = {1, 0},

        ["slide"] = {2, -2},

        -- Battle offsets
        ["battle/idle"] = {2, 6},

        ["battle/attack"] = {10, 6},
        ["battle/attackready"] = {10, 6},
        ["battle/act"] = {2, 6},
        ["battle/actend"] = {2, 6},
        ["battle/actready"] = {2, 6},
        ["battle/spell"] = {11, 6},
        ["battle/spellready"] = {11, 6},
        ["battle/item"] = {7, 14},
        ["battle/itemready"] = {7, 14},
        ["battle/defend"] = {2, 6},

        ["battle/defeat"] = {2, 6},
        ["battle/hurt"] = {13, 2},

        ["battle/intro"] = {2, 6},
        ["battle/victory"] = {0, 6},

        -- Cutscene offsets
        ["pose"] = {1, 1},

        ["fall"] = {10, 0},
        ["ball"] = {0, -9},
        ["landed"] = {1, 0},

        ["hug"] = {0, 0},
        ["hug_stop"] = {0, 0},

        ["laugh"] = {2, 0},

        ["shocked_behind"] = {9, -3},
        ["surprised_down"] = {5, 1},

        ["wave_start"] = {1, 0},
        ["wave_down"] = {-1, -1},

        ["splat"] = {15, -21},
        ["stool"] = {11, -18}
    },
}