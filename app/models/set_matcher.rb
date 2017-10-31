class SetMatcher

  def self.is_a_set?(card_ids)
    card_ids.sort!
    $all_sets_SetMatcher.include?(card_ids)
  end


  def self.find_cards(id_ary)
    found_cards = []
    id_ary.each do |id|
     found_cards << Card.find(id)
    end
    found_cards
  end


  #DI: grouped_in_set needs to be made dynamic
  def self.make_group(cards, game, player=nil)


    cards.each do |card|
      game_card = GameCard.find_by(game_id: game.id, card_id: card.to_i)
      game_card.update_attributes(status: "grouped", grouped_by_player: player.id, board_position: nil, grouped_in_set: 1)
      # player.grouped_cards << game_card if player
      game.remove_card(card)
    end

  render_next_deal = ApplicationController.renderer.render(partial: '/partials/card_show_next_deal', locals:{player_selection: game.duct_tape})

    ActionCable.server.broadcast "game_channel", {action: "next_deal_info", next_deal: render_next_deal, sets_made: game.sets_made, remaining_cards: game.undrawn_cards.count}

  end


  private


  # def self.is_a_set?(cards)
  #   attributes_for_set(cards, :color) && attributes_for_set(cards, :shading) && attributes_for_set(cards, :number) && attributes_for_set(cards, :shape)
  # end

   def self.attributes_for_set(cards, attribute)
    card_1 = cards[0]
    card_2 = cards[1]
    card_3 = cards[2]

    (card_1.send(attribute) == card_2.send(attribute) && card_1.send(attribute) == card_3.send(attribute) && card_2.send(attribute) == card_3.send(attribute)) || (card_1.send(attribute) != card_2.send(attribute) && card_1.send(attribute) != card_3.send(attribute) && card_2.send(attribute) != card_3.send(attribute))
  end

  $all_sets_SetMatcher = [[27, 36, 72], [3, 15, 27], [27, 40, 56], [9, 18, 27], [21, 24, 27], [27, 34, 71], [27, 30, 69], [27, 37, 59], [8, 16, 27], [27, 44, 61], [6, 12, 27], [5, 10, 27], [27, 29, 67], [4, 11, 27], [27, 45, 63], [27, 28, 68], [19, 23, 27], [27, 35, 70], [7, 17, 27], [1, 14, 27], [27, 41, 55], [27, 42, 57], [25, 26, 27], [27, 31, 65], [27, 38, 58], [2, 13, 27], [27, 33, 66], [20, 22, 27], [27, 32, 64], [27, 39, 60], [27, 43, 62], [27, 53, 79], [27, 49, 74], [27, 47, 76], [27, 54, 81], [27, 50, 73], [27, 51, 75], [27, 46, 77], [27, 48, 78], [27, 52, 80], [3, 36, 60], [36, 40, 47], [18, 36, 81], [21, 36, 69], [34, 35, 36], [30, 33, 36], [36, 37, 50], [16, 36, 80], [36, 44, 52], [6, 36, 57], [10, 36, 77], [29, 31, 36], [8, 36, 61], [11, 36, 76], [36, 45, 54], [28, 32, 36], [23, 36, 64], [5, 36, 55], [15, 36, 75], [7, 36, 62], [14, 36, 73], [36, 41, 46], [36, 42, 48], [26, 36, 70], [24, 36, 66], [12, 36, 78], [36, 38, 49], [2, 36, 58], [22, 36, 65], [25, 36, 71], [13, 36, 74], [19, 36, 68], [17, 36, 79], [9, 36, 63], [36, 39, 51], [4, 36, 56], [20, 36, 67], [1, 36, 59], [36, 43, 53], [3, 40, 80], [3, 18, 24], [3, 12, 21], [3, 34, 59], [3, 30, 57], [3, 37, 74], [3, 16, 23], [3, 44, 76], [3, 6, 9], [3, 10, 20], [3, 29, 55], [3, 4, 8], [3, 11, 19], [3, 45, 78], [3, 28, 56], [3, 5, 7], [3, 35, 58], [3, 14, 25], [3, 41, 79], [3, 42, 81], [3, 13, 26], [3, 31, 62], [3, 38, 73], [1, 2, 3], [3, 33, 63], [3, 17, 22], [3, 32, 61], [3, 39, 75], [3, 43, 77], [3, 53, 67], [3, 52, 68], [3, 49, 71], [3, 47, 64], [3, 54, 69], [3, 51, 72], [3, 50, 70], [3, 48, 66], [3, 46, 65], [18, 40, 65], [21, 40, 62], [34, 40, 46], [30, 40, 53], [37, 40, 43], [16, 40, 64], [39, 40, 44], [6, 40, 77], [10, 40, 70], [29, 40, 54], [8, 40, 75], [11, 40, 72], [38, 40, 45], [28, 40, 52], [23, 40, 60], [5, 40, 78], [35, 40, 48], [15, 40, 68], [7, 40, 73], [14, 40, 69], [40, 41, 42], [26, 40, 57], [24, 40, 59], [12, 40, 71], [31, 40, 49], [2, 40, 81], [33, 40, 50], [22, 40, 58], [25, 40, 55], [13, 40, 67], [19, 40, 61], [17, 40, 66], [9, 40, 74], [32, 40, 51], [4, 40, 76], [20, 40, 63], [1, 40, 79], [6, 18, 21], [18, 34, 80], [18, 30, 78], [18, 37, 68], [16, 17, 18], [18, 44, 70], [10, 14, 18], [18, 29, 76], [8, 18, 25], [11, 13, 18], [18, 45, 72], [18, 28, 77], [1, 18, 23], [5, 18, 19], [18, 35, 79], [12, 15, 18], [7, 18, 26], [18, 41, 64], [18, 42, 66], [18, 31, 74], [18, 38, 67], [2, 18, 22], [18, 33, 75], [18, 32, 73], [18, 39, 69], [4, 18, 20], [18, 43, 71], [18, 53, 61], [18, 49, 56], [18, 47, 58], [18, 54, 63], [18, 52, 62], [18, 51, 57], [18, 48, 60], [18, 50, 55], [18, 46, 59], [21, 34, 68], [21, 30, 66], [21, 37, 56], [5, 16, 21], [21, 44, 58], [2, 10, 21], [21, 29, 64], [8, 13, 21], [1, 11, 21], [21, 45, 60], [21, 28, 65], [21, 23, 25], [21, 35, 67], [9, 15, 21], [7, 14, 21], [21, 41, 61], [21, 42, 63], [21, 22, 26], [21, 31, 71], [21, 38, 55], [21, 33, 72], [19, 20, 21], [4, 17, 21], [21, 32, 70], [21, 39, 57], [21, 43, 59], [21, 53, 76], [21, 50, 79], [21, 49, 80], [21, 47, 73], [21, 54, 78], [21, 48, 75], [21, 52, 77], [21, 51, 81], [21, 46, 74], [30, 32, 34], [34, 37, 49], [16, 34, 79], [34, 44, 54], [6, 34, 56], [10, 34, 76], [29, 33, 34], [8, 34, 63], [11, 34, 78], [34, 45, 53], [28, 31, 34], [23, 34, 66], [5, 34, 57], [15, 34, 74], [7, 34, 61], [14, 34, 75], [34, 41, 48], [34, 42, 47], [26, 34, 72], [24, 34, 65], [12, 34, 77], [34, 38, 51], [2, 34, 60], [22, 34, 64], [25, 34, 70], [13, 34, 73], [19, 34, 67], [17, 34, 81], [9, 34, 62], [34, 39, 50], [4, 34, 55], [20, 34, 69], [1, 34, 58], [34, 43, 52], [30, 37, 47], [16, 30, 77], [30, 44, 49], [6, 30, 63], [10, 30, 74], [28, 29, 30], [8, 30, 58], [11, 30, 73], [30, 45, 51], [23, 30, 70], [5, 30, 61], [30, 31, 35], [15, 30, 81], [7, 30, 59], [14, 30, 79], [30, 41, 52], [30, 42, 54], [26, 30, 67], [24, 30, 72], [12, 30, 75], [30, 38, 46], [2, 30, 55], [22, 30, 71], [25, 30, 68], [13, 30, 80], [19, 30, 65], [17, 30, 76], [9, 30, 60], [30, 39, 48], [4, 30, 62], [20, 30, 64], [1, 30, 56], [30, 43, 50], [16, 37, 67], [37, 42, 44], [6, 37, 80], [10, 37, 64], [29, 37, 48], [8, 37, 78], [11, 37, 66], [37, 41, 45], [28, 37, 46], [23, 37, 63], [5, 37, 81], [35, 37, 51], [15, 37, 71], [7, 37, 76], [14, 37, 72], [26, 37, 60], [24, 37, 62], [12, 37, 65], [31, 37, 52], [37, 38, 39], [2, 37, 75], [33, 37, 53], [22, 37, 61], [25, 37, 58], [13, 37, 70], [19, 37, 55], [17, 37, 69], [9, 37, 77], [32, 37, 54], [4, 37, 79], [20, 37, 57], [1, 37, 73], [16, 44, 72], [6, 16, 20], [10, 13, 16], [16, 29, 78], [11, 15, 16], [16, 45, 71], [16, 28, 76], [16, 35, 81], [7, 16, 25], [12, 14, 16], [16, 41, 66], [16, 42, 65], [9, 16, 26], [2, 16, 24], [16, 31, 73], [16, 38, 69], [16, 33, 74], [1, 16, 22], [4, 16, 19], [16, 32, 75], [16, 39, 68], [16, 43, 70], [16, 53, 63], [16, 49, 55], [16, 47, 60], [16, 51, 56], [16, 54, 62], [16, 50, 57], [16, 48, 59], [16, 52, 61], [16, 46, 58], [6, 44, 73], [10, 44, 69], [29, 44, 50], [8, 44, 80], [11, 44, 68], [43, 44, 45], [28, 44, 51], [23, 44, 56], [5, 44, 74], [35, 44, 53], [15, 44, 64], [7, 44, 81], [14, 44, 65], [38, 41, 44], [26, 44, 62], [24, 44, 55], [12, 44, 67], [31, 44, 48], [2, 44, 77], [33, 44, 46], [22, 44, 57], [25, 44, 63], [13, 44, 66], [19, 44, 60], [17, 44, 71], [9, 44, 79], [32, 44, 47], [4, 44, 75], [20, 44, 59], [1, 44, 78], [6, 10, 26], [6, 29, 61], [1, 6, 8], [6, 11, 25], [6, 45, 75], [6, 28, 62], [6, 13, 23], [4, 5, 6], [6, 35, 55], [6, 15, 24], [2, 6, 7], [6, 14, 22], [6, 41, 76], [6, 42, 78], [6, 31, 59], [6, 38, 79], [6, 33, 60], [6, 17, 19], [6, 32, 58], [6, 39, 81], [6, 43, 74], [6, 53, 64], [6, 49, 68], [6, 47, 70], [6, 54, 66], [6, 48, 72], [6, 51, 69], [6, 50, 67], [6, 46, 71], [6, 52, 65], [10, 29, 75], [8, 10, 24], [10, 11, 12], [10, 45, 68], [10, 28, 73], [9, 10, 23], [10, 35, 78], [10, 15, 17], [7, 10, 22], [10, 41, 72], [10, 42, 71], [10, 31, 79], [10, 38, 66], [10, 33, 80], [4, 10, 25], [1, 10, 19], [10, 32, 81], [10, 39, 65], [10, 43, 67], [10, 53, 60], [10, 49, 61], [10, 47, 57], [10, 48, 56], [10, 54, 59], [10, 51, 62], [10, 50, 63], [10, 52, 58], [10, 46, 55], [8, 29, 59], [11, 29, 74], [29, 45, 49], [23, 29, 71], [5, 29, 62], [29, 32, 35], [15, 29, 79], [7, 29, 60], [14, 29, 80], [29, 41, 53], [29, 42, 52], [26, 29, 68], [24, 29, 70], [12, 29, 73], [29, 38, 47], [2, 29, 56], [22, 29, 72], [25, 29, 69], [13, 29, 81], [19, 29, 66], [17, 29, 77], [9, 29, 58], [29, 39, 46], [4, 29, 63], [20, 29, 65], [1, 29, 57], [29, 43, 51], [8, 11, 23], [8, 45, 79], [8, 28, 60], [2, 5, 8], [8, 35, 62], [8, 15, 19], [7, 8, 9], [8, 14, 20], [8, 41, 74], [8, 42, 73], [8, 17, 26], [8, 12, 22], [8, 31, 57], [8, 38, 77], [8, 33, 55], [8, 32, 56], [8, 39, 76], [8, 43, 81], [8, 53, 71], [8, 47, 68], [8, 49, 66], [8, 54, 70], [8, 52, 72], [8, 46, 69], [8, 50, 65], [8, 48, 67], [8, 51, 64], [11, 45, 67], [11, 28, 75], [5, 11, 26], [11, 35, 77], [7, 11, 24], [11, 14, 17], [11, 41, 71], [11, 42, 70], [11, 31, 81], [11, 38, 65], [2, 11, 20], [11, 33, 79], [9, 11, 22], [11, 32, 80], [11, 39, 64], [11, 43, 69], [11, 53, 59], [11, 49, 63], [11, 47, 56], [11, 54, 58], [11, 50, 62], [11, 46, 57], [11, 52, 60], [11, 48, 55], [11, 51, 61], [28, 45, 50], [23, 45, 55], [5, 45, 73], [35, 45, 52], [15, 45, 66], [7, 45, 80], [14, 45, 64], [39, 42, 45], [26, 45, 61], [24, 45, 57], [12, 45, 69], [31, 45, 47], [2, 45, 76], [33, 45, 48], [22, 45, 56], [25, 45, 62], [13, 45, 65], [19, 45, 59], [17, 45, 70], [9, 45, 81], [32, 45, 46], [4, 45, 74], [20, 45, 58], [1, 45, 77], [23, 28, 72], [5, 28, 63], [28, 33, 35], [15, 28, 80], [7, 28, 58], [14, 28, 81], [28, 41, 54], [28, 42, 53], [26, 28, 69], [24, 28, 71], [12, 28, 74], [28, 38, 48], [2, 28, 57], [22, 28, 70], [25, 28, 67], [13, 28, 79], [19, 28, 64], [17, 28, 78], [9, 28, 59], [28, 39, 47], [4, 28, 61], [20, 28, 66], [1, 28, 55], [28, 43, 49], [5, 14, 23], [23, 35, 65], [4, 15, 23], [7, 12, 23], [23, 41, 59], [23, 42, 58], [20, 23, 26], [22, 23, 24], [23, 31, 69], [23, 38, 62], [2, 17, 23], [23, 33, 67], [23, 32, 68], [23, 39, 61], [23, 43, 57], [23, 53, 74], [23, 48, 79], [23, 49, 78], [23, 47, 80], [23, 51, 76], [23, 54, 73], [23, 52, 75], [23, 50, 77], [23, 46, 81], [5, 35, 56], [5, 15, 22], [5, 41, 77], [5, 42, 76], [5, 13, 24], [5, 12, 25], [5, 31, 60], [5, 38, 80], [5, 33, 58], [5, 17, 20], [1, 5, 9], [5, 32, 59], [5, 39, 79], [5, 43, 75], [5, 53, 65], [5, 50, 68], [5, 49, 69], [5, 47, 71], [5, 54, 64], [5, 46, 72], [5, 48, 70], [5, 52, 66], [5, 51, 67], [15, 35, 73], [7, 35, 63], [14, 35, 74], [35, 41, 47], [35, 42, 46], [26, 35, 71], [24, 35, 64], [12, 35, 76], [35, 38, 50], [2, 35, 59], [22, 35, 66], [25, 35, 72], [13, 35, 75], [19, 35, 69], [17, 35, 80], [9, 35, 61], [35, 39, 49], [4, 35, 57], [20, 35, 68], [1, 35, 60], [35, 43, 54], [7, 15, 20], [13, 14, 15], [15, 41, 67], [15, 42, 69], [1, 15, 26], [15, 31, 77], [15, 38, 70], [2, 15, 25], [15, 33, 78], [15, 32, 76], [15, 39, 72], [15, 43, 65], [15, 53, 55], [15, 49, 59], [15, 47, 61], [15, 52, 56], [15, 54, 57], [15, 46, 62], [15, 51, 60], [15, 50, 58], [15, 48, 63], [7, 41, 75], [7, 42, 74], [7, 31, 55], [7, 38, 78], [7, 33, 56], [7, 13, 19], [7, 32, 57], [7, 39, 77], [1, 4, 7], [7, 43, 79], [7, 53, 72], [7, 48, 68], [7, 49, 64], [7, 47, 69], [7, 54, 71], [7, 52, 70], [7, 50, 66], [7, 46, 67], [7, 51, 65], [14, 41, 68], [14, 42, 67], [2, 14, 26], [4, 14, 24], [14, 31, 78], [14, 38, 71], [14, 33, 76], [9, 14, 19], [14, 32, 77], [14, 39, 70], [14, 43, 66], [14, 53, 56], [14, 49, 60], [14, 47, 62], [14, 54, 55], [14, 52, 57], [14, 50, 59], [14, 48, 61], [14, 51, 58], [14, 46, 63], [26, 41, 56], [24, 41, 58], [12, 41, 70], [31, 41, 51], [2, 41, 80], [33, 41, 49], [22, 41, 60], [25, 41, 57], [13, 41, 69], [19, 41, 63], [17, 41, 65], [9, 41, 73], [32, 41, 50], [39, 41, 43], [4, 41, 78], [20, 41, 62], [1, 41, 81], [26, 42, 55], [24, 42, 60], [12, 42, 72], [31, 42, 50], [38, 42, 43], [2, 42, 79], [33, 42, 51], [22, 42, 59], [25, 42, 56], [13, 42, 68], [19, 42, 62], [17, 42, 64], [9, 42, 75], [32, 42, 49], [4, 42, 77], [20, 42, 61], [1, 42, 80], [19, 24, 26], [4, 12, 26], [26, 31, 66], [26, 38, 59], [26, 33, 64], [26, 32, 65], [26, 39, 58], [26, 43, 63], [26, 53, 80], [26, 54, 79], [26, 49, 75], [26, 47, 77], [26, 48, 76], [26, 51, 73], [26, 50, 74], [26, 46, 78], [26, 52, 81], [9, 12, 24], [24, 31, 68], [24, 38, 61], [24, 33, 69], [20, 24, 25], [1, 17, 24], [24, 32, 67], [24, 39, 63], [24, 43, 56], [24, 53, 73], [24, 47, 79], [24, 49, 77], [24, 50, 76], [24, 54, 75], [24, 48, 81], [24, 51, 78], [24, 52, 74], [24, 46, 80], [12, 31, 80], [12, 38, 64], [2, 12, 19], [12, 33, 81], [12, 13, 17], [12, 32, 79], [12, 39, 66], [1, 12, 20], [12, 43, 68], [12, 53, 58], [12, 49, 62], [12, 47, 55], [12, 46, 56], [12, 54, 60], [12, 48, 57], [12, 50, 61], [12, 52, 59], [12, 51, 63], [31, 38, 54], [2, 31, 63], [31, 32, 33], [22, 31, 67], [25, 31, 64], [13, 31, 76], [19, 31, 70], [17, 31, 75], [9, 31, 56], [31, 39, 53], [4, 31, 58], [20, 31, 72], [1, 31, 61], [31, 43, 46], [2, 38, 74], [33, 38, 52], [22, 38, 63], [25, 38, 60], [13, 38, 72], [19, 38, 57], [17, 38, 68], [9, 38, 76], [32, 38, 53], [4, 38, 81], [20, 38, 56], [1, 38, 75], [2, 33, 61], [2, 4, 9], [2, 32, 62], [2, 39, 73], [2, 43, 78], [2, 53, 68], [2, 49, 72], [2, 47, 65], [2, 54, 67], [2, 51, 70], [2, 46, 66], [2, 52, 69], [2, 50, 71], [2, 48, 64], [22, 33, 68], [25, 33, 65], [13, 33, 77], [19, 33, 71], [17, 33, 73], [9, 33, 57], [33, 39, 54], [4, 33, 59], [20, 33, 70], [1, 33, 62], [33, 43, 47], [19, 22, 25], [4, 13, 22], [22, 32, 69], [22, 39, 62], [22, 43, 55], [22, 53, 75], [22, 46, 79], [22, 49, 76], [22, 47, 81], [22, 54, 74], [22, 52, 73], [22, 51, 77], [22, 50, 78], [22, 48, 80], [1, 13, 25], [9, 17, 25], [25, 32, 66], [25, 39, 59], [25, 43, 61], [25, 53, 81], [25, 52, 79], [25, 49, 73], [25, 47, 78], [25, 46, 76], [25, 54, 80], [25, 50, 75], [25, 48, 77], [25, 51, 74], [9, 13, 20], [13, 32, 78], [13, 39, 71], [13, 43, 64], [13, 53, 57], [13, 49, 58], [13, 47, 63], [13, 54, 56], [13, 48, 62], [13, 50, 60], [13, 51, 59], [13, 46, 61], [13, 52, 55], [19, 32, 72], [19, 39, 56], [19, 43, 58], [19, 53, 78], [19, 49, 79], [19, 47, 75], [19, 52, 76], [19, 54, 77], [19, 46, 73], [19, 50, 81], [19, 48, 74], [19, 51, 80], [17, 32, 74], [17, 39, 67], [17, 43, 72], [17, 53, 62], [17, 49, 57], [17, 47, 59], [17, 50, 56], [17, 54, 61], [17, 46, 60], [17, 48, 58], [17, 51, 55], [17, 52, 63], [9, 32, 55], [9, 39, 78], [9, 43, 80], [9, 53, 70], [9, 46, 68], [9, 49, 65], [9, 47, 67], [9, 54, 72], [9, 51, 66], [9, 48, 69], [9, 50, 64], [9, 52, 71], [32, 39, 52], [4, 32, 60], [20, 32, 71], [1, 32, 63], [32, 43, 48], [4, 39, 80], [20, 39, 55], [1, 39, 74], [4, 43, 73], [4, 53, 66], [4, 51, 68], [4, 49, 67], [4, 47, 72], [4, 54, 65], [4, 46, 70], [4, 50, 69], [4, 48, 71], [4, 52, 64], [20, 43, 60], [20, 53, 77], [20, 51, 79], [20, 49, 81], [20, 47, 74], [20, 54, 76], [20, 48, 73], [20, 46, 75], [20, 50, 80], [20, 52, 78], [1, 43, 76], [1, 53, 69], [1, 54, 68], [1, 49, 70], [1, 47, 66], [1, 50, 72], [1, 48, 65], [1, 52, 67], [1, 51, 71], [1, 46, 64], [48, 49, 53], [47, 50, 53], [52, 53, 54], [46, 51, 53], [57, 68, 79], [73, 76, 79], [56, 69, 79], [62, 72, 79], [61, 70, 79], [75, 77, 79], [59, 66, 79], [60, 65, 79], [55, 67, 79], [63, 71, 79], [74, 78, 79], [79, 80, 81], [58, 64, 79], [60, 68, 76], [56, 68, 80], [64, 68, 72], [63, 68, 73], [66, 68, 70], [62, 68, 74], [61, 68, 75], [59, 68, 77], [67, 68, 69], [65, 68, 71], [58, 68, 78], [55, 68, 81], [47, 49, 54], [49, 50, 51], [46, 49, 52], [46, 47, 48], [47, 51, 52], [56, 72, 76], [55, 70, 76], [62, 66, 76], [75, 76, 80], [76, 77, 78], [59, 69, 76], [57, 71, 76], [58, 67, 76], [61, 64, 76], [63, 65, 76], [74, 76, 81], [56, 66, 73], [56, 70, 78], [56, 59, 62], [56, 64, 75], [56, 71, 77], [55, 56, 57], [56, 60, 61], [56, 67, 81], [56, 58, 63], [56, 65, 74], [46, 50, 54], [48, 51, 54], [59, 72, 73], [70, 71, 72], [60, 72, 75], [66, 69, 72], [55, 72, 77], [57, 72, 78], [65, 67, 72], [61, 72, 80], [63, 72, 81], [58, 72, 74], [58, 70, 73], [62, 69, 73], [73, 74, 75], [73, 77, 81], [57, 65, 73], [60, 71, 73], [61, 67, 73], [73, 78, 80], [55, 64, 73], [62, 70, 81], [59, 70, 75], [57, 70, 77], [65, 69, 70], [60, 70, 74], [64, 67, 70], [63, 70, 80], [62, 67, 75], [62, 65, 77], [57, 58, 62], [55, 60, 62], [61, 62, 63], [62, 71, 80], [62, 64, 78], [57, 66, 75], [63, 69, 75], [58, 71, 75], [55, 65, 75], [75, 78, 81], [61, 66, 77], [60, 66, 81], [66, 67, 71], [63, 66, 78], [55, 66, 74], [58, 66, 80], [64, 65, 66], [58, 69, 77], [60, 67, 77], [63, 64, 77], [74, 77, 80], [57, 69, 81], [60, 69, 78], [61, 69, 74], [64, 69, 71], [55, 69, 80], [57, 60, 63], [57, 59, 61], [57, 67, 80], [57, 64, 74], [58, 59, 60], [60, 64, 80], [48, 50, 52], [59, 67, 78], [59, 71, 74], [55, 59, 63], [59, 65, 80], [59, 64, 81], [63, 67, 74], [61, 71, 81], [55, 58, 61], [61, 65, 78], [55, 71, 78], [58, 65, 81]]

end
