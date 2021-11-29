//
//  MyOrdersVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/31/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var penddingOrdersView: UIView!
    @IBOutlet weak var currentOrdersView: UIView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.shadow()
        self.penddingOrdersView.alpha = 1
        self.currentOrdersView.alpha = 0
        self.orderView.alpha = 0
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.penddingOrdersView.alpha = 0
            self.currentOrdersView.alpha = 0
            self.orderView.alpha = 1
        case 1:
            self.penddingOrdersView.alpha = 0
            self.currentOrdersView.alpha = 1
            self.orderView.alpha = 0
        case 2:
         
            self.penddingOrdersView.alpha = 1
            self.currentOrdersView.alpha = 0
            self.orderView.alpha = 0
        default:
            self.penddingOrdersView.alpha = 1
            self.currentOrdersView.alpha = 0
            self.orderView.alpha = 0
        }
    }
    

}
