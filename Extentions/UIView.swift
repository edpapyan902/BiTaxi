//
//  UIView.swift
//  Cleaning Reference
//
//  Created by Alaa Khalil on 4/1/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import NVActivityIndicatorView


@IBDesignable extension UIView{
    
    func shadow(){
        self.layer.masksToBounds = false

        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset =  .zero
        self.layer.shadowRadius = 1
       // self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true


        
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func lock(frameRect: CGRect = CGRect.zero) {
        if (viewWithTag(10) != nil) {
            //View is already locked
        }
        else {
            let lockView = UIView()
            
            if frameRect == CGRect.zero{
                lockView.frame = bounds
            }
            else{
                lockView.frame = frameRect
            }
            
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
            
            lockView.tag = 10
            lockView.alpha = 0.0
            
            
            
            let activityIndicator = NVActivityIndicatorView(frame:CGRectMake(lockView.center.x,lockView.center.y, 50, 50))
            
            
            //            activityIndicator.type = .ballBeat
            
            activityIndicator.center.x = lockView.center.x
            activityIndicator.center.y = lockView.center.y
            activityIndicator.color = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
            activityIndicator.startAnimating()
            lockView.addSubview(activityIndicator)
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
//    func makeRounded() {
//
//        self.layer.borderWidth = 1
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = self.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
//        self.clipsToBounds = true
//    }
    func setActivityIndicator(){
        let activity = UIActivityIndicatorView(style: .white)
        
        
        activity.color = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        activity.tag = 50000
        activity.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        activity.hidesWhenStopped = true
        activity.center = self.center
        
        activity.startAnimating()
        addSubview(activity)
    }
    
    func removeActivityIndicator(){
        let activity = self.viewWithTag(50000) as! UIActivityIndicatorView
        activity.removeFromSuperview()
    }
    
    
    func unlock() {
        if let lockView = self.viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
