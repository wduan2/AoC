module FileUtils
  def read_all(fpath)
    data = []
    File.open(fpath, 'r') do |f|
      f.each_line do |d|
        data << d
      end
    end

    data
  end

  def read_proc(fpath)
    File.open(fpath, 'r') do |f|
      f.each_line do |d|
        yield(d)
      end
    end
  end
end
