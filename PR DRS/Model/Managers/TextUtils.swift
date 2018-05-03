//
//  TextUtils.swift
//  Snoring Companion
//
//  Created by Dusan on 4/26/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class TextUtils: NSObject {

    static func isEmpty(_ text: String?) -> Bool {
        var rslt = true
        if text == nil {
            return rslt
        }
        
        if text?.count == 0 {
            return rslt
        }
        
        rslt = false
        
        return rslt
    }
    
    static func isValidString(_ text: String) -> Bool {
        var returnValue = true
        let numberRegEx = "[0-9.\\b()]"
        
        do {
            let regex = try NSRegularExpression(pattern: numberRegEx)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func stringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd, yyyy HH:mm a"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    static func getTimeStamp(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func dateFromString(_ date_str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MMM-dd, yyyy HH:mm a"
        let date = dateFormatter.date(from: date_str)!
        
        return date
    }
    
//    func getTextHeight(_ text: String, fontName: String, fontSize: CGFloat) -> CGFloat {
//        //        let attributes = [NSAttributedStringKey.font: UIFont(name: fontName, size: fontSize)!]
//        let attributes = [NSFontAttributeName: UIFont(name: fontName, size: fontSize)!]
//        let size = (text as NSString).size(attributes: attributes)
//
//        return size.height
//    }
//
//    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: (width - 8), height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//
//        return label.frame.height
//    }
//
//    static func stringFromString(_ date_str: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = dateFormatter.date(from: date_str) ?? Date()
//
//        dateFormatter.dateFormat = "dd MMM, yyyy HH:mm a"
//        let dateString = dateFormatter.string(from: date)
//
//        return dateString
//    }
}
