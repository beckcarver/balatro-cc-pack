-- Triangle Joker
SMODS.Joker {
    key = "bccp_triangle",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    
    rarity = 3, -- Rare
    cost = 6,
    pos = { x = 3, y = 5 },

    config = { extra = { mult_gain = 3, total_mult = 0, last_discard = -1, gained_this_discard = false } },

    loc_txt = {
        name = "Triangle Joker",
        text = {
            "When discarding exactly {C:attention}3{}",
            "cards gain {C:mult}+#1#{} Mult",
            "{C:inactive}(Currently: {C:mult}+#2#{}{C:inactive}){}"
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.total_mult } }
    end,

    calculate = function(self, card, context)
        -- Reset per new discard action
        if G.GAME.current_round.discards_used ~= card.ability.extra.last_discard then
            card.ability.extra.gained_this_discard = false
            card.ability.extra.last_discard = G.GAME.current_round.discards_used
        end

        if context.discard and not context.blueprint and #context.full_hand == 3 and not card.ability.extra.gained_this_discard then
            card.ability.extra.total_mult = card.ability.extra.total_mult + card.ability.extra.mult_gain
            card.ability.extra.gained_this_discard = true
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return { mult = card.ability.extra.total_mult }
        end
    end
}
