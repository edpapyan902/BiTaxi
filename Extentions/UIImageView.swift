//
//  UIImageView.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 10/1/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func makeRounded() {
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width/2 //This will change with corners of image and height/2 will make this circle shape
        self.clipsToBounds = true
    }
}
