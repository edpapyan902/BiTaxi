//
//  GradientView.swift
//  Smack
//
//  Created by mahmoud farid on 3/20/18.
//  Copyright © 2018 mahmoud farid. All rights reserved.
//

import UIKit

//able to render in storyboard
@IBDesignable
class GradientView: UIView {
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3047558367, green: 0.6146515608, blue: 1, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.4462481141, green: 0.6539699435, blue: 0.9073422551, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    

}
