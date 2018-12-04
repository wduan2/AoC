#!/usr/bin/env ruby

require_relative '../../file_utils'

class P12 include FileUtils

    def sol()
        grid = {}
        overlap_cells = 0
        isolated_candidates = {}

        read_proc('p-input.txt') do |p|
            x, y, w, h, id = ext(p)
            
            has_overlap = false

            (x...x + h).each do |i|
                (y...y + w).each do |j|
                    grid[i] = {} unless grid.has_key?(i)
                    if grid[i].has_key?(j)
                        has_overlap = true
                        grid[i][j][:visited] += 1
                        grid[i][j][:visitors].each { |k, _| isolated_candidates.delete(k) }
                    else
                        grid[i][j] = { :visited => 1, :visitors => { id => 1 } }
                    end

                    if grid[i][j][:visited] == 2
                        overlap_cells += 1
                        puts "(#{x},#{y}) (#{w}x#{h}) => (#{i},#{j}), overlap: #{overlap_cells}"
                    end
                end
            end

            isolated_candidates[id] = 1 unless has_overlap
        end

        isolated_id, _ = isolated_candidates.first

        puts isolated_candidates

        [overlap_cells, isolated_id]
    end

    def ext(p)
        raw_parts = p.split(' ')
        raw_id = raw_parts[0]
        raw_coords = raw_parts[2].gsub(':', '')
        raw_size = raw_parts[3]

        id = raw_id.gsub('#', '')
        y, x = raw_coords.split(',')
        w, h = raw_size.split('x')

        [x.to_i, y.to_i, w.to_i, h.to_i, id]
    end
end

puts P12.new.sol()
