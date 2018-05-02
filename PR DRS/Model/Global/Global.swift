//
//  Global.swift
//  Snoring Companion
//
//  Created by Dusan on 4/26/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit



class Global: NSObject {

    static let APP_MAIN_BACKGROUND = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(21.0 / 255.0), blue: CGFloat(50.0 / 255.0), alpha: 1.0)
    static let GRADIENT_COLOR1 = UIColor(red: CGFloat(15.0 / 255.0), green: CGFloat(103.0 / 255.0), blue: CGFloat(150.0 / 255.0), alpha: 1.0)
    static let GRADIENT_COLOR2 = UIColor(red: CGFloat(70.0 / 255.0), green: CGFloat(149.0 / 255.0), blue: CGFloat(188.0 / 255.0), alpha: 1.0)
    
    static let BTN_COLOR = UIColor(red: CGFloat(2.0 / 255.0), green: CGFloat(21.0 / 255.0), blue: CGFloat(49.0 / 255.0), alpha: 1.0)
    
    static let THRESHOLD_FREQUENCY = 100.0
    static let THRESHOLD_DECIBEL = 9.0
    static var THRESHOLD_SILENCE_DECIBEL = 40.0
    static var THRESHOLD_MAX_DECIBEL = 150.0
    
    static let SAMPLE_PERIOD_MIN = 1.0
    static let SAMPLE_PERIOD_MAX = 2.0
    
    static let TIME_ALARM = 10
    static let TIME_WAITTING = 30
    
    static let SYSTETM_SOUND_PATH = "/System/Library/Audio/UISounds/"
    
    //SharedManager Keys
    static let ALARM_KEY = "ALARM_KEY"
    static let SENSITIVE_KEY = "SENSITIVE_KEY"
}
