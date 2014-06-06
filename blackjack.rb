require 'pry'
class Deck
  attr_reader :cards
  SUITS  = %w(H D S C)
  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
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
    '10' => 10,
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
end

class Card
  attr_reader :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank}#{suit}"
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

  def get_value
    value = 0
    self.hand_cards.each do |card|
      value += Deck::VALUES[card.rank].to_i
    end
    value
  end

  def show_hand
    @hand_cards.join(' ')
  end
end

class Game
  attr_reader :game_deck, :player_hand, :dealer_hand

  def initialize
    @game_deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @game_deck.cards.shuffle!
    2.times{@player_hand.deal_from game_deck}
    2.times{@dealer_hand.deal_from game_deck}
  end

  def player_hand_value
    player_hand.get_value
  end

  def dealer_hand_value
    dealer_hand.get_value
  end

  def show_stats
    print "--- Dealer Hand: #{dealer_hand.show_hand} --- "
    puts "#{dealer_hand_value} "
    print "--- Your Hand: #{player_hand.show_hand} --- "
    puts "#{player_hand_value}"
  end

  def player_prompt
    print "Stand or hit? "
    decision = gets.chomp
  end

  def player_turn_under_21
    puts show_stats
    if player_hand_value > 21
      return false
    else
      decision = player_prompt
      if decision == "stand"
        return true
      elsif decision == "hit"
        player_hand.deal_from game_deck
        player_turn_under_21
      else
        puts 'Please enter "hit" or "stand"'
        player_turn_under_21
      end
    end
  end

  def dealer_turn_under_21
    puts show_stats
    if dealer_hand_value > 21
      false
    else
      if dealer_hand_value < 17
        dealer_hand.deal_from game_deck
        dealer_turn_under_21
      end
    end
    true
  end

  def play_blackjack
    if !player_turn_under_21
      "You've exceeded 21! You lose :("
    else
      if !dealer_turn_under_21
        "You win!"
      else
        puts show_stats
        if player_hand.get_value > dealer_hand.get_value
          return "You win!"
        elsif player_hand.get_value < dealer_hand.get_value
          return "You lose!"
        else
          return "TIE."
        end
      end
    end
  end
end

new_game = Game.new
puts new_game.play_blackjack
