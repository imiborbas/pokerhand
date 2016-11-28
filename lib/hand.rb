require_relative 'card'

class Hand
  def initialize(cards)
    @cards = cards.map { |card| Card.new(card) }.sort.reverse
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end

  def straight?
    check_straight(@cards) || check_straight(@cards[1...5] + [@cards[0].ace_to_one])
  end

  def four_of_a_kind?
    groups.values.include?(4)
  end

  def full_house?
    (groups.values & [2, 3]) == [2, 3]
  end

  def flush?
    suits.uniq.size == 1
  end

  def ranks
    @cards.map(&:rank)
  end

  def suits
    @cards.map(&:suit)
  end

  def groups
    ranks.inject(Hash.new(0)) do |hash, element|
      hash[element] += 1
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
