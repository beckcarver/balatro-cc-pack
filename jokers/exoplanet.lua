-- Exoplanet
SMODS.Joker {
    key = "exoplanet",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    rarity = 2, -- Uncommon
    cost = 6,
    pos = { x = 0, y = 0 },

    config = { extra = { xmult = 3, poker_hand = 'High Card' } },

    loc_txt = {
        name = "Exoplanet",
        text = {
            "Chooses a random {C:attention}poker hand{} each round.",
            "When that hand is played gives {X:mult,C:white} X#1# {}",
            "{C:inactive}(Currently: {C:attention}#2#{C:inactive})"
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        -- Apply X multiplier when the chosen hand is scored
        if context.joker_main and context.scoring_name == card.ability.extra.poker_hand then
            return {
                xmult = card.ability.extra.xmult,
                --message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                --colour = G.C.MULT
            }
        end

        -- Pick a new random hand at end of round
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            if #_poker_hands > 0 then
                card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'exoplanet')
                return {
                    message = localize('k_reset'),
                    colour = G.C.PURPLE
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        if #_poker_hands > 0 then
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'exoplanet')
        end
    end
}
