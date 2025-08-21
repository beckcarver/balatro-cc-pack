-- -- Coven Flush
-- SMODS.Joker {
--     key = "coven_flush",
--     blueprint_compat = true,
--     eternal_compat = true,
--     unlocked = true,
--     discovered = true,
--     rarity = 3, -- Rare
--     cost = 8,
--     atlas = 'ModdedVanilla',
--     pos = { x = 3, y = 5 },

--     config = { extra = { poker_hand = 'Flush House', applied = false } },

--     loc_txt = {
--         name = "Coven Flush",
--         text = {
--             "When a {C:attention}Flush House{} is scored",
--             "apply a random edition to",
--             "the first card scored"
--         }
--     },

--     loc_vars = function(self, info_queue, card)
--         return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
--     end,

--     calculate = function(self, card, context)
--         if context.joker_main and not card.ability.extra.applied then
--             local hand_cards = context.poker_hands[card.ability.extra.poker_hand] or {}
--             if #hand_cards > 0 then
--                 local first_card = hand_cards[1]
--                 if first_card then
--                     first_card.edition = first_card.edition or {}
--                     if not (first_card.edition.foil or first_card.edition.holo or first_card.edition.polychrome or first_card.edition.negative) then
                        
--                         -- Weighted random selection
--                         local roll = math.random()
--                         local edition_key
--                         if roll <= 0.50 then
--                             edition_key = "foil"
--                         elseif roll <= 0.85 then -- 0.50 + 0.35
--                             edition_key = "holo"
--                         else
--                             edition_key = "polychrome"
--                         end

--                         first_card:set_edition({ [edition_key] = true })
--                         card.ability.extra.applied = true
--                         first_card:juice_up(0.3, 0.5)
--                     end
--                 end
--             end
--         end
--     end,

--     calculate_joker_reset = function(self, card, context)
--         if context.start_of_round then
--             card.ability.extra.applied = false
--         end
--     end
-- }
