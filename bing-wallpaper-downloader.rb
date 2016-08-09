require "optparse"
require_relative "lib/bing_wallpaper_downloader"

options = {
  :locale      => "en-US",
  :resolution  => "1920x1080",
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  opts.on("-d", "--destination DESTINATION", "The directory to save the wallpapers to.") do |directory|
    options[:destination] = directory
  end

  opts.on("-r", "--resolution [RESOLUTION]", "The resolution of image to fetch. Default: #{options[:resolution]}") do |resolution|
    options[:resolution] = resolution
  end

  opts.on("-l", "--locale [LOCALE]", "The locale to use when looking for an image. Default: #{options[:locale]}") do |locale|
    options[:locale] = locale
  end
end.parse!

raise OptionParser::MissingArgument, "destination" if options[:destination].nil?

unless FileUtils.mkdir_p(options[:destination]) && Dir.exists?(options[:destination])
 raise OptionParser::InvalidArgument, "destination: #{options[:destination]}"
end

unless /^\d+x\d+$/.match(options[:resolution])
  raise OptionParser::InvalidArgument, "resolution: #{options[:resolution]}"
end

unless /^[a-z]{2}\-[A-Z]{2}$/.match(options[:locale])
  raise OptionParser::InvalidArgument, "locale: #{options[:locale]}"
end

results = BingWallpaperDownloader.new(options[:destination], options[:locale], options[:resolution]).download

if results.any?
  puts "Success: download #{results.length} Bing wallpapers"
  results.each { |image| puts " - #{image}" }
else
  abort "Error: Could not download Bing wallpapers"
end
