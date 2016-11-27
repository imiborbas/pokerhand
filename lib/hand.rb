require_relative 'card'

class Hand
  def initialize(cards)
    @cards = cards.map { |card| Card.new(card) }.sort.reverse
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end
end
