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