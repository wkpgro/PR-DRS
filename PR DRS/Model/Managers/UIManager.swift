//
//  UIManager.swift
//  Snoring Companion
//
//  Created by Dusan on 4/26/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class UIManager: NSObject {
    
    public static func addNavBarItem(targetController: UIViewController,  selector: Selector, title: String = "") {
        let btn = UIButton(frame: CGRect(x: 0, y: 24, width: 80, height: 40))
        var text = title
        if TextUtils.isEmpty(title) {
            text = "Main"
        }
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.clear
        btn.contentMode = .left
        btn.addTarget(targetController, action: selector, for: .touchUpInside)
        
        targetController.view.addSubview(btn)
    }
    
    public static func addGradientView(targetViewController: UIViewController) {
        targetViewController.view.backgroundColor = Global.APP_MAIN_BACKGROUND
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = targetViewController.view.bounds
        gradientLayer.colors = [Global.APP_MAIN_BACKGROUND.cgColor, Global.GRADIENT_COLOR1.cgColor, Global.GRADIENT_COLOR2.cgColor, Global.GRADIENT_COLOR1.cgColor]
        gradientLayer.locations = [0.0, 0.2, 0.45, 0.9]
        targetViewController.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public static func showAlertViewController(targetVC: UIViewController, title: String?, description: String?, okAction: ((UIAlertAction) -> Swift.Void)? = nil, okActionTitle: String? = nil, isVisiableCancel: Bool = false) {
        
        let alertVC = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: TextUtils.isEmpty(okActionTitle) ? "OK" : okActionTitle!, style: .default, handler: okAction)
        alertVC.addAction(ok)
        if isVisiableCancel {
            alertVC.addAction(cancel)
        }
        targetVC.present(alertVC, animated: true, completion: nil)
    }
    
}
