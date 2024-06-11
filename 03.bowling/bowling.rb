require 'pry'

# 全投球を受け取る
def convert_shots(result)
  # 1投毎に分割し、Xは10に変換する
  scores = result.split(',')
  shots = []
  scores.each do |s|
    if s == 'X'
      shots << 10
    else
      shots << s.to_i
    end
  end

  puts "===全投球を受け取りました！==="
  puts "shots: #{shots}"
  puts

  return shots
end

# フレーム毎に分割する
def separate_frames(shots)
  # ストライクなら2投目は0で良いので、1投目だけをフレームに追加する
  frames = []
  shot_count = 0
  while frames.size < 10 && shot_count < shots.size
    if shots[shot_count] == 10
      frames << [shots[shot_count]]
      shot_count += 1
    else
      frames << [shots[shot_count], shots[shot_count + 1]]
      shot_count += 2
    end
  end

  # 最後のフレームの追加投球を含む場合、全ての投球をフレームに追加
  if frames.size == 10 && shot_count < shots.size
    frames[-1] += shots[shot_count..-1]
  end

  puts "===フレーム毎に区切ります！==="
  puts "フレーム毎の投球結果：#{frames}"
  puts

  return frames
end

def calc_point(frames)
  point = 0
  frames.each_with_index do |frame, index|
    puts "frame: #{frame}"
    # 1〜9フレーム目以外の計算
    if index < 9
      # ストライクの場合
      if frame[0] == 10
        point += 10
        # 次のフレームが存在する場合
        if frames[index + 1] != nil
          # 次のフレームの1投目を加算
          point += frames[index + 1][0]
          # 次のフレームがストライクでない場合
          if frames[index + 1][1] != nil
            puts "aaaaaaa"
            puts
            # 次のフレームの2投目を加算
            point += frames[index + 1][1]
          # 次のフレームがストライクの場合
          elsif frames[index + 2] != nil
            puts "bbbbbbb"
            puts
            # 次のフレームの1投目を加算
            point += frames[index + 2][0]
          end
        end
      # スペアの場合
      elsif frame.sum == 10
        point += 10
        # 次のフレームの1投目を加算
        if frames[index + 1] != nil
          puts "ccccccc"
          puts
          point += frames[index + 1][0]
        end
      # ストライクでもスペアでもない場合
      else
        puts "ddddddd"
        puts
        point += frame.sum
      end
    # 10フレーム目の計算
    else
      puts "eeeeeee"
      puts
      point += frame.sum
    end

    puts "point: #{point}"
  end

  puts "===結果計算はこちらです！==="
  puts "合計得点：#{point}"
  puts

  return point
end

shots = convert_shots(ARGV[0])
frames = separate_frames(shots)
point = calc_point(frames)
puts "===結果==="
puts point
