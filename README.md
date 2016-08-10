# Bing Wallpaper Downloader
A simple script to download Bing's daily background images.

# Usage
You can run the script with the following command:

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing
```

You can specify the locale with the `locale` argument:

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing --locale=en-GB
```

You can get previous images with `total` argument, where the value is the number of days back to go: 

```
ruby bing-wallpaper-downloader.rb --destination=$HOME/Pictures/Bing --total=5
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
- Write some unit tests for the new class.
- Change the script to a bash script with `#!/usr/bin/env ruby` that runs opt parsing and then passes to class.
- Check destination folder is writable.
