//
//  Utilities.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/28/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation
import SwiftMessages



public func showMassage(massageTitle: String, massageBody: String, place: Int, layout: MessageView.Layout ){
    
    let view = MessageView.viewFromNib(layout: layout)
    var config = SwiftMessages.defaultConfig
    switch place {
    case 1:
        config.presentationStyle = .top
    case 2:
        config.presentationStyle = .bottom
        
    case 3:
        config.presentationStyle = .center
        
    default:
        config.presentationStyle = .top
    }
    config.duration = .seconds(seconds: 1)
    view.button?.isHidden = true
    
    view.configureTheme(backgroundColor: UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0), foregroundColor: UIColor.white, iconImage: nil, iconText: nil)
    
    view.bodyLabel?.textAlignment = .center
    view.titleLabel?.textAlignment = .center
   
    view.configureDropShadow()
    view.configureContent(title: massageTitle, body: massageBody)
    SwiftMessages.show(config: config, view: view)
    
}




