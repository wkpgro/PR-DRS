//
//  LogUtils.swift
//  Snoring Companion
//
//  Created by Dusan on 5/1/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class LogUtils: NSObject {

    static let APP_NAME = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    static func log(target: Any, message: String) {
        let class_name = String(describing: type(of: target))
        print("\(APP_NAME): \(class_name)")
        print("\(APP_NAME): \(message)")
    }
}
