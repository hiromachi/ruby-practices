# frozen_string_literal: true

def fizzbuzz(start, finish)
  start.upto(finish) do |number|
    if (number % 3).zero? && (number % 5).zero?
      puts 'FizzBuzz'
    elsif (number % 5).zero?
      puts 'Buzz'
    elsif (number % 3).zero?
      puts 'Fizz'
    else
      puts number
    end
  end
end

# 開始と終了の数値を引数で渡す
fizzbuzz(1, 20)
