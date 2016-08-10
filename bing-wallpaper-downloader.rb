require_relative "lib/optparser"
require_relative "lib/downloader"

options = BingWallpaperDownloader::OptParser.new.parse(ARGV)
results = BingWallpaperDownloader::Downloader.new(options[:destination], options[:locale], options[:resolution]).download

if results.any?
  puts "Success: download #{results.length} Bing wallpapers"
  results.each { |image| puts " - #{image}" }
else
  abort "Error: Could not download Bing wallpapers"
end
