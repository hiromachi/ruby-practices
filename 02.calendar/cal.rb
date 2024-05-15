#!/usr/bin/env ruby
require 'optparse'
require "date"

# 年月を取得する
def year_month_switcher()
  options = {}
  OptionParser.new do |opt|
    opt.on('-y VALUE') { |v| @target_year = options[:year] = v }
    opt.on('-m VALUE') { |v| @target_month = options[:month] = v }
  end.parse!(ARGV)

  if @target_year.nil?
    @target_year_and_month = Date.new(Date.today.year, Date.today.month)
  elsif @target_year.to_i >= 1970 && @target_year.to_i <= 2100
    @target_year_and_month = Date.new(@target_year.to_i, Date.today.month)
  else
    puts "年は1970〜2100までの数字で入力してください"
    return false
  end

  if @target_month.nil?
    @target_year_and_month = Date.new(@target_year_and_month.year, Date.today.month)
  elsif @target_month.to_i >= 1 && @target_month.to_i <= 12
    @target_year_and_month = Date.new(@target_year_and_month.year, @target_month.to_i)
  else
    puts "月は1〜12までの数字で入力してください"
    return false
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
calendar if year_month_switcher
