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
  :size: 10485760 # 10MB
  :level: INFO
  :format: '%Y-%m-%d %H:%M:%S'

datastore: /tmp/feed_torrents.store

email:
  :enabled: true
  :to: john.doe@example.com
  :from: feed_torrents@example.com
  :delivery_method:
    :smtp: true
    :address: smtp.example.com
    :port: 25

# alternative methods, check: https://github.com/mikel/mail
#  :delivery_method:
#    :sendmail: true
#  :delivery_method:
#    :exim: true
#    :location: "/usr/bin/exim"

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

  tokyo_ghoul_s2:
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
$ bin/feed_torrents examples/config.yml
I, [2015-01-22T22:53:06.531022 #6424]  INFO -- : FeedTorrents::Reactor#initialize: Initialize new Reactor version 0.2.0
I, [2015-01-22T22:53:06.531130 #6424]  INFO -- : FeedTorrents::Reactor#start: Starting eventmachine loop
I, [2015-01-22T22:53:06.531376 #6424]  INFO -- : FeedTorrents::Feed::List#initialize: showrss (enabled: true interval: 900 link: http://showrss.info/rss.php?user_id=0000)
I, [2015-01-22T22:53:06.531474 #6424]  INFO -- : FeedTorrents::Feed::List#initialize: tokyo_ghoul_s2 (enabled: true interval: 1800 link: http://www.nyaa.se/?page=rss&cats=1_37)
I, [2015-01-22T22:53:06.531568 #6424]  INFO -- : FeedTorrents::Feed::List#download_new_items: feed showrss
I, [2015-01-22T22:53:06.542897 #6424]  INFO -- : FeedTorrents::Feed::List#download_new_items: feed tokyo_ghoul_s2
I, [2015-01-22T22:53:06.687179 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: American Horror Story 4x13 Curtain Call 720p
I, [2015-01-22T22:53:06.687365 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'American Horror Story 4x13 Curtain Call 720p' (http://reflektor.karmorra.info/torrent/E7F50A63ADEE23241B79C2716F42F31C10F68DF7.torrent)
I, [2015-01-22T22:53:06.710212 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Criminal Minds 10x12 Anonymous 720p
I, [2015-01-22T22:53:06.710414 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Criminal Minds 10x12 Anonymous 720p' (http://reflektor.karmorra.info/torrent/87E02D33B7E2CEAF276088431B0E90A22ED39DEE.torrent)
I, [2015-01-22T22:53:06.721271 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Banshee 3x02 The Fire Trials 720p
I, [2015-01-22T22:53:06.721435 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Banshee 3x02 The Fire Trials 720p' (http://reflektor.karmorra.info/torrent/3FF2FB913F01EAA6D7BC1090942165A78547936F.torrent)
I, [2015-01-22T22:53:06.758742 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: American Horror Story 4x12 Show Stoppers 720p
I, [2015-01-22T22:53:06.758910 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'American Horror Story 4x12 Show Stoppers 720p' (http://reflektor.karmorra.info/torrent/1A116B745BEBFA3F3DD2F52905097C2A2ECEC525.torrent)
I, [2015-01-22T22:53:06.794403 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Modern Family 6x12 The Big Guns 720p REPACK
I, [2015-01-22T22:53:06.794646 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Modern Family 6x12 The Big Guns 720p REPACK' (http://reflektor.karmorra.info/torrent/1C4574B1AD6DC3388944262B54CBD652049AA3ED.torrent)
I, [2015-01-22T22:53:06.805547 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Criminal Minds 10x11 The Forever People 720p
I, [2015-01-22T22:53:06.805749 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Criminal Minds 10x11 The Forever People 720p' (http://reflektor.karmorra.info/torrent/5321CF7A773A7E611C1FB001D0D6F31988132E71.torrent)
I, [2015-01-22T22:53:06.816308 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Modern Family 6x12 The Big Guns 720p
I, [2015-01-22T22:53:06.816481 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Modern Family 6x12 The Big Guns 720p' (http://reflektor.karmorra.info/torrent/4BD097B6813575DE4D22C834B1C3710F3529A991.torrent)
I, [2015-01-22T22:53:06.826807 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Pretty Little Liars 5x15 Fresh Meat 720p
I, [2015-01-22T22:53:06.827014 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Pretty Little Liars 5x15 Fresh Meat 720p' (http://reflektor.karmorra.info/torrent/0C7C93C8787576C2B4C094C6183B2778EC910AFA.torrent)
I, [2015-01-22T22:53:06.838061 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Girls 4x01 Iowa 720p
I, [2015-01-22T22:53:06.838247 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Girls 4x01 Iowa 720p' (http://reflektor.karmorra.info/torrent/F993F4C5D9A7373D563F60AC4AC77CA9F53B0813.torrent)
I, [2015-01-22T22:53:06.848419 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Banshee 3x01 Snakes and Whatnot 720p
I, [2015-01-22T22:53:06.848557 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Banshee 3x01 Snakes and Whatnot 720p' (http://reflektor.karmorra.info/torrent/CC3A360BB69B64B74332A47E30B0E88B191BFE90.torrent)
I, [2015-01-22T22:53:06.858397 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Shameless (US) 5x01 Milk of the Gods 720p
I, [2015-01-22T22:53:06.858560 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Shameless (US) 5x01 Milk of the Gods 720p' (http://reflektor.karmorra.info/torrent/3D8D9408C4E3C5E030865998A1204F230AAA1F88.torrent)
I, [2015-01-22T22:53:06.871403 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: The Big Bang Theory 8x12 The Space Probe Disintegration 720p
I, [2015-01-22T22:53:06.871545 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'The Big Bang Theory 8x12 The Space Probe Disintegration 720p' (http://reflektor.karmorra.info/torrent/33E433D1DCF1B4688652DD347EB3EFE5EF37D976.torrent)
I, [2015-01-22T22:53:06.881819 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: American Horror Story 4x11 Magical Thinking 720p
I, [2015-01-22T22:53:06.881963 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'American Horror Story 4x11 Magical Thinking 720p' (http://reflektor.karmorra.info/torrent/54D7C99225897595AF1E4F85B5B317FEEF0119C5.torrent)
I, [2015-01-22T22:53:06.892960 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: Modern Family 6x11 The Day We Almost Died 720p
I, [2015-01-22T22:53:06.893158 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for 'Modern Family 6x11 The Day We Almost Died 720p' (http://reflektor.karmorra.info/torrent/E268F07BBDACDDBEA2E1EB960F22397E785658D2.torrent)
I, [2015-01-22T22:53:06.964191 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for American Horror Story 4x12 Show Stoppers 720p completed
I, [2015-01-22T22:53:06.965691 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent American Horror Story 4x12 Show Stoppers 720p"
I, [2015-01-22T22:53:07.759406 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Naruto Shippuuden - 396 [720p][AAC].mp4
I, [2015-01-22T22:53:07.759496 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Naruto Shippuuden - 396 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647909)
I, [2015-01-22T22:53:07.770160 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Saenai Heroine no Sodatekata - 01v2 [720p][AAC].mp4
I, [2015-01-22T22:53:07.770264 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Saenai Heroine no Sodatekata - 01v2 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647906)
I, [2015-01-22T22:53:07.781354 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Pri Para - 25 [720p][AAC].mp4
I, [2015-01-22T22:53:07.781460 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Pri Para - 25 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647762)
I, [2015-01-22T22:53:07.793017 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Aikatsu! 3 - 15 [720p][AAC].mp4
I, [2015-01-22T22:53:07.793111 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Aikatsu! 3 - 15 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647752)
I, [2015-01-22T22:53:07.803203 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Magic Kaito 1412 - 14 [720p][AAC].mp4
I, [2015-01-22T22:53:07.803273 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Magic Kaito 1412 - 14 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647746)
I, [2015-01-22T22:53:07.813816 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Lady Jewelpet - 40 [720p][AAC].mp4
I, [2015-01-22T22:53:07.813925 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Lady Jewelpet - 40 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647744)
I, [2015-01-22T22:53:07.825975 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Kantai Collection: KanColle - 03 [720p][AAC].mp4
I, [2015-01-22T22:53:07.826071 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Kantai Collection: KanColle - 03 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647736)
I, [2015-01-22T22:53:07.836936 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Shirobako - 14 [720p][AAC].mp4
I, [2015-01-22T22:53:07.837000 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Shirobako - 14 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647632)
I, [2015-01-22T22:53:07.847978 #6424]  INFO -- : FeedTorrents::Feed::List#process: Processing: [DeadFish] Military! - 03 [720p][AAC].mp4
I, [2015-01-22T22:53:07.848086 #6424]  INFO -- : FeedTorrents::Feed::Download#process: Downloading torrent for '[DeadFish] Military! - 03 [720p][AAC].mp4' (http://www.nyaa.se/?page=download&tid=647622)
I, [2015-01-22T22:53:07.858415 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Banshee 3x02 The Fire Trials 720p completed
I, [2015-01-22T22:53:07.858795 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Banshee 3x02 The Fire Trials 720p"
I, [2015-01-22T22:53:08.417662 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Shirobako - 14 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:08.418242 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Shirobako - 14 [720p][AAC].mp4"
I, [2015-01-22T22:53:08.787704 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Naruto Shippuuden - 396 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:08.788221 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Naruto Shippuuden - 396 [720p][AAC].mp4"
I, [2015-01-22T22:53:09.142041 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Saenai Heroine no Sodatekata - 01v2 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:09.142926 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Saenai Heroine no Sodatekata - 01v2 [720p][AAC].mp4"
I, [2015-01-22T22:53:09.534063 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Pri Para - 25 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:09.534611 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Pri Para - 25 [720p][AAC].mp4"
I, [2015-01-22T22:53:09.930719 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Aikatsu! 3 - 15 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:09.931277 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Aikatsu! 3 - 15 [720p][AAC].mp4"
I, [2015-01-22T22:53:10.314165 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Magic Kaito 1412 - 14 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:10.314981 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Magic Kaito 1412 - 14 [720p][AAC].mp4"
I, [2015-01-22T22:53:10.706277 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Lady Jewelpet - 40 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:10.707293 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Lady Jewelpet - 40 [720p][AAC].mp4"
I, [2015-01-22T22:53:11.088947 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Kantai Collection: KanColle - 03 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:11.089470 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Kantai Collection: KanColle - 03 [720p][AAC].mp4"
I, [2015-01-22T22:53:11.455801 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for [DeadFish] Military! - 03 [720p][AAC].mp4 completed
I, [2015-01-22T22:53:11.456544 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent [DeadFish] Military! - 03 [720p][AAC].mp4"
I, [2015-01-22T22:53:11.832191 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for American Horror Story 4x13 Curtain Call 720p completed
I, [2015-01-22T22:53:11.832747 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent American Horror Story 4x13 Curtain Call 720p"
I, [2015-01-22T22:53:12.206463 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Criminal Minds 10x12 Anonymous 720p completed
I, [2015-01-22T22:53:12.207347 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Criminal Minds 10x12 Anonymous 720p"
I, [2015-01-22T22:53:12.590551 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Modern Family 6x12 The Big Guns 720p REPACK completed
I, [2015-01-22T22:53:12.591390 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Modern Family 6x12 The Big Guns 720p REPACK"
I, [2015-01-22T22:53:12.967428 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Criminal Minds 10x11 The Forever People 720p completed
I, [2015-01-22T22:53:12.968011 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Criminal Minds 10x11 The Forever People 720p"
I, [2015-01-22T22:53:13.351581 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Modern Family 6x12 The Big Guns 720p completed
I, [2015-01-22T22:53:13.352268 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Modern Family 6x12 The Big Guns 720p"
I, [2015-01-22T22:53:13.719454 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Pretty Little Liars 5x15 Fresh Meat 720p completed
I, [2015-01-22T22:53:13.720047 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Pretty Little Liars 5x15 Fresh Meat 720p"
I, [2015-01-22T22:53:14.104754 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Girls 4x01 Iowa 720p completed
I, [2015-01-22T22:53:14.105347 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Girls 4x01 Iowa 720p"
I, [2015-01-22T22:53:14.478242 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Banshee 3x01 Snakes and Whatnot 720p completed
I, [2015-01-22T22:53:14.478855 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Banshee 3x01 Snakes and Whatnot 720p"
I, [2015-01-22T22:53:14.862579 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Shameless (US) 5x01 Milk of the Gods 720p completed
I, [2015-01-22T22:53:14.863374 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Shameless (US) 5x01 Milk of the Gods 720p"
I, [2015-01-22T22:53:15.227231 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for The Big Bang Theory 8x12 The Space Probe Disintegration 720p completed
I, [2015-01-22T22:53:15.227845 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent The Big Bang Theory 8x12 The Space Probe Disintegration 720p"
I, [2015-01-22T22:53:15.603801 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for American Horror Story 4x11 Magical Thinking 720p completed
I, [2015-01-22T22:53:15.605038 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent American Horror Story 4x11 Magical Thinking 720p"
I, [2015-01-22T22:53:15.987290 #6424]  INFO -- : FeedTorrents::Feed::Download#block in process: Downloading torrent for Modern Family 6x11 The Day We Almost Died 720p completed
I, [2015-01-22T22:53:15.988901 #6424]  INFO -- : FeedTorrents::Mail#mail: Sending an email to "john.doe@example.com" with subject: "[FeedTorrents] Downloaded torrent Modern Family 6x11 The Day We Almost Died 720p"
```

You can also call the executable with --test-email for sending a test email or with --test-filters to print what would be downloaded and which filter matches.

This works great with my qbittorrent-nox headless torrent client with webui!

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