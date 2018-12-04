#!/usr/bin/env ruby

require 'date'
require_relative '../../file_utils'

class P12 include FileUtils

    def sol()
        date_records = {}
        read_proc('p-input.txt') do |r|
            date, min, act, guard_id = ext(r)
            date_records[date] = { :timeline => ['.'] * 60 } unless date_records.has_key?(date)
            date_records[date][:guard_id] = guard_id if guard_id
            date_records[date][:timeline][min] = 'w' if act == 'wakes up'
            date_records[date][:timeline][min] = 'f' if act == 'falls asleep'
        end

        most_sleepy = { :max_sleep => 0, :guard_id => nil }
        most_frequent_sleepy = { :sleep_count => 0, :sleep_at => nil, :guard_id => nil }
        guard_records = {}
        date_records.each do |_, date_record|
            guard_id = date_record[:guard_id]
            guard_records[guard_id] = { :mintue_sleep => [0] * 60, :total_sleep => 0 } unless guard_records.has_key?(guard_id)

            min = 0
            while min < 60
                while min < 60 && date_record[:timeline][min] != 'f'
                    min += 1
                end

                while min < 60 && date_record[:timeline][min] != 'w'
                    guard_records[guard_id][:mintue_sleep][min] += 1
                    guard_records[guard_id][:total_sleep] += 1

                    if most_sleepy[:max_sleep] < guard_records[guard_id][:total_sleep]
                        most_sleepy[:guard_id] = guard_id
                        most_sleepy[:max_sleep] = guard_records[guard_id][:total_sleep]
                    end

                    if most_frequent_sleepy[:sleep_count] < guard_records[guard_id][:mintue_sleep][min]
                        most_frequent_sleepy[:guard_id] = guard_id
                        most_frequent_sleepy[:sleep_at] = min
                        most_frequent_sleepy[:sleep_count] = guard_records[guard_id][:mintue_sleep][min]
                    end

                    min += 1
                end
            end
        end

        most_sleepy_guard = most_sleepy[:guard_id]
        most_sleepy_minute = 0
        most_sleepy_minute_len = 0
        min = 0
        while min < guard_records[most_sleepy_guard][:mintue_sleep].size
            if most_sleepy_minute_len < guard_records[most_sleepy_guard][:mintue_sleep][min]
                most_sleepy_minute = min
                most_sleepy_minute_len = guard_records[most_sleepy_guard][:mintue_sleep][min]
            end
            min += 1
        end

        [most_sleepy_minute * most_sleepy_guard, most_frequent_sleepy[:sleep_at] * most_frequent_sleepy[:guard_id]]
    end

    def ext(r)
        date_n_act = r.split(']')
        raw_date = date_n_act[0]
        raw_act = date_n_act[1]

        date_n_time = raw_date.gsub('[', '').split(' ')
        date = date_n_time[0]
        time = date_n_time[1]

        h_n_m = time.split(':')
        min = h_n_m[1].to_i

        # 7-31 23:56 ==> 8-1 00:00
        if h_n_m[0].to_i > 0
            date_o = Date.parse(date)
            date_o = date_o.next_day
            date = date_o.strftime('%Y-%m-%d')
            min = 0
        end

        act = raw_act.strip
        guard_id = act.scan(/[0-9]+/).first
        guard_id = guard_id.to_i if guard_id

        [date, min, act, guard_id]
    end
end

puts P12.new.sol()
