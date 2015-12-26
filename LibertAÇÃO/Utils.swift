//
//  Utils.swift
//  LibertAÇÃO
//
//  Created by Pedro Rodrigues on 12/25/15.
//  Copyright © 2015 Pedro Howat. All rights reserved.
//

import Foundation

func AnyObj2String(obj: AnyObject?) -> String {
    if let unwrappedObj = obj as? String {
        return unwrappedObj
    } else {
        return ""
    }
}
