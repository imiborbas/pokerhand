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
end
