-- -- Negative Orbit Joker
-- SMODS.Joker {
--     key = "bccp_negative_orbit",
--     blueprint_compat = false,
--     eternal_compat = true,
--     unlocked = true,
--     discovered = true,
--     rarity = 3, -- Rare
--     cost = 7,

--     atlas = 'ModdedVanilla',
--     pos = { x = 0, y = 0 },

--     config = { extra = { neg_given = 0, neg_cap = 2 } },

--     loc_txt = {
--         name = "Negative Orbit",
--         text = {
--             "The first {C:attention}#1#{} Planets created by the {C:blue}Blue Seal{}",
--             "are instead {C:attention}Negative{} Planets"
--         }
--     },

--     loc_vars = function(self, info_queue, card)
--         local extra = card.ability.extra or {}
--         return { vars = { extra.neg_cap or 2 } }
--     end,

--     calculate = function(self, card, context)
--         -- Ensure defaults exist
--         card.ability.extra = card.ability.extra or {}
--         card.ability.extra.neg_given = card.ability.extra.neg_given or 0
--         card.ability.extra.neg_cap = card.ability.extra.neg_cap or 2

--         if context.end_of_round and context.cardarea == G.hand and context.other_card.seal == 'Blue' then
--             if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 2 then
--                 G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
--                 G.E_MANAGER:add_event(Event({
--                     trigger = 'before',
--                     delay = 0.1,
--                     func = function()
--                         if G.GAME.last_hand_played then
--                             local _planet = nil
--                             for k, v in pairs(G.P_CENTER_POOLS.Planet) do
--                                 if v.config.hand_type == G.GAME.last_hand_played then
--                                     _planet = v.key
--                                 end
--                             end
--                             if _planet then
--                                 local make_negative = card.ability.extra.neg_given < card.ability.extra.neg_cap
--                                 SMODS.add_card({
--                                     key = _planet,
--                                     edition = make_negative and { negative = true } or nil
--                                 })
--                                 if make_negative then
--                                     card.ability.extra.neg_given = card.ability.extra.neg_given + 1
--                                 end
--                             end
--                             G.GAME.consumeable_buffer = 0
--                         end
--                         return true
--                     end
--                 }))
--                 return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
--             end
--         end
--     end
-- }



-- Creates two negatives then stops
-- SMODS.Joker {
--     key = "bccp_frozen_joker",
--     blueprint_compat = false,
--     eternal_compat = true,
--     unlocked = true,
--     discovered = true,
--     rarity = 3,
--     cost = 8,

--     atlas = 'ModdedVanilla',
--     pos = { x = 0, y = 0 },

--     loc_txt = {
--         name = "Frozen Joker",
--         text = {
--             "At end of round all",
--             "held consumable cards", 
--             "become {C:dark_edition}Negative{}"
--         }
--     },

--     calculate = function(self, card, context)
--         if context.end_of_round and context.individual then
--             G.E_MANAGER:add_event(Event({
--                 func = function()
--                     local flooped = 0
--                     for _, c in ipairs(G.consumeables.cards) do
--                         if not (c.edition and c.edition.negative) then
--                             G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
--                             c:set_edition("e_negative", true)
--                             flooped = flooped + 1
--                             -- if flooped >= 3 then break end
--                         end
--                     end
--                     if flooped > 0 then
--                         card:juice_up()
--                     end
--                     return true
--                 end
--             }))
--         end
--     end
-- }


-- -- Frozen Joker
-- SMODS.Joker {
--     key = "frozen_joker",
--     rarity = 3, -- Rare
--     cost = 8,
--     pos = { x = 4, y = 4 },
--     blueprint_compat = true,
--     eternal_compat = true,
--     unlocked = true,
--     discovered = true,
--     atlas = 'ModdedVanilla',
--     config = { extra = { frozen_count = 0 } },

--     loc_txt = {
--         name = "Frozen Joker",
--         text = {
--             "First {C:attention}3 Planet{} cards",
--             "added each round become {C:dark_edition}Negative{}"
--         }
--     },

--     -- Reset counter each round
--     before_round = function(self, card)
--         card.ability.extra.frozen_count = 0
--     end,

--     add_to_deck = function(self, card)
--         -- Hook the event when any card is added
--         G.E_MANAGER:add_event(Event({
--             func = function()
--                 for _, c in ipairs(G.GAME.added_cards or {}) do
--                     if c.set == "Planet" and self.ability.extra.frozen_count < 3 then
--                         c:set_edition("e_negative", true)
--                         self.ability.extra.frozen_count = self.ability.extra.frozen_count + 1
--                         c:juice_up() -- visual feedback
--                     end
--                 end
--                 return true
--             end
--         }))
--     end
-- }
