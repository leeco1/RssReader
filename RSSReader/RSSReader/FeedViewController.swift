//
//  FeedViewController.swift
//  RSSReader
//
//  Created by Lee Cohen on 10/20/15.
//  Copyright (c) 2015 Lee. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController , UIWebViewDelegate {

    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webLink: String = String()
    
    override func viewDidLoad() {
        activityIndicator.hidden = false
        super.viewDidLoad()
        let url: NSURL = NSURL(string: webLink)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        webView.delegate = self
        webView.frame = self.view.bounds
        webView.scalesPageToFit = true
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - UIWebViewdelegate functions implementation in order to show and hide Activity Indicator View:
    
    func webViewDidStartLoad(webView: UIWebView) {
       activityIndicator.hidesWhenStopped = false
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    
    func webView(webView: UIWebView,
        didFailLoadWithError error: NSError){
            let alert:UIAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            activityIndicator.hidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
