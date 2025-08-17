-- Public Land / Parks Pass
SMODS.Joker {
    key = "parks_pass",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    rarity = 2, -- Uncommon
    cost = 6,
    pos = { x = 0, y = 0 },

    config = { extra = { mult_per_unused = 1, total_mult = 0 } },

    loc_txt = {
        name = "Parks Pass",
        text = {
            "Gain {C:mult}+1{} for every unused discard",
            "current total: {C:mult}#2#{} mult"
        }
    },

    loc_vars = function(self, info_queue, card)
        local unused = G.GAME.unused_discards or 0
        local total_mult = card.ability.extra.mult_per_unused * unused
        return { vars = { card.ability.extra.mult_per_unused, total_mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local unused = G.GAME.unused_discards or 0
            card.ability.extra.total_mult = card.ability.extra.mult_per_unused * unused
            return { mult = card.ability.extra.total_mult }
        end
    end
}
