require 'card'

describe Card do
  describe '#new' do
    it 'returns a new Card object' do
      card = Card.new('2S')

      expect(card.class).to eq(Card)
    end
  end

  describe '#<=>' do
    it 'ranks 2S lower than 3S' do
      expect(Card.new('2S')).to be < Card.new('3S')
    end

    it 'ranks 3S equally as 3C' do
      expect(Card.new('3S')).to eq Card.new('3C')
    end

    it 'ranks AS higher than KD' do
      expect(Card.new('AS')).to be > Card.new('KD')
    end
  end

  describe '#==' do

    it 'returns true if the two cards have the same rank, and the same suit' do
      expect(Card.new('4S')).to eq Card.new('4S')
    end

    it 'returns true if the two cards have the same rank, regardless of suit' do
      expect(Card.new('4S')).to eq Card.new('4H')
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the card' do
      card = Card.new('AS')

      expect(card.to_s).to eq('AS')
    end
  end

  describe '#ace_to_one' do
    it 'returns a new card if the original card was ace' do
      card = Card.new('AS')

      expect(card.ace_to_one).to_not equal(card)
    end

    it 'returns a new card with rank 1 if the original card was ace, keeping the suit the same' do
      card = Card.new('AS')

      expect(card.ace_to_one.to_s).to eq('1S')
    end

    it 'returns itself if the card is not an ace' do
      card = Card.new('KS')

      expect(card.ace_to_one).to equal(card)
    end
  end
end
