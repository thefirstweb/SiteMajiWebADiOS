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
    var adView:UIView = UIView()
    let adManager = SMJWebADHandler.sharedInstance
    //廣告 url，此為測試用網址，正式上線時請記得換回正確的網址
    let adUrl:String = "https://test.sitemaji.com/native/sitemaji.html?s=300x250"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        //300x250廣告
        //廣告view預定放置位置及大小
        let adViewFrame:CGRect = CGRect.init(x: 0, y: 0, width: 300, height: 250)
        //handle ad delegate
        adManager.delegate = self
        
        //指定一個view來裝廣告
        /*
         - Parameters:
         - adUrl: 廣告網址。
         - frame: 廣告view大小。
         - isShowCloseButton: 用來控制是否要出現close button，預設為false，可以自已客製外框及關閉按鈕
         */
        adView = adManager.adView(adUrl: adUrl,frame: adViewFrame,isShowCloseButton: true)

        //可自行決定廣告要放在哪
        adView.center = self.view.center
        
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
    
    //廣告關閉按鈕被點擊時，此為optional，isShowCloseButton設為true時請記得實作這個function
    func adCloseClick() {
        print("ad close button did click")
        adView.removeFromSuperview()
    }
}
