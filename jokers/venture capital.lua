SMODS.Joker{
    name = "Venture Capital",
    key = "bvpp_venture_capital",
    config = {
        extra = {
            payout = 12,
            penalty = 1,
            odds = 5  -- 1 in 5 chance
        }
    },
    loc_txt = {
        ['name'] = 'Venture Capital',
        ['text'] = {
            [1] = '{C:green}1/2{} chance to give {C:money}$#1#{} at end of round,',
            [2] = 'otherwise lose {C:money}$#2#{}'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout, card.ability.extra.penalty}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if pseudorandom('venture_capital'..tostring(card)) < 1 / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('k_earned_ex'),
                            colour = G.C.MONEY,
                            card = card
                        })
                        return true
                    end
                }))
                ease_dollars(card.ability.extra.payout)
                card:juice_up(0.5, 0.5)
                delay(0.5)
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "-$"..tostring(card.ability.extra.penalty),
                            colour = G.C.MONEY,
                            card = card
                        })
                        return true
                    end
                }))
                ease_dollars(-card.ability.extra.penalty)
                card:juice_up(0.5, 0.5)
                delay(0.5)
            end
        end
    end
}
