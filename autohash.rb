Earthquake.init do
  FILEPATH ||= "#{ENV['HOME']}/.earthquake/autohash"

  command :autohash do
    File.delete FILEPATH if File.exists? FILEPATH
  end

  command :autohash do |m|
    hashtags = m[1].split("\s")
    File.open FILEPATH, 'w' do |f|
      f.puts hashtags
    end
  end

  command %r|^[^:\$].*| do |m|
    hash_str = ""
    if File.exists? FILEPATH
      File.open FILEPATH do |f|
        f.each_line do |l|
          l.chomp!
          hash_str += " ##{l}"
        end
      end
    end
    input(":update #{m[0]}#{hash_str}")
  end
end
