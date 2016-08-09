require "fileutils"
require "uri"
require "net/http"
require "json"
require "open-uri"

class BingWallpaperDownloader
  attr_reader :destination, :locale, :resolution, :total

  def initialize(destination, locale, resolution, total = 1)
      @destination = destination
      @locale      = locale
      @resolution  = resolution
      @total       = total
  end

  def download
    download_images(parse_image_json)
  end

  private

  # Bing JSON API: http://stackoverflow.com/questions/10639914/is-there-a-way-to-get-bings-photo-of-the-day
  def get_bing_json_url
    URI::HTTP.build(
      :host  => "www.bing.com",
      :path  => "/HPImageArchive.aspx",
      :query => URI.encode_www_form({
        :format => "js",
        :idx    => 0,
        :n      => @total,
        :mkt    => @locale
      })
    )
  end

  def parse_image_json
    json        = JSON.parse(Net::HTTP.get(get_bing_json_url))
    images_json = json["images"]

    unless images_json.any?
      raise "Could not get image JSON from Bing"
    end

    images_json.collect do |image|
        date = image["startdate"]
        date = "#{date[0..3]}-#{date[4..5]}-#{date[6..7]}"

        {:url => URI.parse("http://www.bing.com" + image["url"]), :date => date}
    end
  end

  def download_images(images)
    images.collect do |image|
      download = open(image[:url])
      if download.meta["content-type"] != "image/jpeg" || download.meta["content-length"].to_i == 0
        raise "Error: Unable to download latest Bing image"
      end

      target = File.join(destination, image[:date] + ".jpg")
      bytes  = IO.copy_stream(download, target)
      if bytes != download.meta["content-length"].to_i
        raise "Error: Unable to download latest Bing image"
      end

      target
    end
  end
end
