def fizzbuzz(start, finish)
  start.upto(finish) do |number|
    if number % 3 == 0 && number % 5 == 0
      puts "FizzBuzz"
    elsif number % 5 == 0
      puts "Buzz"
    elsif number % 3 == 0
      puts "Fizz"
    else
      puts number
    end
  end
end

# 開始と終了の数値を引数で渡す
fizzbuzz(1, 20)
