//
//  TripCalculatorVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/22/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import AlamofireObjectMapper
import Alamofire


class TripCalculatorVC: UIViewController, GMSMapViewDelegate {
    
    var rectangle = GMSPolyline()
    var endAddress: String!
    var startAddress: String!
    var selectLat: String!
    var selectLng: String!
    var distance : Float = 0.0
    var time : String!
    var cost: Float = 5.5
    var currentLat = Double()
    var currentLng = Double()
    var lat = Double()
    var lng = Double()
    var zoomLevel: Float = 17.0
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    let locationManager = CLLocationManager()
    @IBOutlet weak var informationLb: UILabel!
    @IBOutlet weak var distinationLocaton: UIButton!
    @IBOutlet weak var map: UIView!
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
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
        mapView.delegate = self as! GMSMapViewDelegate

        }
    
    @IBAction func OrderBitaxi(_ sender: Any) {
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "MainVC") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func ToDestinationBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LocationVC") 
        self.show(newViewController, sender: self)
    }
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
                            self.distance = Float(((leg.distance?.value!)!)/1000)
                            self.time = leg.duration?.text!
                            self.cost += (self.distance * 1.5)
                          
                           
                            self.informationLb.text = "\(String(describing: leg.distance!.text!)) | \(self.time!) | \(self.cost) RS"
                            self.informationLb.adjustsFontSizeToFitWidth = true
                            
                            self.locateWithLongitude((leg.end_location?.lng!)!, andLatitude:(leg.end_location?.lat!)!, andTitle: leg.end_address!)
                                                           }
                        let routeOverviewPolyline = route.overview_polyline
                        let point = routeOverviewPolyline?.points
                        let path = GMSPath.init(fromEncodedPath: point!)
                        let polyline = GMSPolyline.init(path: path)
                        polyline.strokeWidth = 4
                        polyline.strokeColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                        polyline.map = self.mapView
                       
                    }
                    
                    self.distinationLocaton.setTitle(self.endAddress, for: .normal)
                    print(self.endAddress as Any)
                }
                else{
                    showMassage(massageTitle: "", massageBody: "عفوا يوجد مشكله في تحديد الرحله حاول لاحقا" , place: 1, layout: .centeredView)
                    print("there is an error with drow roud\(response.error?.localizedDescription)")
                }
            }
            }
}
}

//Set up the Location Manager Delegate
extension TripCalculatorVC: CLLocationManagerDelegate{

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
    if selectLng != nil {
    self.drowLine(currentLat: String(self.currentLat), currentLng: String(self.currentLng))
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
}

    
}
