# FeedTorrents

[![Gem Version](https://badge.fury.io/rb/feed_torrents.svg)](http://badge.fury.io/rb/feed_torrents)

## Install

Install with Rubygems:

    gem install feed_torrents

## Usage

Create a configuration file: /tmp/feed_torrents.yml
```yaml
log:
  :out: STDOUT # or some file path
  :rotate: 5
  :size: 1048576 # 1MB
  :level: DEBUG
  :format: '%Y-%m-%d %H:%M:%S'

datastore: /tmp/feed_torrents.store

# Default configuration items for a feed
default_feed: &default_feed
  :enabled: true
  :interval: 900 # 900 seconds is 15 minutes
  :timeout: 30
  :directory: /tmp/incoming_torrents
  :regex_filters:
    - '.*'

# Interval is in seconds
feeds:
  showrss:
    <<: *default_feed
    :url: 'http://showrss.info/rss.php?user_id=0000'
    :interval: 900
    :enabled: true

  nyaa:
    <<: *default_feed
    :url: 'http://www.nyaa.se/?page=rss&cats=1_37'
    :interval: 1800
    :enabled: true
    :regex_filters:
      - 'HorribleSubs.*Fairy Tail S2 .*720p'
      - 'HorribleSubs.*Magic Kaito .*1080p'
      - '\[DeadFish\]'
```

Now simply start the application:
```bash
feed_torrents /tmp/feed_torrents.yml
I, [2015-01-10T20:32:24.171075 #21457]  INFO -- : FeedTorrents::Reactor#initialize: Initialize new Reactor version 0.1.0
I, [2015-01-10T20:32:24.171184 #21457]  INFO -- : FeedTorrents::Reactor#start: Starting eventmachine loop
I, [2015-01-10T20:32:24.171450 #21457]  INFO -- : FeedTorrents::Feed::List#initialize: showrss (enabled: true interval: 900 link: http://showrss.info/rss.php?user_id=0000)
I, [2015-01-10T20:32:24.171484 #21457]  INFO -- : FeedTorrents::Feed::List#initialize: nyaa (enabled: true interval: 1800 link: http://www.nyaa.se/?page=rss&cats=1_37)
I, [2015-01-10T20:32:24.171540 #21457]  INFO -- : FeedTorrents::Feed::List#download_new_items: feed showrss
I, [2015-01-10T20:32:24.182937 #21457]  INFO -- : FeedTorrents::Feed::List#download_new_items: feed nyaa
I, [2015-01-10T20:32:24.321911 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: American Horror Story 4x11 Magical Thinking 720p
I, [2015-01-10T20:32:24.322063 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'American Horror Story 4x11 Magical Thinking 720p' (http://reflektor.karmorra.info/torrent/54D7C99225897595AF1E4F85B5B317FEEF0119C5.torrent)
I, [2015-01-10T20:32:24.352748 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: American Horror Story 4x10 Orphans 720p
I, [2015-01-10T20:32:24.352990 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'American Horror Story 4x10 Orphans 720p' (http://reflektor.karmorra.info/torrent/CA85592A0850E361AC0840ED510A036FA2A1828C.torrent)
I, [2015-01-10T20:32:24.971696 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Tokyo Ghoul √A - 01 [720p][AAC].mp4
I, [2015-01-10T20:32:24.971757 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Tokyo Ghoul √A - 01 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=643972)
I, [2015-01-10T20:32:24.987967 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [HorribleSubs] Magic Kaito 1412 - 06 [1080p].mkv
I, [2015-01-10T20:32:24.988158 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[HorribleSubs] Magic Kaito 1412 - 06 [1080p].mkv' (http://www.nyaa.se/?page=download&tid=643846)
I, [2015-01-10T20:32:25.003946 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [HorribleSubs] Magic Kaito 1412 - 05 [1080p].mkv
I, [2015-01-10T20:32:25.004167 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[HorribleSubs] Magic Kaito 1412 - 05 [1080p].mkv' (http://www.nyaa.se/?page=download&tid=643845)
I, [2015-01-10T20:32:25.019271 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [HorribleSubs] Magic Kaito 1412 - 13 [1080p].mkv
I, [2015-01-10T20:32:25.019460 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[HorribleSubs] Magic Kaito 1412 - 13 [1080p].mkv' (http://www.nyaa.se/?page=download&tid=643830)
I, [2015-01-10T20:32:25.032232 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [HorribleSubs] Magic Kaito 1412 - 12 [1080p].mkv
I, [2015-01-10T20:32:25.032379 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[HorribleSubs] Magic Kaito 1412 - 12 [1080p].mkv' (http://www.nyaa.se/?page=download&tid=643758)
I, [2015-01-10T20:32:25.047954 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Beast Saga - 23 [720p][AAC].mp4
I, [2015-01-10T20:32:25.048285 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Beast Saga - 23 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=643723)
I, [2015-01-10T20:32:25.061514 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Fairy Tail &#40;2014&#41; - 40 [720p][AAC].mp4
I, [2015-01-10T20:32:25.061733 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Fairy Tail &#40;2014&#41; - 40 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=643722)
I, [2015-01-10T20:32:25.094340 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [HorribleSubs] Fairy Tail S2 - 40 [720p].mkv
I, [2015-01-10T20:32:25.094561 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[HorribleSubs] Fairy Tail S2 - 40 [720p].mkv' (http://www.nyaa.se/?page=download&tid=643668)
I, [2015-01-10T20:32:25.108556 #21457]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Military! - 01v2 [720p][AAC].mp4
I, [2015-01-10T20:32:25.108750 #21457]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Military! - 01v2 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=643646)
I, [2015-01-10T20:32:25.275709 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for American Horror Story 4x10 Orphans 720p completed
I, [2015-01-10T20:32:25.289581 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Beast Saga - 23 [720p][AAC].mp4 completed
I, [2015-01-10T20:32:25.337757 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Military! - 01v2 [720p][AAC].mp4 completed
I, [2015-01-10T20:32:25.345284 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Tokyo Ghoul √A - 01 [720p][AAC].mp4 completed
I, [2015-01-10T20:32:25.394842 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Fairy Tail &#40;2014&#41; - 40 [720p][AAC].mp4 completed
I, [2015-01-10T20:32:25.413424 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [HorribleSubs] Fairy Tail S2 - 40 [720p].mkv completed
I, [2015-01-10T20:32:25.441256 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [HorribleSubs] Magic Kaito 1412 - 06 [1080p].mkv completed
I, [2015-01-10T20:32:25.445882 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [HorribleSubs] Magic Kaito 1412 - 13 [1080p].mkv completed
I, [2015-01-10T20:32:25.468350 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [HorribleSubs] Magic Kaito 1412 - 05 [1080p].mkv completed
I, [2015-01-10T20:32:25.475861 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [HorribleSubs] Magic Kaito 1412 - 12 [1080p].mkv completed
I, [2015-01-10T20:32:30.767287 #21457]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for American Horror Story 4x11 Magical Thinking 720p completed
```

My qbittorrent-nox headless torrent client with webui loves this!

## Upstart script

Tested this on my ubuntu-14.04 server.
Put these contents in /etc/init/feed_torrents.conf:
```bash
start on (started networking)
stop on runlevel [!023456]

setuid tom
setgid tom

exec /usr/local/bin/feed_torrents /tmp/feed_torrents.yml
```

And start it

```bash
sudo start feed_torrents
```

## Issues

If you have found a bug then please raise an issue here on github.

## Authors

- [Tom van Leeuwen](http://github.com/TvL2386) - Initial author.

## Copyright

Copyright (c) 2015 Tom van Leeuwen

See LICENSE.txt for details.