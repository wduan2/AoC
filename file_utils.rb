module FileUtils
  def read_all(fpath)
    data = []
    File.open(fpath, 'r') do |f|
      f.each_line do |fc|
        data << fc
      end
    end

    data
  end
end
