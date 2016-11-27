class Card
  include Comparable

  attr_reader :rank, :suit

  def initialize(shorthand)
    @rank = shorthand[0]
    @suit = shorthand[1]
  end

  def <=>(other)
    rank_number <=> other.rank_number
  end

  def rank_number
    case rank
    when 'T' then 10
    when 'J' then 11
    when 'Q' then 12
    when 'K' then 13
    when 'A' then 14
    else rank.to_i
    end
  end
end
