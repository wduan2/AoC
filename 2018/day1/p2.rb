#!/usr/bin/env ruby

require_relative '../../file_utils'

class P2 include FileUtils

    def sol()
        data = read_all('p-input.txt')
        ft = { 0 => 1 }
        f = 0

        sol_w(data, ft, f)
    end

    def sol_w(data, ft, f)
        puts "f = #{f}"
        data.each do |fc|
            f += fc.to_i
            return f if ft.has_key?(f)
            ft[f] = 1
            puts "fc = #{fc.to_i}, f = #{f}"
        end

        sol_w(data, ft, f)
    end
end

r = P2.new.sol()
puts r
