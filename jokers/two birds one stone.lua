SMODS.Joker {
    key = "two_birds_one_stone",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2, -- Uncommon
    cost = 5,
    pos = { x = 5, y = 2 },
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    config = { extra = { pair_triggered = false } },
    loc_txt = {
        name = "Two Birds One Stone",
        text = {
            "First {C:attention}Pair{} containing a {C:tarot}Stone{}",
            "card played per round",
            "gives {C:mult}2x Mult{} and {C:tarot}1 Tarot card{}."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- Reset trigger at start of round
        if context.end_of_round and context.individual then
            card.ability.extra.pair_triggered = false
        end

        -- Only trigger once per round and only on main eval
        if context.joker_main and (next(context.poker_hands['Pair'])) and not card.ability.extra.pair_triggered then
            -- Find all Pairs in this hand
            local found_stone = false
            if context.full_hand then
                for _, c in ipairs(context.full_hand) do
                    if c.ability and c.ability.name == "Stone Card" then
                        found_stone = true
                        break
                    end
                end
            end
            if found_stone then
                card.ability.extra.pair_triggered = true
                return {
                    xmult = 2,
                    extra = {
                        message = localize('k_plus_tarot'),
                        message_card = card,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Tarot',
                                        key_append = 'vpp_two_birds_one_stone' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end
}