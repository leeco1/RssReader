//
//  TableViewController.swift
//  RSSReader
//
//  Created by Lee Cohen on 10/20/15.
//  Copyright (c) 2015 Lee. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , NSXMLParserDelegate {

    
    var parser: NSXMLParser = NSXMLParser()
    var feedTitle: String = String()
    var feedLink: String = String()
    var eName: String = String()
    
    var rssFeeds: [RssFeed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://www.geektime.co.il/feed")
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return rssFeeds.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
    
    // Configure the cell
        
    let rssFeed: RssFeed = rssFeeds[indexPath.row]
    cell.textLabel?.text = rssFeed.rssFeedTitle
    return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0}
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    

    

    // MARK - NSXMLParserDelegate methods
    
    //** didStartElement function : happens every time the parser finds a <key>
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
       
        eName = elementName
        if elementName == "item" {
            feedTitle = String()
            feedLink = String()
        }
    }
        
    // **foundCharacters function : happens every time the parser finds charecters
        
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        let data = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if (!data.isEmpty) {
            if eName == "title" {
                feedTitle += data
            } else if eName == "link" {
                feedLink += data
            }
        }
        }
    // **didEndElement function : happens every time the parser finds a </key>

            
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            let rssFeed: RssFeed = RssFeed()
            rssFeed.rssFeedTitle = feedTitle
            rssFeed.rssFeedLink = feedLink
            rssFeeds.append(rssFeed)
            
             }
        }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "viewFeed" {
           
            print("nnnn")
            
            //retrieve the feed details for the selected row using tableView.indexPathForSelectedRow().
            
            let rssFeed: RssFeed = rssFeeds[tableView.indexPathForSelectedRow()!.row]
            //assign the feed web url to viewController’s
           
            let viewController = segue.destinationViewController as! FeedViewController
            viewController.webLink = rssFeed.rssFeedLink
            
        }
        
    }
    
        }

