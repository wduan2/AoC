#!/usr/bin/env ruby

require_relative '../../file_utils'

class P1 include FileUtils

    def sol()
        stat = { 2 => 0, 3 => 0 }
        read_proc('p-input.txt') do |box_id|
            tmp_stat = {}
            box_id.each_char do |c|
                if tmp_stat.has_key?(c)
                    tmp_stat[c] += 1 
                else
                    tmp_stat[c] = 1
                end
            end

            puts "box_id: #{box_id}, tmp_stat: #{tmp_stat}"

            found_2 = false
            found_3 = false
            tmp_stat.each do |k, v|
                if v == 2 && found_2 == false
                    stat[2] += 1
                    found_2 = true
                end

                if v == 3 && found_3 == false
                    stat[3] += 1 
                    found_3 = true
                end
            end
        end

        puts "stat: #{stat}"
        stat[2] * stat[3]
    end
end

puts P1.new.sol()
