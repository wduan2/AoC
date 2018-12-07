#!/usr/bin/env ruby

require_relative '../../file_utils'

class P12 include FileUtils

    def sol(safe_distance = 10000)
        points = read_all('p-input.txt')
        coords = points.map { |point| point.chomp.gsub(' ', '').split(',').map { |s| s.to_i } }
        
        coords_xs = coords.sort { |c1, c2| c1[0] <=> c2[0] }
        coords_ys = coords.sort { |c1, c2| c1[1] <=> c2[1] }

        minX = coords_xs.first[0]
        maxX = coords_xs.last[0]
        minY = coords_ys.first[1]
        maxY = coords_ys.last[1]

        puts "minX = #{minX}, minY = #{minY}, maxX = #{maxX}, maxY = #{maxY}, total #{coords.size} coords"

        distance_tracker = {}
        infinite_c = {}
        safe_c = 0

        (minX..maxX).each do |x|
            (minY..maxY).each do |y|
                min_dis = -1
                min_dis_c = []
                dis_sum = 0
                coords.each do |c|
                    dis = manhattan_dis([x, y], c)
                    dis_sum += dis
                    if min_dis == -1 || min_dis > dis
                        min_dis = dis
                        min_dis_c = [c]
                    elsif min_dis == dis
                        min_dis_c << c
                    end
                end
                
                safe_c += 1 if dis_sum < safe_distance

                next if min_dis_c.size > 1

                k = min_dis_c.first.join(',')
                infinite_c[k] = 1 if x == minX || x == maxX || y == minY || y == maxY
                next if infinite_c.has_key?(k)

                distance_tracker[k] = 0 unless distance_tracker.has_key?(k)
                distance_tracker[k] += 1
            end
        end

        puts distance_tracker.sort_by { |k, v| v }
        puts safe_c
    end

    def manhattan_dis(c1, c2)
        (c1[0] - c2[0]).abs + (c1[1] - c2[1]).abs
    end
end

P12.new.sol()
