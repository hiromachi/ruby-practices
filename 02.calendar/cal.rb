#!/usr/bin/env ruby
require "date"

# 年月を取得する
def year_month_switcher()
  if ARGV.length == 0
    return @target_year_and_month = Date.new(Date.today.year, Date.today.month)
  end

  if ARGV.length == 1 || ARGV.length == 3 || ARGV.length >= 5
    puts "引数の指定が間違っています"
    return false
  end

  if ARGV.length == 2
    if ARGV[0] == "-y"
      if ARGV[1].to_i >= 1970 && ARGV[1].to_i <= 2100
        @target_year_and_month = Date.new(ARGV[1].to_i, Date.today.month)
      else
        puts "年は1970〜2100までの数字で入力してください"
      end
    elsif ARGV[0] == "-m"
      if ARGV[1].to_i >= 1 && ARGV[1].to_i <= 12
        @target_year_and_month = Date.new(Date.today.year, ARGV[1].to_i)
      else
        puts "月は1〜12までの数字で入力してください"
      end
    end
  elsif ARGV.length == 4
    if ARGV[0] == "-y" && ARGV[2] == "-m"
      if ARGV[1].to_i >= 1970 && ARGV[1].to_i <= 2100
        if ARGV[3].to_i >=1 && ARGV[3].to_i <= 12
          @target_year_and_month = Date.new(ARGV[1].to_i, ARGV[3].to_i)
        else
          puts "月は1〜12までの数字で入力してください"
        end
      else
        puts "年は1970〜2100までの数字で入力してください"
      end
    elsif ARGV[0] == "-m" && ARGV[2] == "-y"
      if ARGV[3].to_i >= 1970 && ARGV[3].to_i <= 2100
        if ARGV[1].to_i >= 1 && ARGV[1].to_i <= 12
          @target_year_and_month = Date.new(ARGV[3].to_i, ARGV[1].to_i)
        else
          puts "月は1〜12までの数字で入力してください"
        end
      else
        puts "年は1970〜2100までの数字で入力してください"
      end
    end
  elsif ARGV.length == 1 || ARGV.length == 3 || ARGV.length >= 5
    return "引数の指定が間違っています"
  end
end

def calendar()
  # カレンダーのヘッダーを表示する
  puts @target_year_and_month.strftime("%B %Y").center(20)
  puts "Su Mo Tu We Th Fr Sa"

  # 月の日数を取得する
  end_date = Date.new(@target_year_and_month.year, @target_year_and_month.month, -1)
  days = end_date.day
  count = 1

  # 日付から開始の曜日を取得する
  daynumber = @target_year_and_month.wday

  while count <= days
    # 1日の曜日まで空白を表示する
    if count == 1
      print "   " * (daynumber)
    end

    # 日付を表示する
    # 1〜9日目の場合は数字の前後に空白を追加する
    # 10日目以降は後ろに空白を追加する
    if count <= 9
      print " #{count} "
    else
      print "#{count} "
    end

    # 土曜日まで表示したら改行するして変数を初期化する
    if daynumber == 6
      puts "\n"
      daynumber = 0
    else
      daynumber += 1
    end

    count += 1
  end
  # 最後に改行することで % 表示しないようにする
  # calコマンドでも1行空行がある
  puts "\n"
end

# 入力された引数をチェックして、trueならカレンダーを表示する
if year_month_switcher
  calendar
else
  return
end
