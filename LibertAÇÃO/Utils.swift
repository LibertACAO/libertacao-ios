//
//  Utils.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/25/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import Foundation
import UIKit

func AnyObj2String(obj: AnyObject?) -> String {
    if let unwrappedObj = obj as? String {
        return unwrappedObj
    } else {
        return ""
    }
}

class Alert {
    class func show (controller: UIViewController, title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        controller.presentViewController(ac, animated: true, completion: nil)
    }
}