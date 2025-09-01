SMODS.Joker {
    key = 'bccp_venture_capital',
    loc_txt = {
        name = "Venture Capital",
        text = {
            "{C:green}#1# in #2# {} chance to gain {C:money}$#3#{}",
            "otherwise lose {C:red}$#4#{} at",
            "end of round"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 3, y = 3 }, -- adjust art slot if needed
    cost = 7,
    config = {
        extra = {
            odds = 2,       -- base denominator (1 in 4 chance)
            payout = 12,     -- $ on success
            penalty = 2     -- $ on failure
        }
    },

    loc_vars = function(self, info_queue, card)
        -- get scaled odds (respects Oops! All 6s and similar)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bccp_venture_capital')

        -- keep them stored so calc_dollar_bonus stays in sync
        card.ability.extra._numerator = n
        card.ability.extra._denominator = d

        return {
            vars = { n, d, card.ability.extra.payout, card.ability.extra.penalty }
        }
    end,

    calc_dollar_bonus = function(self, card)
        local n = card.ability.extra._numerator or 1
        local d = card.ability.extra._denominator or card.ability.extra.odds

        if SMODS.pseudorandom_probability(card, 'bccp_venture_capital', n, d) then
            return card.ability.extra.payout
        else
            return -card.ability.extra.penalty
        end
    end
}
