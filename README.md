# SiteMaji Web AD

## Installation Web AD Compoment
Copy SMJWebADHandler.swift to your project

``` import SMJWebADHandler ```

## Example Usage

##### sample code
```
//此處以320 x 480廣告為例

//廣告 url
let adUrl13:String = "放你的web ad url"
    
//320x480廣告
let adViewHeight:CGFloat = (self.view.frame.size.width/320) * 480
    
//廣告view預定放置位置及大小
let adViewFrame:CGRect = CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: adViewHeight)
    
//產生320x480廣告view
let adHandler = SMJWebADHandler.sharedInstance
    
//廣告delegate
adHandler.delegate = self
    
//指定一個view來裝廣告
/*
 - Parameters:
 - adUrl: 廣告網址。
 - frame: 廣告view大小。
 */
let adView = adHandler.adView(adUrl: adUrl13,frame: adViewFrame)

self.view.addSubview(adView)
```

##### Implement Delegate in ViewController

```
#pragma mark - SMJWebADHandler Delegate

//點擊廣告時callback
func adDidClick() {
    print("ad did click")
}

//廣告讀取有問題時callback
func adFetchError(errorMsg: String) {
    print("error:\(errorMsg)")
}
```