//
//  NotificationsViewController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/25/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import Parse


//enum EventType: Int {
//    case FUNDRAISER = 1, PETITION, PROTEST, NEWS, OTHERS, SIX
//    static let allValues = [FUNDRAISER, PETITION, PROTEST, NEWS, OTHERS, SIX]
//
//    func toString() -> String {
//        switch self {
//        case .FUNDRAISER:
//            return "Fundraiser"
//        case .PETITION:
//            return "Petition"
//        case .PROTEST:
//            return "Protest"
//        case .NEWS:
//            return "News"
//        case .OTHERS:
//            return "Others"
//        case .SIX:
//            return "Six"
//        }
//    }
//}
//
//struct Notification {
//    let title: String
//    let type: EventType
//
//    init(title: String, type: Int) {
//        self.title = title
//        self.type = EventType(rawValue: type)!
//    }
//
//}
class NotificationsViewController: UITableViewController,
                                   UISearchResultsUpdating, UISearchBarDelegate {

    var notifications = [Notification]()
    var filteredNotifications = [Notification]()
    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["All"] + EventType.allValues.map { (event) -> String in
            return event.toString()
        }
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        PFQuery(className: "Event").whereKey("enabled", equalTo: true)
            .findObjectsInBackgroundWithBlock { (events, error) -> Void in
            if error == nil {
                if let events = events {
                    self.notifications.removeAll(keepCapacity: false)
                    for event in events {
                        print(event["title"])
                        self.notifications.append(
                            Notification(title: AnyObj2String(event["title"]),
                                         type: (event["type"] as? Int)!))
                    }
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation
        // bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != "" {
            return filteredNotifications.count
        } else {
            return notifications.count
        }
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object: Notification
        if searchController.active && searchController.searchBar.text != "" {
            object = filteredNotifications[indexPath.row]
        } else {
            object = notifications[indexPath.row]
        }
        cell.textLabel?.text = object.title
        return cell
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredNotifications = notifications.filter { notification in
            let categoryMatch = (scope == "All") || (notification.type.toString() == scope)
            return categoryMatch && notification.title.lowercaseString.containsString(
                searchController.searchBar.text!.lowercaseString)
        }
        tableView.reloadData()
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }


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

}
