-- Fast Fashion
SMODS.Joker {
    key = "fast_fashion",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    rarity = 2, -- Uncommon
    cost = 5,
    pos = { x = 0, y = 3 },

    loc_txt = {
        name = "Fast Fashion",
        text = {
            "{X:mult,C:white}3x{} mult, lose {C:money}3${}",
            "when a hand is played"
        }
    },

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 0 then
            
            -- Add negative dollars to the buffer
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 3

            -- Trigger money loss animation
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "-$3",
                        colour = G.C.MONEY,
                        card = card
                    })
                    -- Apply the buffered dollars to the game
                    ease_dollars(G.GAME.dollar_buffer)
                    G.GAME.dollar_buffer = 0
                    return true
                end
            }))

            return {
                xmult = 3,
            }
        end
    end,
}
