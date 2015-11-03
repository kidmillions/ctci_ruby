# bitwise stuff


class Fixnum
  def get_bit(i)
    (self & (1 << i) != 0)
  end

  def set_bit(i)
    self | (1 << i)
  end

  def clear_bit(i)
    mask = ~(1 << i)
    self & mask
  end

  def clear_bit_through(i)
    mask = ~(1 << i) - 1
    p mask.to_s(2)
    self & mask
  end


end
