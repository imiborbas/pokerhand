require_relative 'card'

class Hand
  module Ranks
    STRAIGHT_FLUSH = 8
    FOUR_OF_A_KIND = 7
    FULL_HOUSE = 6
    FLUSH = 5
    STRAIGHT = 4
    THREE_OF_A_KIND = 3
    TWO_PAIR = 2
    ONE_PAIR = 1
    HIGH_CARD = 0
  end

  attr_reader :cards

  def initialize(cards)
    @cards = cards.map { |card| Card.new(card) }.sort.reverse
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end

  def rank
    case
    when straight_flush? then Ranks::STRAIGHT_FLUSH
    when four_of_a_kind? then Ranks::FOUR_OF_A_KIND
    when full_house? then Ranks::FULL_HOUSE
    when flush? then Ranks::FLUSH
    when straight? then Ranks::STRAIGHT
    when three_of_a_kind? then Ranks::THREE_OF_A_KIND
    when two_pair? then Ranks::TWO_PAIR
    when one_pair? then Ranks::ONE_PAIR
    else Ranks::HIGH_CARD
    end
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    rank_group_counts.values.sort == [1, 4]
  end

  def full_house?
    rank_group_counts.values.sort == [2, 3]
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    check_straight(@cards) || check_straight(@cards[1...5] + [@cards[0].ace_to_one])
  end

  def three_of_a_kind?
    rank_group_counts.values.sort == [1, 1, 3]
  end

  def two_pair?
    rank_group_counts.values.sort == [1, 2, 2]
  end

  def one_pair?
    rank_group_counts.values.sort == [1, 1, 1, 2]
  end

  def side_cards
    @cards
      .inject(Hash.new([])) { |hash, card| hash[card.rank] += [card]; hash }
      .select { |_, cards| cards.count == 1 }
      .values
      .flatten
  end

  def ranks
    @cards.map(&:rank)
  end

  def suits
    @cards.map(&:suit)
  end

  def rank_group_counts
    ranks.inject(Hash.new(0)) do |hash, rank|
      hash[rank] += 1
      hash
    end
  end

  private

  def check_straight(cards)
    (1...5).each do |i|
      return false unless cards[i - 1].rank_number == cards[i].rank_number + 1
    end

    true
  end
end
