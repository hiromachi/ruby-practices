# frozen_string_literal: true
require 'pry'

# 全投球を受け取る
def convert_shots(result)
  # 1投毎に分割し、Xは10に変換する
  scores = result.split(',')
  shots = []
  scores.each do |s|
    shots.push s == 'X' ? 10 : s.to_i
  end

  shots
end

# フレーム毎に分割する
def separate_frames(shots)
  # ストライクなら2投目は0で良いので、その場合は[10, 0]とする
  frames = []
  shot_count = 0
  while frames.size < 9
    if shots[shot_count] == 10
      frames.push [10, 0]
      shot_count += 1
    else
      frames.push shots[shot_count..shot_count + 1]
      shot_count += 2
    end
  end

  # 10フレーム目
  frames.push shots[shot_count..shot_count + 2]

  p frames
  frames
end

# スペアのフレームの得点は次の1投の点を加算する。
#   例: 6 4 5 = 15
#   例: 6 4 10 = 20
# ストライクのフレームの得点は次の2投の点を加算する。
#   例: 10 5 2 = 17
#   例: 10 10 10 = 30
# 10フレーム目は1投目がストライクもしくは2投目がスペアだった場合、3投目が投げられる。

def calc_point(frames)
  point = 0

  frames.each_with_index do |frame, index|
    # 1〜8フレーム目の計算
    if index < 9
      # ストライクなら次の2投の点を加算する
      if frame[index] == [10, 0]
        # 次もストライクならそのまま20点加算
        point += if frames[index + 1] == [10, 0]
                   10 + frames[index + 1].sum
                 else
                   10 + frames[index + 1][0]
                 end
      end

      # スペアなら次の1投の点を加算する
      if frames[index].sum == 10 && frames[index][0] != 10
        # 次がストライクなら10点加算
        binding.pry
        point += 10 + frames[index + 1][0]
        puts "aaaaaa #{point}"
      end

      # それ以外はそのフレームの点を加算する
      point += frames[index].sum

      puts "frames: #{frames[index]}"
      puts "point: #{point}"
    end

    # 10フレーム目の計算
    next unless index == 9

    # 全投球ストライク
    point += if frames[index] == [10, 10, 10]
               30
             # 1投目がストライク or 1,2投目がスペア
             elsif frames[index][0] + frames[index][1] == 10 || frames[index][0] != 10
               10 + frames[index][2]
             else
               frames[index].sum
             end
      puts "frames: #{frames[index]}"
      puts "point: #{point}"
  end

  point
end

shots = convert_shots(ARGV[0])
frames = separate_frames(shots)
point = calc_point(frames)
puts point
