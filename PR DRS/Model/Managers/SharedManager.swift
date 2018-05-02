//
//  SharedManager.swift
//  Snoring Companion
//
//  Created by Dusan on 4/30/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class SharedManager: NSObject {

    static func getFileList() -> [String] {
        var file_list = [String]()
        let fileURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/", isDirectory: true)
        
        var tmp_file_list = [String]()
        if FileManager.default.fileExists(atPath: (fileURL.path)!) {
            do {
                tmp_file_list = try FileManager.default.contentsOfDirectory(atPath: (fileURL.path)!)
            } catch let error as NSError {
                NSLog("Unable to get directory \(error.debugDescription)")
            }
        }
        
        if tmp_file_list.count > 0 {
            for one in tmp_file_list {
                let url = fileURL.appendingPathComponent(one)
                
                var isDirectory: ObjCBool = ObjCBool(false)
                if FileManager.default.fileExists(atPath: url!.path, isDirectory: &isDirectory) {
                    if !isDirectory.boolValue {
                        file_list.append(one)
                    }
                }
            }
        }
        
        return file_list
    }
    
    
    static func saveObjectDataToNSUserDefault(saveObject: Any, forKey: String){
        let userDefaults = UserDefaults.standard
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: saveObject)
        userDefaults.set(encodedData, forKey: forKey)
        userDefaults.synchronize()
    }
    
    static func loadObjectDataToNSUserDefault(forKey: String) -> Any? {
        var loadObject: Any?
        let userDefaults = UserDefaults.standard
        let data = userDefaults.data(forKey: forKey)
        if data != nil {
            loadObject = NSKeyedUnarchiver.unarchiveObject(with: data!) as Any
        }
        
        return loadObject
    }
}
