#!/usr/bin/env ruby

require_relative '../../file_utils'

class P12 include FileUtils

    def p1()
        polymers = read_all('p-input.txt')
        polymers = polymers.first

        fully_react(polymers)
    end

    def p2()
        polymers = read_all('p-input.txt')
        polymers = polymers.first

        min_len = -1
        ('a'..'z').each do |c|
            len = strip_fully_react(polymers, c)
            min_len = len if min_len == -1 || min_len > len
        end
        min_len
    end

    def strip_fully_react(polymers, downcase_char)
        striped = []
        polymers.each_char { |c| striped << c if c != downcase_char && c.downcase != downcase_char }
        fully_react(striped.join())
    end

    def fully_react(polymers)
        removed = 0
        prev = 0
        cur = prev + 1

        while prev < polymers.length - 1
            if is_opposite(polymers[prev], polymers[cur])
                polymers[prev] = '#'
                polymers[cur] = '#'

                if prev - 1 >= 0
                    # Ab[Cc]DEfg
                    # before: prev = C, cur = c
                    # A[b##D]Efg
                    # after:  prev = b, cur = D
                    prev -= 1
                    while polymers[prev] == '#' && prev > 0
                        prev -= 1
                    end

                    # everything before prev has been removed
                    if polymers[prev] == '#'
                        cur += 2
                        prev = cur - 1
                    else
                        cur += 1    
                    end
                else
                    # [Aa]CcDEfg
                    # before: prev = A, cur = a
                    # ##CcDEfg
                    # after:  prev = C, cur = c
                    cur += 2
                    perv = cur - 1
                end

                removed += 2
            else
                prev += 1
                while polymers[prev] == '#'
                    prev += 1
                end
                cur = prev + 1
            end
            # puts "prev = #{prev}, cur = #{cur}"
        end

        # puts polymers
        
        polymers.length - removed
    end

    def is_opposite(c1, c2)
        return (c1.downcase == c2 && c1 == c2.upcase) || (c1.upcase == c2 && c1 == c2.downcase)
    end
end

# puts P12.new.p1()
puts P12.new.p2()
