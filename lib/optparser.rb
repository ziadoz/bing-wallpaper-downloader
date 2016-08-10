require "optparse"

module BingWallpaperDownloader
  class OptParser
    def parse(args)
      options = parse_args(args)
      validate_options(options)
      options
    end

    private

    def parse_args(args)
      options = {
        :locale      => "en-US",
        :resolution  => "1920x1080",
      }

      OptionParser.new do |opts|
        opts.banner = "Usage: #{__FILE__} [options]"

        opts.on("-d", "--destination DESTINATION", "The directory to save the wallpapers to.") do |directory|
          options[:destination] = directory
        end

        opts.on("-l", "--locale [LOCALE]", "The locale to use when looking for an image. Default: #{options[:locale]}") do |locale|
          options[:locale] = locale
        end

        opts.on("-r", "--resolution [RESOLUTION]", "The resolution of image to fetch. Default: #{options[:resolution]}") do |resolution|
          options[:resolution] = resolution
        end        
      end.parse(args)

      options
    end

    def validate_options(options)
      raise OptionParser::MissingArgument, "destination" if options[:destination].nil?

      unless FileUtils.mkdir_p(options[:destination]) && Dir.exists?(options[:destination])
       raise OptionParser::InvalidArgument, "destination: #{options[:destination]}"
      end

      unless /^[a-z]{2}\-[A-Z]{2}$/.match(options[:locale])
        raise OptionParser::InvalidArgument, "locale: #{options[:locale]}"
      end

      unless /^\d+x\d+$/.match(options[:resolution])
        raise OptionParser::InvalidArgument, "resolution: #{options[:resolution]}"
      end
    end
  end
end
