//
//  FirstViewController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/23/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

enum EventType: Int {
    case FUNDRAISER = 1, PETITION, PROTEST, NEWS, OTHERS, SIX
    static let allValues = [FUNDRAISER, PETITION, PROTEST, NEWS, OTHERS, SIX]

    func toString() -> String {
        switch self {
        case .FUNDRAISER:
            return "Fundraiser"
        case .PETITION:
            return "Petition"
        case .PROTEST:
            return "Protest"
        case .NEWS:
            return "News"
        case .OTHERS:
            return "Others"
        case .SIX:
            return "Six"
        }
    }
}

struct Notification {
    let title: String
    let type: EventType

    init(title: String, type: Int) {
        self.title = title
        self.type = EventType(rawValue: type)!
    }

}

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                           UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var eventsTable: UITableView!
    var notifications = [Notification]()
    var filteredNotifications = [Notification]()
    @IBOutlet weak var typeFilterPicker: UIPickerView!
    var pickerData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        eventsTable.delegate = self
        eventsTable.dataSource = self
        typeFilterPicker.delegate = self
        typeFilterPicker.dataSource = self

        pickerData = ["All"] + EventType.allValues.map { (event) -> String in
            return event.toString()
        }
        SVProgressHUD.show()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        PFQuery(className: "Event").whereKey("enabled", equalTo: true)
            .findObjectsInBackgroundWithBlock { (events, error) -> Void in
                SVProgressHUD.dismiss()
                if error == nil {
                    if let events = events {
                        self.notifications.removeAll(keepCapacity: false)
                        for event in events {
                            self.notifications.append(
                                Notification(title: AnyObj2String(event["title"]),
                                    type: (event["type"] as? Int)!))
                        }
                        self.filterContentForType("All")
                        self.eventsTable.reloadData()
                    }
                } else {
                    print("Error: \(error!) \(error!.userInfo)")
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableView Stuff

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotifications.count
    }


    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let object = filteredNotifications[indexPath.row]
            cell.textLabel?.text = object.title
            return cell
    }

    //MARK: PickerView Stuff

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filterContentForType(pickerData[row])
    }

    func filterContentForType(type: String) {
        filteredNotifications = notifications.filter { notification in
            return (type == "All") || (notification.type.toString() == type)
//            return categoryMatch //&& notification.title.lowercaseString.containsString(
//                searchController.searchBar.text!.lowercaseString)
        }
        eventsTable.reloadData()
    }
}
