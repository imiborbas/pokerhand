require 'hand'

describe Hand do
  describe '#new' do
    it 'returns a new Hand instance' do
      hand = Hand.new(%w{AS QS JD TS 9S})

      expect(hand.class).to eq(Hand)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the cards in the hand, sorted from the highest to the lowest ranking card' do
      hand = Hand.new(%w{JD 9S AS TS QS})

      expect(hand.to_s).to eq('AS QS JD TS 9S')
    end
  end

  describe '.straight?' do
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

  describe '#groups' do
    it 'returns a hash of the structure { rank => count }' do
      hand = Hand.new(%w{2S 3C 2H 2D 3C})

      expect(hand.groups).to eq({'3' => 2, '2' => 3})
    end
  end
end
