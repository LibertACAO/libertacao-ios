//
//  ExternalNewsController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/27/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import MWFeedParser
import SVProgressHUD

class ExternalNewsController: UITableViewController, MWFeedParserDelegate {

    var news = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let request = NSURL(string:
            "https://feeds.feedburner.com/Anda-AgnciaDeNotciasDeDireitosAnimais?format=xml")
        let feedParser = MWFeedParser(feedURL: request)
        feedParser.delegate = self
        feedParser.parse()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: RSS thingsies
    func feedParserDidStart(parser: MWFeedParser) {
        SVProgressHUD.show()
        news.removeAll(keepCapacity: false)
        
    }

    func feedParserDidFinish(parser: MWFeedParser) {
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }


    func feedParser(parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
        print("DELETEME: DIDI PARSE FEED INFO")
        print(info)
//        self.title = info.title
    }

    func feedParser(parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
        print("DELETEME: DID PARSE FEED ITEM")
        print(item)
//        self.items.append(item)
    }

}
