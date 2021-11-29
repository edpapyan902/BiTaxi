//
//  MainVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/16/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import AlamofireObjectMapper
import Alamofire


class MainVC: UIViewController, GMSMapViewDelegate{

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var familyCarLb: UILabel!
    @IBOutlet weak var normalCarLb: UILabel!
    @IBOutlet weak var myLocationLb: UILabel!
    @IBOutlet weak var familyCarBt: UIButton!
    @IBOutlet weak var normalCarImg: UIImageView!
    
    @IBOutlet weak var familyCarImg: UIImageView!
    @IBOutlet weak var normalCarBtn: UIButton!
    @IBOutlet weak var distinationLocatonBt: UIButton!
    var mapView: GMSMapView!
    var rectangle = GMSPolyline()
    var selectLat: String!
    var selectLng: String!
    var carType:String!
    var TotalCost : Float = 0.0
    var time : String!
    var cost : Float = 5.5
    var zoomLevel: Float = 17.0
    var endAddress: String!
    var startAddress: String!
    var distance : String!
    var duration: String!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)


    var currentLat = Double()
    var currentLng = Double()
    var lat = Double()
    var lng = Double()
    var locationManager = CLLocationManager()
//    let regionRadius: CLLocationDistance = 50
    override func viewDidLoad(){
        
        super.viewDidLoad()
      
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self as! CLLocationManagerDelegate
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        self.map.addSubview(mapView)
       // self.view.addSubview(mapView)
         mapView.delegate = self
        self.familyCarImg.alpha = 0.5
        self.normalCarImg.alpha = 1
        self.familyCarLb.alpha = 0.3
        self.carType = "0"
        self.handleSelectedPlaceLb()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        //self.handleSelectedPlaceLb()
    }
    
    
    func handleSelectedPlaceLb(){
        DispatchQueue.main.async {
            
        
        if self.selectLng == nil && self.selectLat == nil{
            self.distinationLocatonBt.titleLabel?.text = "انقر هنا لأختيار وجهتك"
        }
        else{
            
            self.distinationLocatonBt.setTitle(self.endAddress, for: .normal)
            self.distinationLocatonBt.titleLabel?.numberOfLines = 2
        }
            print("the lat of selected place is \(String(describing: self.selectLat))------ the lng of selected place is \(String(describing: self.selectLng))")
        }
    }
    
    
    @IBAction func menuBtn(_ sender: Any) {
        performSegue(withIdentifier: "toMenuVC", sender: nil)
    }
    
    @IBAction func familyCarPressed(_ sender: Any) {
        
        self.familyCarImg.alpha = 1
        self.normalCarImg.alpha = 0.5
        self.normalCarLb.alpha = 0.3
        self.familyCarLb.alpha = 1
        self.carType = "1"
        self.cost = 7.5
        self.cost += TotalCost
        self.infoLabel.text = " \(distance!) | \(duration!) | \(self.cost) RS"
        
        
    }
    @IBAction func normalCarPressed(_ sender: Any) {
        
        self.familyCarImg.alpha = 0.5
        self.normalCarImg.alpha = 1
        self.familyCarLb.alpha = 0.3
        self.normalCarLb.alpha = 1
        self.carType = "0"
        self.cost = 5.5
        self.cost += TotalCost
        self.infoLabel.text = " \(distance!) | \(duration!) | \(self.cost) RS"
        
    }
    

 
    @IBAction func requestBtn(_ sender: Any) {
        
        self.handleCreateOrder()
    }
        
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
             DispatchQueue.main.async {
                //self.mapView.clear()
                self.selectLat = String(lat)
                self.selectLng = String(lon)
                let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let marker = GMSMarker(position: position)
//
               
                marker.title = " \(title)"
                marker.map = self.mapView
             
        }
    }
     
    
    // draw Line between current location and destination
    func drowLine(currentLat: String, currentLng: String){
        let origin = "\(currentLat),\(currentLng)"
        let destination = "\(self.selectLat!),\(self.selectLng!)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAFBXXFY62_m8pDYElpw45bMvUdOn66sm4"
        print(url)
        DispatchQueue.main.async {
        Alamofire.request(url).responseObject { (response:DataResponse<Base>) in
            if response.error == nil{
                let result = response.result.value?.routes!
                
                for route in result!{
                    for leg in route.legs!{
                                self.startAddress = leg.start_address
                                self.endAddress = leg.end_address
                                self.locateWithLongitude((leg.end_location?.lng!)!, andLatitude:(leg.end_location?.lat!)!, andTitle: leg.end_address!)
                        self.TotalCost = Float(((leg.distance?.value)!/1000)) * 1.5
                        self.duration = "\(leg.duration?.text! ?? "min") "
                        self.distance = "\(leg.distance!.text!)"
                        self.infoLabel.text = " \(self.distance!) | \(self.duration!) | \(self.cost) RS"
                       
                                                       }
                    let routeOverviewPolyline = route.overview_polyline
                    let point = routeOverviewPolyline?.points
                    let path = GMSPath.init(fromEncodedPath: point!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                    polyline.map = self.mapView
                  
                  
                   
                }
               self.handleSelectedPlaceLb()
                
                print(self.endAddress as Any)
            }
            else{
                showMassage(massageTitle: "", massageBody: "عفوا يوجد مشكله في تحديد الرحله حاول لاحقا" , place: 1, layout: .centeredView)
                print("there is an error with drow roud\(response.error?.localizedDescription)")
            }
        }
        }
        
    }
    func handleCreateOrder() {
        if self.selectLat == nil || self.selectLng == nil{
            showMassage(massageTitle: "", massageBody: "عفوا يجب تحديد وجهتك اولا للطلب", place: 1, layout: .centeredView)
        }
        
        else{
        if AuthManger.instance.isLogedIn{
        DispatchQueue.main.async {
            self.view.lock()
            ServerManger.instance.createOrder(userLat: (String(describing: self.currentLat)), userLng:  (String(describing: self.currentLng)), deliveryLat: self.selectLat , deliveryLng: self.selectLng, carType: self.carType, completion: { (response, error) in
                if error != nil{
                    print(error as Any)
                    print(response.response?.statusCode as Any)
                }
                else{
                    print("the id of order == \(String(describing: response.result.value?.id!))")
                   print("add Order Succefully")
                }
            })
            self.view.unlock()
            showMassage(massageTitle: "", massageBody: " تم ارسال الطلب بنجاح", place:  1, layout: .centeredView)
            }

        }
   
        else{
    showMassage(massageTitle: "", massageBody: " يجب عليك التسجيل اولا", place:  1, layout: .centeredView)
        }
       
        }
        
    }
}



extension MainVC: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        self.currentLat = Double(location.coordinate.latitude)
        self.currentLng = Double(location.coordinate.longitude)
        print("latitude is :\(currentLat), longitud is \(currentLng) ")
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        }
        else {
            mapView.animate(to: camera)
        }
        
        if self.selectLng != nil{
          
            self.drowLine(currentLat:String(currentLat), currentLng: String(currentLng))
            
             
       
        }
         
        locationManager.stopUpdatingLocation()
        
    }
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
        showMassage(massageTitle: "", massageBody: "عفوا يوجد خطأ ما" , place: 1, layout: .centeredView)
    }
}
    
    

    


