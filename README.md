
# coding-challenge-data-com
## How to run

 1. run `pod install` on terminal

> i did not include pod directory and pod.lock because it might a cause
> problem if it run on different processor because Im using m1 chip
2. buid and run

## Code Architecture
- MVVM + Coordinator

I add coordinator to inject the repositories so we use it on XCUITest


## Use Framework

 - Moya - For Http request call 
 - RxSwift - use in data binding 
 - RxCocoa - use to bind in view 
 - ProgressHUD - Loading indicator
 - Kingfisher - Image downloader with cache
