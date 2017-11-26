#!/usr/bin/env ruby

require_relative "lib/optparser"
require_relative "lib/downloader"

begin
  options = BingWallpaperDownloader::OptParser.new(__FILE__).parse(ARGV)

  downloader = BingWallpaperDownloader::Downloader.new(options[:destination], options[:locale], options[:resolution], options[:total])
  results    = downloader.download

  if results.any?
    puts "Success: Downloaded #{results.length} Bing wallpapers"
    results.each { |image| puts " - #{image}" }
  else
    abort "Error: Could not download Bing wallpapers"
  end
rescue OptionParser::MissingArgument => e
  abort e.message.sub("missing argument", "Missing Argument")
rescue OptionParser::InvalidArgument => e
  abort e.message.sub("invalid argument", "Invalid Argument")
rescue BingWallpaperDownloader::DownloaderError => e
  abort "Error: #{e.message}"
end
