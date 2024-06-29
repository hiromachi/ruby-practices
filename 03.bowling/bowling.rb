# frozen_string_literal: true

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

def calc_point(frames)
  point = 0

  frames.each_with_index do |frame, index|
    # 1〜8フレーム目の計算
    if index < 9
      # ストライクなら次の2投の点を加算する
      if frame == [10, 0]
        # 次もストライクならフレームではなく投球数分で加算する
        if frames[index + 1] == [10, 0]
          point += 10 + frames[index + 1][0] + frames[index + 2][0]
        else
          point += 10 + frames[index + 1][0] + frames[index + 1][1]
        end
      # スペアなら次の1投の点を加算する
      elsif frame.sum == 10 && frame[0] != 10
        # 次がストライクなら10点加算
        point += 10 + frames[index + 1][0]
      else
        # それ以外はそのフレームの点を加算する
        point += frame.sum
      end
      puts "フレーム数: #{index + 1}"
      puts "1投目のスコア: #{frame[0]}"
      puts "2投目のスコア: #{frame[1]}"
      puts "frame: #{frame}"
      puts "point: #{point}"
    end

    # 10フレーム目の計算
    next unless index == 9
    point += frame.sum
  end

  point
end

shots = convert_shots(ARGV[0])
frames = separate_frames(shots)
point = calc_point(frames)
puts point
