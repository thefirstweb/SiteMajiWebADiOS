//
//  SMJWebADHandler.swift
//  TestWebAD
//
//  Created by Alex on 2018/11/23.
//  Copyright © 2018年 Feebee. All rights reserved.
//

import Foundation
import WebKit

@objc protocol SMJWebADHandlerDelegate: NSObjectProtocol {
    func adFetchError(errorMsg:String)
    func adDidClick()
}

@objc class SMJWebADHandler:NSObject {
    @objc var delegate:SMJWebADHandlerDelegate?
    
    @objc public class var sharedInstance : SMJWebADHandler {
        struct Static {
            static let instance : SMJWebADHandler = SMJWebADHandler()
        }
        
        return Static.instance
    }
}

@objc extension SMJWebADHandler:WKUIDelegate {
    @objc func adView(adUrl:String,frame:CGRect = CGRect.zero) -> WKWebView {
        
        let adWebView:WKWebView = WKWebView()
        adWebView.frame = frame
        adWebView.uiDelegate = self
        adWebView.navigationDelegate = self
        adWebView.allowsBackForwardNavigationGestures = false
        adWebView.scrollView.isScrollEnabled = false
        
        if #available(iOS 11.0, *) {
            adWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        
        if let url = URL.init(string: adUrl) {
            let request = URLRequest.init(url: url)
            adWebView.load(request)
        }else{
            self.delegate?.adFetchError(errorMsg: "fetch url error")
        }
        
        return adWebView
    }
}

//MARK:- WKNavigationDelegate
extension SMJWebADHandler:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //        print(error.localizedDescription)
        self.delegate?.adFetchError(errorMsg: "error.localizedDescription")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //blankNothing解決方法1
        if let isMainFrame = navigationAction.targetFrame?.isMainFrame {
            if (!isMainFrame) {
                webView.load(navigationAction.request)
            }
        }else{
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            self.delegate?.adDidClick()
            if let url = navigationAction.request.url {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
}
