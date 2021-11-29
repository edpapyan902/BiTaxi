//
//  LocationVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/16/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps
import GooglePlaces
import CoreLocation




class LocationVC: UIViewController, UISearchBarDelegate, LocateOnTheMap, GMSMapViewDelegate{
   
    
    var selectedLat: String!
    var selectedLng: String!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 17.0
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    var mapView: GMSMapView!
    var searchResultContriller:LocationSearchTable!
    var resultArray = [String]()
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var currentLat = Double()
    var currentLng = Double()
    


    
    // The currently selected place.
    var selectedPlace: GMSPlace?

  

    @IBOutlet weak var map: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //intial location maneger
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self as! CLLocationManagerDelegate
        searchResultContriller = LocationSearchTable()
        searchResultContriller.delegate = self
        placesClient = GMSPlacesClient.shared()
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
     
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
       
        
        self.map.addSubview(mapView)
        mapView.delegate = self
        self.mapView.isHidden = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.setAllGesturesEnabled(true)
       
       // self.show_Marker(position: mapView.camera.target)
     }
    func show_Marker(position: CLLocationCoordinate2D){
        self.mapView.clear()
        let marker = GMSMarker()
        marker.position = position
        marker.title = "destination"
        marker.map = mapView
      

    }
    @IBAction func searchBtn(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultContriller)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)
    }
   
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
         DispatchQueue.main.async {
           
            self.locateWithLongitude(coordinate.longitude, andLatitude: coordinate.latitude, andTitle: "DroppedPin")
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                                  longitude: coordinate.longitude,
                                                  zoom: 15.0)
            self.selectedLat = String(coordinate.latitude)
            self.selectedLng = String(coordinate.longitude)
            self.mapView.camera = camera
        }
        
    }
   

    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
         DispatchQueue.main.async {
            self.mapView.clear()
            self.selectedLat = String(lat)
            self.selectedLng = String(lon)
            let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: lon,
                                              zoom: self.zoomLevel)
            self.mapView.camera = camera
            marker.title = " \(title)"
            marker.map = self.mapView
            print("destination is : lng: \(self.selectedLng)...... lat: \(self.selectedLat)")
    }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placeClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.establishment
        filter.country = "SA"
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: filter) { (results, error) in
            self.resultArray.removeAll()
            if results == nil{
                return
            }
            for result in results!{
                if let result = result as? GMSAutocompletePrediction{
                   
                    self.resultArray.append(result.attributedFullText.string)
                }
                
            }
        }
        self.searchResultContriller.reloadDataWithArray(self.resultArray)

    }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vcs = self.navigationController?.viewControllers {
                let previousVC = vcs[vcs.count - 2]
                if previousVC is MainVC {
                    if segue.identifier == "ToMainVC"{
                        let vc = segue.destination as! MainVC
    
                        vc.selectLat = self.selectedLat
                        vc.selectLng = self.selectedLng
    
    
                    }
                }
            }
    
        }
    
        @IBAction func approveBtnPressed(_ sender: Any) {
            // Perform your custom actions
            // ...
            // Go back to the previous ViewController
            if let vcs = self.navigationController?.viewControllers {
                let previousVC = vcs[vcs.count - 2]
                if previousVC is MainVC {
                   performSegue(withIdentifier: "ToMainVC", sender: self)
                }
                else{
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "TripCalculatorVC") as! TripCalculatorVC
                    newViewController.selectLat = self.selectedLat
                    newViewController.selectLng = self.selectedLng
                    self.show(newViewController, sender: self)
    
    
                }
            }
    
}
}
    
extension LocationVC: CLLocationManagerDelegate{
    
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
        } else {
            mapView.animate(to: camera)
        }
        locationManager.stopUpdatingLocation()

        listLikelyPlaces()
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
    
        func listLikelyPlaces() {
            // Clean up from previous sessions.
            likelyPlaces.removeAll()
            
            placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
                if let error = error {
                    // TODO: Handle the error.
                    print("Current Place error: \(error.localizedDescription)")
                    return
                }
                
                // Get likely places and add to the list.
                if let likelihoodList = placeLikelihoods {
                    for likelihood in likelihoodList.likelihoods {
                        let place = likelihood.place
                        self.likelyPlaces.append(place)
                    }
                }
            })
        }
        
    }

