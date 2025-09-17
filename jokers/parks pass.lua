-- Public Land / Parks Pass
SMODS.Joker {
    key = "bccp_parks_pass",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    rarity = 1, -- Common
    cost = 5,
    pos = { x = 4, y = 1 },

    config = { extra = { mult_per_unused = 1, mult = 0 } },

    loc_txt = {
        name = "Parks Pass",
        text = {
            "This joker gains {C:mult}+1{} Mult",
            "for every unused", 
            "discard this {C:attention}run{}",
            "{C:inactive}(Currently: {C:mult}+#2#{}{C:inactive}){}"
        }
    },

    loc_vars = function(self, info_queue, card)
        local unused = G.GAME.unused_discards or 0
        local mult = card.ability.extra.mult_per_unused * unused
        mult = mult + G.GAME.current_round.discards_left
        return { vars = { card.ability.extra.mult_per_unused, mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local unused = G.GAME.unused_discards or 0
            card.ability.extra.mult = card.ability.extra.mult_per_unused * unused
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.current_round.discards_left
            return { mult = card.ability.extra.mult }
        end
    end
}
