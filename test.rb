def declination(number, first, second, third)
  ostatok = number % 10

  if number.to_s.split(//).size > 2
    reversed_number_array = number.to_s.reverse.split(//)
    number = reversed_number_array[1] + reversed_number_array[0]
    number = number.to_i
  end
  if number >= 11 && number <= 14
    return third
  end

  if ostatok == 1
    return first
  end

  if ostatok >= 2 && ostatok <= 4
    return second
  end

  if (ostatok > 4 && ostatok <= 9) || ostatok == 0
    return third
  end
end

puts declination(1, "крокодил", "крокодила", "крокодилов")