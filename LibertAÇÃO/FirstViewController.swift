//
//  FirstViewController.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/23/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                           UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var eventsTable: UITableView!
    var notifications = [Notification]()
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
        return notifications.count
    }


    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            print("DELETEME: Cell??")

            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

            let object = notifications[indexPath.row]

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
        //TODO
    }
}
