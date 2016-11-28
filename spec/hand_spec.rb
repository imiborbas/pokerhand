require 'hand'

describe Hand do
  describe '#new' do
    it 'returns a new Hand instance' do
      hand = Hand.new(%w{AS QS JD TS 9S})

      expect(hand.class).to eq(Hand)
    end
  end

  describe '#cards' do
    it 'returns a all of the cards in the hand, sorted from the highest to the lowest ranking card' do
      hand = Hand.new(%w{JD 9S AS TS QS})

      expect(hand.cards).to eq([Card.new('AS'), Card.new('QS'), Card.new('JD'), Card.new('TS'), Card.new('9S')])
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the cards in the hand, sorted from the highest to the lowest ranking card' do
      hand = Hand.new(%w{JD 9S AS TS QS})

      expect(hand.to_s).to eq('AS QS JD TS 9S')
    end
  end

  describe '#rank' do
    it 'returns Hand::Ranks::STRAIGHT_FLUSH if it has a straight flush combination' do
      hand = Hand.new(%w{2D 3D 4D 5D 6D})

      expect(hand.rank).to eq(Hand::Ranks::STRAIGHT_FLUSH)
    end

    it 'returns Hand::Ranks::FOUR_OF_A_KIND if it has a four of a kind combination' do
      hand = Hand.new(%w{2S 2C 4H 2D 2C})

      expect(hand.rank).to eq(Hand::Ranks::FOUR_OF_A_KIND)
    end

    it 'returns Hand::Ranks::FULL_HOUSE if it has a full house combination' do
      hand = Hand.new(%w{2S 2C 4H 4D 4C})

      expect(hand.rank).to eq(Hand::Ranks::FULL_HOUSE)
    end

    it 'returns Hand::Ranks::FLUSH if it has a flush combination' do
      hand = Hand.new(%w{2D 3D 4D 5D 7D})

      expect(hand.rank).to eq(Hand::Ranks::FLUSH)
    end

    it 'returns Hand::Ranks::STRAIGHT if it has a straight combination' do
      hand = Hand.new(%w{2D 3C 4S 5H 6D})

      expect(hand.rank).to eq(Hand::Ranks::STRAIGHT)
    end

    it 'returns Hand::Ranks::THREE_OF_A_KIND if it has a three of a kind combination' do
      hand = Hand.new(%w{2D 3C 2S 5H 2H})

      expect(hand.rank).to eq(Hand::Ranks::THREE_OF_A_KIND)
    end

    it 'returns Hand::Ranks::TWO_PAIR if it has a two pair combination' do
      hand = Hand.new(%w{2D 3C 2S 5H 3H})

      expect(hand.rank).to eq(Hand::Ranks::TWO_PAIR)
    end

    it 'returns Hand::Ranks::ONE_PAIR if it has a one pair combination' do
      hand = Hand.new(%w{2D 3C 2S 5H 6H})

      expect(hand.rank).to eq(Hand::Ranks::ONE_PAIR)
    end

    it 'returns Hand::Ranks::HIGH_CARD if it does not have any particular combination' do
      hand = Hand.new(%w{2D 3C 4S 5H 7D})

      expect(hand.rank).to eq(Hand::Ranks::HIGH_CARD)
    end
  end

  describe '#straight_flush?' do
    it 'returns false if not all the cards have the same suit in the given hand' do
      hand = Hand.new(%w{2S 3C 4H 5D 6C})

      expect(hand.straight_flush?).to eq(false)
    end

    it 'returns false if all the cards have the same suit, but they do not form a sequence in the given hand' do
      hand = Hand.new(%w{2D 3D 4D 5D 7D})

      expect(hand.straight_flush?).to eq(false)
    end

    it 'returns true if all the cards have the same suit and form a sequence in the given hand' do
      hand = Hand.new(%w{2C 3C 4C 5C 6C})

      expect(hand.straight_flush?).to eq(true)
    end
  end

  describe '#four_of_a_kind?' do
    it 'returns false if the given hand does not have four cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 2D 2C})

      expect(hand.four_of_a_kind?).to eq(false)
    end

    it 'returns true if the given hand has four cards of the same rank' do
      hand = Hand.new(%w{2S 2C 4H 2D 2C})

      expect(hand.four_of_a_kind?).to eq(true)
    end
  end

  describe '#full_house?' do
    it 'returns false if the given hand does not have two and three cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 2D 2C})

      expect(hand.full_house?).to eq(false)
    end

    it 'returns true if the given hand has two and three cards of the same rank' do
      hand = Hand.new(%w{2S 3C 2H 2D 3C})

      expect(hand.full_house?).to eq(true)
    end
  end

  describe '#flush?' do
    it 'returns false if not all the cards have the same suit in the given hand' do
      hand = Hand.new(%w{2S 3C 4H 2D 2C})

      expect(hand.flush?).to eq(false)
    end

    it 'returns true if all the cards have the same suit in the given hand' do
      hand = Hand.new(%w{2S 3S 2S 2S 3S})

      expect(hand.flush?).to eq(true)
    end
  end

  describe '#straight?' do
    it 'returns false if the given hand is not a straight' do
      hand = Hand.new(%w{2S 3C 4H 5D 7C})

      expect(hand.straight?).to eq(false)
    end

    it 'returns true if the given hand is a regular straight' do
      hand = Hand.new(%w{2S 3C 4H 5D 6C})

      expect(hand.straight?).to eq(true)
    end

    it 'returns true if the given hand is a straight (ace high)' do
      hand = Hand.new(%w{TS JC QH KD AC})

      expect(hand.straight?).to eq(true)
    end

    it 'returns true if the given hand is a straight (five high)' do
      hand = Hand.new(%w{2S 3C 4H 5D AC})

      expect(hand.straight?).to eq(true)
    end
  end

  describe '#three_of_a_kind?' do
    it 'returns false if the given hand does not have three cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 2D 9C})

      expect(hand.three_of_a_kind?).to eq(false)
    end

    it 'returns true if the given hand has three cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 2D 2C})

      expect(hand.three_of_a_kind?).to eq(true)
    end
  end

  describe '#two_pair?' do
    it 'returns false if the given hand does not have two distinct pairs of cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 2D 9C})

      expect(hand.two_pair?).to eq(false)
    end

    it 'returns true if the given hand has two distinct pairs of cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 3D 2C})

      expect(hand.two_pair?).to eq(true)
    end
  end

  describe '#one_pair?' do
    it 'returns false if the given hand does not have exactly one pair of cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 6D 9C})

      expect(hand.one_pair?).to eq(false)
    end

    it 'returns true if the given hand has exactly one pair of cards of the same rank' do
      hand = Hand.new(%w{2S 3C 4H 6D 2C})

      expect(hand.one_pair?).to eq(true)
    end
  end

  describe '#side_cards' do
    it 'returns the cards that do not form any particular valid combination' do
      hand = Hand.new(%w{2S 3C 4H 6D 2C})

      expect(hand.side_cards).to eq([Card.new('6D'), Card.new('4H'), Card.new('3C')])
    end
  end

  describe '#ranks' do
    it 'returns the ranks of all the cards in the hand' do
      hand = Hand.new(%w{2S 3C 4H 5D AC})

      expect(hand.ranks).to eq(%w{A 5 4 3 2})
    end
  end

  describe '#suits' do
    it 'returns the suits of all the cards in the hand' do
      hand = Hand.new(%w{2S 3C 4H 5D AC})

      expect(hand.suits).to eq(%w{C D H C S})
    end
  end

  describe '#rank_group_counts' do
    it 'returns a hash of the structure { "rank" => "count" }' do
      hand = Hand.new(%w{2S 3C 2H 2D 3C})

      expect(hand.rank_group_counts).to eq({ '3' => 2, '2' => 3 })
    end
  end
end
