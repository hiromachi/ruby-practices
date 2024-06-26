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
  # ストライクなら2投目は0で良いので、1投目だけをフレームに追加する
  frames = []
  shot_count = 0
  while frames.size < 10 && shot_count < shots.size
    if shots[shot_count] == 10
      frames << [shots[shot_count]]
      shot_count += 1
    else
      # frames << [shots[shot_count], shots[shot_count + 1]]
      frames << shots[shot_count..shot_count + 1]
      shot_count += 2
    end
  end

  # 最後のフレームの追加投球を含む場合、全ての投球をフレームに追加
  frames[-1] += shots[shot_count..-1] if frames.size == 10 && shot_count < shots.size

  frames
end

def calc_point(frames)
  point = 0
  frames.each_with_index do |frame, index|
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
            # 次のフレームの2投目を加算
            point += frames[index + 1][1]
          # 次のフレームがストライクの場合
          elsif frames[index + 2] != nil
            # 次のフレームの1投目を加算
            point += frames[index + 2][0]
          end
        end
      # スペアの場合
      elsif frame.sum == 10
        point += 10
        # 次のフレームの1投目を加算
        point += frames[index + 1][0] if frames[index + 1] != nil
      # ストライクでもスペアでもない場合
      else
        point += frame.sum
      end
    # 10フレーム目の計算
    else
      point += frame.sum
    end
  end

  point
end

shots = convert_shots(ARGV[0])
frames = separate_frames(shots)
point = calc_point(frames)
puts point
