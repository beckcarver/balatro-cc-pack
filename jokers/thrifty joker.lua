-- Thrifty Joker
SMODS.Joker {
    key = "thrifty_joker",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    pos = { x = 0, y = 4 },
    rarity = 1, -- Common
    cost = 4,

    config = { 
        extra = { 
            enhancements = { "m_gold", "m_mult", "m_bonus", "m_glass", "m_steel", "m_stone" },
            poker_hand = 'High Card'
        } 
    },

    loc_txt = {
        name = "Thrifty Joker",
        text = {
            "Whenever hand is a {C:attention}High Card{}",
            "card gains a random enhancement"
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = {
            table.concat(card.ability.extra.enhancements or {}, ", "),
            localize(card.ability.extra.poker_hand, 'poker_hands')
        } }
    end,

    calculate = function(self, card, context)
        -- Only trigger if the **current scoring hand** is exactly High Card
        if context.before and context.main_eval and not context.blueprint and context.scoring_name == "High Card" then
            local first_card = context.scoring_hand[1]
            local enh_list = card.ability.extra.enhancements

            -- Pick a random enhancement
            local enhancement_type = pseudorandom_element(enh_list)
            first_card:set_ability(enhancement_type, nil, true)

            -- Trigger visual effect
            G.E_MANAGER:add_event(Event({
                func = function()
                    first_card:juice_up()
                    return true
                end
            }))

            return true
        end
    end
}
