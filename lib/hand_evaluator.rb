require_relative 'hand'

class HandEvaluator
  def return_stronger_hand(left, right)
    Hand.new(left) > Hand.new(right) ? left : right;
  end
end
