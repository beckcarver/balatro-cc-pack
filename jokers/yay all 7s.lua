SMODS.Joker {
    key = 'yay_all_7s',
    loc_txt = {
        name = "Yay all 7's",
        text = {
            "{C:green}#1#/#2#{} chance to retrigger played",
            "{C:attention}7's{} (max #3# retriggers per card)"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 4, retriggers = 2 } },
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 5, y = 1 },
    cost = 8,

    loc_vars = function(self, info_queue, card)
        card.ability.extra._numerator, card.ability.extra._denominator =
            SMODS.get_probability_vars(card, 3, card.ability.extra.odds, 'yay_all_7s')
        return { vars = { card.ability.extra._numerator, card.ability.extra._denominator, card.ability.extra.retriggers } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            local other = context.other_card
            if other and other:get_id() == 7 and not context.blueprint then
                other.ability = other.ability or {}
                other.ability.extra = other.ability.extra or {}
                other.ability.extra._retriggered = other.ability.extra._retriggered or {}

                local retrigger_count = other.ability.extra._retriggered['yay_all_7s'] or 0
                local max_retriggers = card.ability.extra.retriggers
                local numerator = card.ability.extra._numerator or 3
                local denominator = card.ability.extra._denominator or 4

                local repetitions = 0
                -- Loop to determine how many times it retriggers this evaluation
                for i = retrigger_count + 1, max_retriggers do
                    if SMODS.pseudorandom_probability(card, 'yay_all_7s', numerator, denominator) then
                        repetitions = repetitions + 1
                    else
                        break
                    end
                end

                if repetitions > 0 then
                    other.ability.extra._retriggered['yay_all_7s'] = retrigger_count + repetitions
                    return {
                        message = "Lucky 7!",
                        repetitions = repetitions,
                        card = other
                    }
                end
            end
        end
    end
}


-- might be a bug when paired with thrify joker :/