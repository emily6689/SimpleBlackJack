class Deck
  attr_reader :cards
  SUITS  = %w(H D S C)
  RANKS = %w(A 1 2 3 4 5 6 7 8 9 10 J Q K)
  VALUES = {
    'A' => 1,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10
  }

  def initialize
    @cards = build_deck
  end

  def build_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck
  end

#   def self.shuffle
#     @cards.shuffle!
#   end
# end


class Card
  attr_reader :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class Hand
  attr_reader :hand_cards
  def initialize
    @hand_cards = []
  end

  def deal_from(deck)
    @hand_cards << deck.cards.pop
  end
end

class Game
  attr_reader :game_deck, :player_hand, :dealer_hand
  def initialize
    @game_deck = Deck.new
    @game_deck.cards.shuffle!
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times{@player_hand.deal_from game_deck}
    2.times{@dealer_hand.deal_from game_deck}
  end
end
