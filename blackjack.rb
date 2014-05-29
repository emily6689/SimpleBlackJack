class Deck
  attr_reader :cards
  SUITS  = ['c', 'h', 's', 'd']
  VALUES = [2,3,4,5,6,7,8,9,10, 'J', 'Q', 'K', 'A']

  def initialize
    @cards = build_deck
  end

  def build_deck
    deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << Card.new(value, suit)
      end
    end
    deck
  end

  def self.shuffle
    @cards.each do ||
  end
end

class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end
