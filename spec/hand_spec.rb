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
end
