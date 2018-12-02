#!/usr/bin/env ruby

require_relative '../../file_utils'

class P1 include FileUtils

    def sol()
        data = read_all('p-input.txt')

        f = 0
        
        data.each do |fc|
            f += fc.to_i
            puts "fc = #{fc.to_i}, f = #{f}"
        end

        f
    end
end

r = P1.new.sol()
puts r
