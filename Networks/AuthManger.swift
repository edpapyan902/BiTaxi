//
//  Manger.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/22/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireMapper



class AuthManger {
    
    static let instance = AuthManger()
    
    public private(set) var massage: String?
    let defaults = UserDefaults.standard
    var isLogedIn : Bool{
        get{
            return defaults.bool(forKey:LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authToken: String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail: String{
        
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    var userName: String{
        
        get{
            return defaults.value(forKey: USER_NAME) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_NAME)
        }
    }
    
    func registerUser(email: String, password: String, name: String, mobile: String, cityId: String, nationalID: String, completion: @escaping CompletionHandle){
        
        let lowercaseEmail = email.lowercased()
        let body: [String: Any] = ["email": lowercaseEmail,
                                   "password": password,
                                   "full_name": name,
                                   "mobile": mobile,
                                    "city_id" : cityId,
                                    "nationality_id": nationalID]
        Alamofire.request(URL_REGISRER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseObject{ (response: DataResponse<Register>) in
        
            if response.result.error == nil &&   response.result.value?.key == "success" {
                guard response.result.value != nil
                    else {return}
                
                completion(true)
            }
            else {
                completion(false)
                showMassage(massageTitle: "خطأ", massageBody: (response.result.value?.message!)! , place: 1, layout: .centeredView)
            }
                debugPrint(response.result.error as Any)
            }
        }
    
    
    func logIn (mobile: String, password: String, completion: @escaping CompletionHandle){
        let body: [String: Any] = [
            "mobile": mobile,
            "password": password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseObject{ (response: DataResponse<SignIn>) in
            
            if response.result.error == nil && response.result.value?.key == "success"{
                self.massage = response.result.value?.message!
                let res = response.result.value?.user
                self.userEmail = res?.email ?? " "
                self.authToken = res?.token ?? " "
                self.isLogedIn = true
                self.userName = res?.full_name ?? " "
               
                completion(true)
                
                
            }
            else{
                showMassage(massageTitle: "خطأ", massageBody: (response.result.value?.message!)! , place: 1, layout: .centeredView)
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
        
    }
    
    func updatePassword(password: String, completion: @escaping CompletionHandle){
        
        let body: [String: Any] = [
            "password": password
        ]
        Alamofire.request(URL_UPDATE_PASSWORD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseObject{ (response: DataResponse<UpdatePassword>) in
            
            if response.result.error == nil && response.result.value?.key == "success"{
                self.massage = response.result.value?.message!
                 if response.result.error == nil && response.result.value?.key == "success"{
                 showMassage(massageTitle: " ", massageBody: (response.result.value?.message!)! , place: 1, layout: .centeredView)
                
                completion(true)
                
                
            }
            else{
               
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
    }
    }
    
    func updateProfile(name: String,mobile: String, image: String, completion: @escaping (_ response: DataResponse<UpdateProfile>, _ error: String?) -> Void) -> Void{
        
        let body: [String: Any] = [
            "full_name": name,
            "mobile": mobile, 
            "image": image
        ]
        Alamofire.request(URL_UPDATE_PROFILE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseObject{ (response: DataResponse<UpdateProfile>) in
            
            if response.result.error == nil && response.result.value?.key == "success"{
                self.massage = response.result.value?.message!
                if response.result.error == nil && response.result.value?.key == "success"{
                    showMassage(massageTitle: " ", massageBody: (response.result.value?.message!)! , place: 1, layout: .centeredView)
                    
                  completion(response, nil)
                    
                    
                }
                else{
                    
                    debugPrint(response.result.error as Any)
                   
                }
                
            }
        }
    }
        
        
    func logOut(){
        

        AuthManger.instance.isLogedIn = false
        AuthManger.instance.userEmail = ""
        AuthManger.instance.authToken = ""
         AuthManger.instance.userName = ""
    }
    
    
}
