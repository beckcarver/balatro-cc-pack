-- Mining Operation
SMODS.Joker {
    key = "mining_operation",
    blueprint_compat = true,
    rarity = 1, -- common
    cost = 5,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    pos = { x = 2, y = 3 },
    config = { extra = { repetitions = 1 } },
    loc_txt = {
        name = "Mining Operation",
        text = {
            "Retrigger all",
            "{C:attention}Stone{} cards"
        }
    },
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            -- Check if the card has the Stone enhancement
            if context.other_card.ability.name == "Stone Card" then
                return {
                    message = "Again!",
                    repetitions = card.ability.extra.repetitions,
                    card = context.other_card
                }
            end
        end
    end
}
