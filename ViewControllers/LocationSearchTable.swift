//
//  LocationSearchTable.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 9/9/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire


protocol LocateOnTheMap{
    func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
}

class LocationSearchTable : UITableViewController {
    var searchResults: [String]!
    var delegate: LocateOnTheMap!
    var lat:Double!
    var lng: Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.searchResults = Array()
       
        
    }
    func reloadDataWithArray(_ array:[String]){
        self.searchResults = array
        print(searchResults)
        self.tableView.reloadData()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        // 1
        
        self.dismiss(animated: true, completion: nil)
        // 2
        let urlpath = "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.searchResults[indexPath.row]),&key=AIzaSyAFBXXFY62_m8pDYElpw45bMvUdOn66sm4".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
     

       
        Alamofire.request(urlpath! , method: .get, encoding: JSONEncoding.default).responseObject { (response: DataResponse<Gocoding>) in
            if response.error == nil{
                 let res = response.result.value?.results!
                for item in res!{
                    let result = item.geometry!
                    self.lat = result.location?.lat!
                    self.lng = result.location?.lng!
                }
                self.delegate.locateWithLongitude(self.lng, andLatitude: self.lat, andTitle: self.searchResults[indexPath.row])
            }
            else{
                print(response.error?.localizedDescription)
            }
        }
    
    }
   
}
