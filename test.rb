# frozen_string_literal: true

def is_square(x)
  x >= 0 && Math.sqrt(x).to_i * Math.sqrt(x).to_i == x
end

puts is_square(68)