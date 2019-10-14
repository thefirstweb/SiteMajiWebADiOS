//
//  ViewController.swift
//  TestWebAD
//
//  Created by Alex on 2018/11/23.
//  Copyright © 2018年 Feebee. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    var adView:WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        //廣告 url
        let adUrl13:String = "http://www.113tools.tw/native.html?s=320x480&l=ios"
        
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
    }
}

//實作廣告delegate
extension ViewController:SMJWebADHandlerDelegate {
    //點擊廣告時callback
    func adDidClick() {
        print("ad did click")
    }
    //廣告讀取有問題時callback
    func adFetchError(errorMsg: String) {
        print("error:\(errorMsg)")
    }
}
