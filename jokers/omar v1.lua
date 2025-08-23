-- Omar
-- if we find a better gameplay loop for omar this joker could be renamed to something related to movement/repositioning
-- maybe knight?
SMODS.Joker {
    key = "omar_v1",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    rarity = 2, -- Uncommon
    cost = 7,
    pos = { x = 2, y = 5 },

    config = { extra = { chips = 100, mult = 20, xmult = 2, hand_count = 0 } },

    loc_txt = {
        name = "Omar v1",
        text = {
            "1st hand played gives {C:chips}+#1#{} chips",
            "2nd hand played gives {C:mult}+#2#{} mult",
            "3rd hand played gives {X:mult,C:white}x#3#{} multiplier",
            "{C:inactive}Currently on hand: {C:attention}#4#{}",
            "{C:dark_edition}stinkyinvegas.com{}"
        }
    },

    loc_vars = function(self, info_queue, card)
        local hand_stage = (card.ability.extra.hand_count % 3) + 1
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.xmult,
                hand_stage
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            -- Increment hand counter
            card.ability.extra.hand_count = (card.ability.extra.hand_count or 0) + 1

            if card.ability.extra.hand_count == 1 then
                juice_card_until(card, function() return false end, true)
                return {
                    message = "Chips!",
                    chips = card.ability.extra.chips
                }

            elseif card.ability.extra.hand_count == 2 then
                juice_card_until(card, function() return false end, true)
                return {
                    message = "Mult!",
                    mult = card.ability.extra.mult
                }

            elseif card.ability.extra.hand_count == 3 then
                card.ability.extra.hand_count = 0
                juice_card_until(card, function() return false end, true)
                return {
                    message = "Double!",
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
