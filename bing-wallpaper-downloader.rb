require "optparse"
require "fileutils"
require "uri"
require "net/http"
require "json"
require "open-uri"

# Bing JSON API: http://stackoverflow.com/questions/10639914/is-there-a-way-to-get-bings-photo-of-the-day

options              = {}
options[:market]     = "en-US"
options[:resolution] = "1920x1080"
options[:directory]  = "#{ENV['HOME']}/Pictures/Bing Wallpapers"

OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  opts.on("-m", "--market [MARKET]", "The locale to use when looking for an image. Default: #{options[:market]}") do |market|
    options[:market] = market
  end

  opts.on("-r", "--resolution [RESOLUTION]", "The resolution of image to fetch. Default: #{options[:resolution]}") do |resolution|
    options[:resolution] = resolution
  end

  opts.on("-d", "--directory [DIRECTORY]", "The directory to save the wallpapers to. Default: #{options[:directory]}") do |directory|
    options[:directory] = directory
  end  
end.parse!

unless /^[a-z]{2}\-[A-Z]{2}$/.match(options[:market])
  raise OptionParser::InvalidArgument, "market: #{options[:market]}" 
end

unless /^\d+x\d+$/.match(options[:resolution])
  raise OptionParser::InvalidArgument, "resolution: #{options[:resolution]}" 
end 

unless FileUtils.mkdir_p(options[:directory]) && Dir.exists?(options[:directory])
 raise OptionParser::InvalidArgument, "directory: #{options[:directory]}" 
end

bing_json_url = URI::HTTP.build(
  :host  => "www.bing.com", 
  :path  => "/HPImageArchive.aspx",
  :query => URI.encode_www_form({:format => "js", :idx => 0, :n => 1, :mkt => options[:market]})
)

def get_latest_image(url, resolution)
  json  = JSON.parse(Net::HTTP.get(url))
  image = json["images"][0]
  abort "Could not get today's Bing image" unless image

  url = URI::HTTP.build(
    :host => "www.bing.com", 
    :path => image["url"].sub("1920x1080", resolution)
  )

  date = image["startdate"]
  date = "#{date[0..3]}-#{date[4..5]}-#{date[6..7]}"

  [url, date]
end

def download_image(source, destination)
  download = open(source)
  if download.meta["content-type"] != "image/jpeg" || download.meta["content-length"].to_i == 0
    raise "Error: Unable to download latest Bing image" 
  end

  bytes = IO.copy_stream(download, destination)
  if bytes != download.meta["content-length"].to_i
    raise "Error: Unable to download latest Bing image" 
  end
end

image_url, date = get_latest_image(bing_json_url, options[:resolution])
target = File.join(options[:directory], date + ".jpg")
download_image(image_url, target)

puts "Success: Downloaded latest Bing image to #{target}"