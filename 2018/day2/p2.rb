#!/usr/bin/env ruby

require_relative '../../file_utils'

class P2 include FileUtils

    def sol()
        box_ids = read_all('p-input.txt')
        (0...box_ids.size - 1).each do |i|
            fs = box_ids[i].strip
            (i + 1...box_ids.size).each do |j|
                ss = box_ids[j].strip
                comm_str = diff_01?(fs, ss)
                return comm_str if comm_str
            end
        end
    end

    def diff_01?(fs, ss)
        puts "comparing #{fs} and #{ss}"
        comm = []
        diff_at = []
        return comm if fs.size != ss.size
        (0...fs.size).each do |i|
            if fs[i] != ss[i]
                diff_at << i
                return nil if diff_at.size > 1
                next
            end

            comm << fs[i]
        end
        comm_str = comm.join()
        puts "found #{fs} and #{ss}, comm str: #{comm_str}, diff_at: #{diff_at}"
        comm_str
    end
end

puts P2.new.sol()
