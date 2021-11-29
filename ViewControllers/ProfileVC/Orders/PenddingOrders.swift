//
//  PenddingOrders.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 8/27/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class PenddingOrders: UIViewController {

    var penddingOrder = [Current_Orders]()
    let label = UILabel()

    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.isHidden = true

        DispatchQueue.main.async {
            self.view.lock()
        ServerManger.instance.getPendingOrder { (response, error) in
            if error == nil{
                let res = response.result.value
                for item in (res?.current_orders)!{
                    self.penddingOrder.append(item)
                }
            }
            else{
                print(error!)
            }
            if self.penddingOrder.count == 0{
                self.label.isHidden = false
                self.label.text = " لاتوجد طلبات حاليه"
                self.label.textAlignment = .center
                self.label.frame = CGRect(x: self.view.bounds.width/2.6, y: 150, width: 60, height: 22)
                self.label.textColor = UIColor.darkGray
                self.label.font = UIFont.systemFont(ofSize: 18.0)
                self.label.sizeToFit()
                self.view.addSubview(self.label)
            }
            else{
                self.label.isEnabled = true
            }
            self.collection.reloadData()
            self.view.unlock()
        }
           
        }
    
    
}
}

extension PenddingOrders: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return penddingOrder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "penddingOrderCell", for: indexPath) as? PenddingOrderCell{
            let orderCode = penddingOrder[indexPath.row].id!
            let orderTitle = penddingOrder[indexPath.row].title
            cell.orderNoLb.text = String(describing: orderCode)
           // cell.name.text = orderTitle
            return cell
            
        }
        return PenddingOrderCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you want the cell to be 47% of your controllers view
        return CGSize(width: width * 0.47, height: height * 0.25)
    }
   
    
}

