class HashTagsManager
  FILEPATH ||= "#{ENV['HOME']}/.earthquake/autohash"

  def save(hashtags)
    File.open FILEPATH, 'w' do |f|
      f.puts hashtags
    end
  end

  def get
    hash_str = ""
    if File.exists? FILEPATH
      File.open FILEPATH do |f|
        f.each_line do |l|
          l.chomp!
          hash_str += " ##{l}"
        end
      end
    end
    hash_str
  end

  def reset
    File.delete FILEPATH if File.exists? FILEPATH
  end
end

if Object.const_defined? :Earthquake
  Earthquake.init do
    h = HashTagsManager.new

    command :autohash do
      h.reset
    end

    command :autohash do |m|
      h.save m[1].split("\s")
    end

    command %r|^[^:\$].*| do |m|
      input(":update #{m[0]}#{h.get}")
    end
  end
end
