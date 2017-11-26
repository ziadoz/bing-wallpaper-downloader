# Bing Wallpaper Downloader
A simple script to download Bing's daily background images.

# Requirements
- Ruby 2.3.1

# Usage
You can run the script with the following command:

```
./bing-wallpaper-download --destination=~/Pictures/Bing
```

You can specify the locale with the `locale` argument:

```
./bing-wallpaper-download --destination=~/Pictures/Bing --locale=en-GB
```

You can get previous images with `total` argument, where the value is the number of days back to go:

```
./bing-wallpaper-download --destination=~/Pictures/Bing --total=5
```

You can specify the resolution image you want using the `resolution` argument:

```
./bing-wallpaper-download --destination=~/Pictures/Bing --resolution=1920x1080
```

For help use the help flag:

```
./bing-wallpaper-download -h
```

```
$ ./bing-wallpaper-downloader.sh --destination=~/Pictures/Bing/ --total=5
Success: Downloaded 5 Bing wallpapers
 - /Users/Arthur/Pictures/Bing/2016-08-10.jpg
 - /Users/Arthur/Pictures/Bing/2016-08-09.jpg
 - /Users/Arthur/Pictures/Bing/2016-08-08.jpg
 - /Users/Arthur/Pictures/Bing/2016-08-07.jpg
 - /Users/Arthur/Pictures/Bing/2016-08-06.jpg
 ```
