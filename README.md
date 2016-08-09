# Bing Wallpaper Downloader
A simple script to download Bing's daily background images.

# Usage
You can run the script with the following command:

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing
```

You can specify a specific market (locale) with the `market` argument:

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing --market=en-GB
```

You can specify the resolution image you want using the `resolution` argument:

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing --resolution=1920x1080
```

For help use the help flag:

```
ruby bing-wallpaper-downloader.rb -h
```

## To Do
- Create a class that does the leg work: `BingWallpaperDownload.new(:locale => '', :destination => '')`
- Write some unit tests for the new class.
- Change the script to a bash script with `#!/usr/bin/env ruby` that runs opt parsing and then passes to class.
- Rename `:market` option to `:locale`.
- Build the URI using `URI.parse(string)` instead of building objects.
- Add ability to download multiple (adjust URL query parameters).
