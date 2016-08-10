#!/usr/bin/env ruby

require_relative "lib/optparser"
require_relative "lib/downloader"

options = BingWallpaperDownloader::OptParser.new(__FILE__).parse(ARGV)
results = BingWallpaperDownloader::Downloader.new(
  options[:destination], 
  options[:locale], 
  options[:resolution],
  options[:total]
).download

if results.any?
  puts "Success: Downloaded #{results.length} Bing wallpapers"
  results.each { |image| puts " - #{image}" }
else
  abort "Error: Could not download Bing wallpapers"
end
