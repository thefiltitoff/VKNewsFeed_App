# VKNewsFeed_App

This application is created with Clean Swift pattern to wotk with VK SDK dor iOS. 📰📱 <br />
VK is the most popular social network in Russia. I used it's SDK for parsing News Feed in my app. <br />

For posts with a lot of photos I used UICollectionView with custom layout and auto sizing cells in tableview.
Also I created button for show more text in posts.

I added refresh control to update feed, and label in bottom refresh controll, to show post's count in feed.

Application supports light and dark mode. Also I created gradient view in background. 
If you want turn gradient on, change Hidden prooperty in ```NewsFeedViewController.storyboard``` on false.

All layouts created programmatically.
Localized only in Russian.

<div align="center">
  
  [![iOS](https://img.shields.io/badge/iOS-15.5-blue)](https://www.apple.com/ru/ios/ios-15/)
  [![Swift](https://img.shields.io/badge/Swift-5.5-orange)](https://developer.apple.com/documentation/swift)
  [![UIKit](https://img.shields.io/badge/UIKit-%20LTS-yellowgreen)](https://developer.apple.com/documentation/uikit)
  [![VKSDK](https://img.shields.io/static/v1?label=VKSDK&message=1.6.2&color=blue)](https://github.com/VKCOM/vk-ios-sdk)
  
</div>

## Table of Contents

- [Demo](#demo)

- [Tech stack](#tech-stack)

- [License](#copyright)

## Demo
### Open and scrolling
<div align="center">

![output](https://user-images.githubusercontent.com/56549889/182604956-1b7f4110-07c4-49a7-aef6-27576427b58c.gif)

![output 2](https://user-images.githubusercontent.com/56549889/182605050-ee07f913-af66-471f-8270-60fc99fca023.gif)


</div>

### Refresh
<div align="center">

![output 3](https://user-images.githubusercontent.com/56549889/182603667-15375dca-8773-476a-b334-c50a4af9324d.gif)

![output 4](https://user-images.githubusercontent.com/56549889/182603700-3454c69b-7d3d-45aa-9b69-489bf9c03c33.gif)

</div>

### Refresh
<div align="center">

![output 5](https://user-images.githubusercontent.com/56549889/182603922-d2222e5b-f2c8-4b3d-a613-4ed664391f38.gif)

![output 6](https://user-images.githubusercontent.com/56549889/182603945-e244fa3e-813c-4987-a6e0-751de0e95fd0.gif)

</div>

## Tech Stack

* Swift
* UIKit
* VKSDK
* UICollectionView

## Installation

1. Install project from GitHub

```bash
  git clone https://github.com/filtitov2001/VKNewsFeed_App/
```
2. Go to app folder
```bash
  cd VKNewsFeed_App
```
3. Install dependency 
```bash
  pod install
```
4. Created project on [VK Dev](https://vk.com/dev)

5. Input App ID from project on [VK Dev](https://vk.com/dev) in ```Info.plist``` in AppID field.

6. Open project
```bash
  open VKNewsFeed_App.xcworkspace
```

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Copyright

Copyright © 2022 by [Felix Titov](https://github.com/filtitov2001)
