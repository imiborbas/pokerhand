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
end
