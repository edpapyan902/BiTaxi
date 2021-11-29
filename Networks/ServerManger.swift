//
//  ServerManger.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/29/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class ServerManger {
    
    
  public  static let instance = ServerManger()
    
    func getCity(completion: @escaping (_ response: DataResponse<BaseCities>, _ error: String?) -> Void) -> Void{
        
        Alamofire.request(URL_CITIES).responseObject { (response: DataResponse<BaseCities>) in
            if response.error != nil{
                print("there is an error to get cities\(String(describing: response.error))")
                
            }
            else{
                completion(response, nil)
            }
            
        }
        
    }
    
    func getNationality(completion: @escaping (_ response: DataResponse<BaseNationalities>, _ error: String?) -> Void) -> Void{
        
        Alamofire.request(URL_NATIONALITY).responseObject { (response: DataResponse<BaseNationalities>) in
            if response.error != nil{
                print("there is an error to get Nationalities\(String(describing: response.error))")
                
            }
            else{
                completion(response, nil)
            }
            
        }
        
    }
    func createOrder(userLat: String, userLng: String, deliveryLat: String, deliveryLng: String, carType: String, completion: @escaping (_ response: DataResponse<CreateOrder>, _ error: String?) -> Void) -> Void{
        let body: [String: Any] = [
            "place_of_user_lat": userLat,
            "place_of_user_lng": userLng,
            "delivery_lat": deliveryLat,
            "delivery_lng": deliveryLng,
            "car_type": carType
        ]
        print("the data is ----")
        
        Alamofire.request(URL_CREATE_ORDER, method: .post, parameters: body,encoding: JSONEncoding.default, headers: BEARER_HEADER).responseObject { (response: DataResponse<CreateOrder>) in
            if response.error != nil || response.response?.statusCode != 200{
                print("there is an error to Create Order\(String(describing: response.error))")
                 print(response.response?.statusCode)
            }
            else{
                completion(response, nil)
                print("the response")
               
                print(AuthManger.instance.authToken)
            }
            
        }
        
    }
    func getPendingOrder(completion: @escaping (_ response: DataResponse<PenddingOrder>, _ error: String?) -> Void) -> Void{
        Alamofire.request(URL_Pendding_ORDERS, method: .get,encoding: JSONEncoding.default, headers: BEARER_HEADER).responseObject { (response: DataResponse<PenddingOrder>) in
            
            if  response.error == nil && response.response?.statusCode == 200{
            completion(response, nil)
                print(response.result.value!)
                print("get order successfully")
        }
        else{
                print("there is an error in get pendding orders \(response.error?.localizedDescription)")
        }
    }
}
    
 
    func getTermOfUse(completion: @escaping (_ response: DataResponse<PrivacyPolicy>, _ error: String?) -> Void) -> Void{
        Alamofire.request(URL_privacy_policy, method: .get,encoding: JSONEncoding.default).responseObject { (response: DataResponse<PrivacyPolicy>) in
            
            if  response.error == nil && response.response?.statusCode == 200{
                completion(response, nil)
                print(response.result.value!)
                print("get TermOfUse successfully")
            }
            else{
                print("there is an error in get pendding orders \(response.error?.localizedDescription)")
            }
        }
    }
    func getPrivacyPolicy(completion: @escaping (_ response: DataResponse<PrivacyPolicy>, _ error: String?) -> Void) -> Void{
        Alamofire.request(URL_privacy_policy, method: .get,encoding: JSONEncoding.default).responseObject { (response: DataResponse<PrivacyPolicy>) in
            
            if  response.error == nil && response.response?.statusCode == 200{
                completion(response, nil)
                print(response.result.value!)
                print("get Privacy Policy successfully")
            }
            else{
                print("there is an error in get pendding orders \(response.error?.localizedDescription)")
            }
        }
    }

}
