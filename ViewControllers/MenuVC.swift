//
//  MenuVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/22/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var calcTripsLb: UILabel!
    @IBOutlet weak var helpLb: UILabel!
    @IBOutlet weak var registerLb: UILabel!
    @IBOutlet weak var signInLb: UILabel!
    @IBOutlet weak var registerImage: UIImageView!
    @IBOutlet weak var logInImage: UIImageView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.handleButtons()
    }
    
    func handleButtons(){
        if AuthManger.instance.isLogedIn{
            registerImage.image = UIImage(named: "Untitled-1_0016_Layer-13")
            signInLb.text = "حسابي"
            registerLb.text = "تسجيل الخروج"
            
        }
        
    }
    @IBAction func customerServiceBtn(_ sender: Any) {
        let url = URL(string: "tel://+9660551431243")
               UIApplication.shared.open(url!, options: [:], completionHandler: nil)

//        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=966009665254524")!
//                     if UIApplication.shared.canOpenURL(appURL as URL) {
//                   if #available(iOS 10.0, *) {
//                       UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
//                   }
//                   else {
//                       UIApplication.shared.openURL(appURL as URL)
//                   }
//               }
//               else {
//                        showMassage(massageTitle: "", massageBody: "you must download whats up application" , place: 1, layout: .centeredView)
//                   print("you must download whats up application")
//               }
    }
    @IBAction func logInBtnPressed(_ sender: Any) {
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if AuthManger.instance.isLogedIn{
          
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "toAccountVC") as! UINavigationController
            
            self.present(newViewController, animated: true, completion: nil)
            
        }
        else{
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "toLoginVC") as! UINavigationController
            self.present(newViewController, animated: true, completion: nil)
          
        }
    }
    @IBAction func signInBtnPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if AuthManger.instance.isLogedIn{
            
            AuthManger.instance.logOut()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! UINavigationController
            self.present(newViewController, animated: true, completion: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "toPaymentVC") as! UINavigationController
//            self.present(newViewController, animated: true, completion: nil)
            
        }
        else{
          
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "toRegisterVC") as! UINavigationController
            self.present(newViewController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
