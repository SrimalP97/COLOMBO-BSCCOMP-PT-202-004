//
//  LocationManagerHelper.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI
import CoreLocation

class LocationManagerHelper: NSObject ,ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userlocation: CLLocation!
    @Published var userLong = "0"
    @Published var userLati = "0"
    @Published var userAddress = ""
    @Published var noLocation = false
    
    let defaults = UserDefaults.standard
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            noLocation = false
            manager.requestLocation()
        case .authorizedAlways:
            noLocation = false
            manager.requestLocation()
        case .denied:
            noLocation = true
        default:
            noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userlocation = locations.last
        self.userLati = "\(self.userlocation.coordinate.latitude)"
        self.userLong = "\(self.userlocation.coordinate.longitude)"
        self.getLocationAddress(location:  self.userlocation)
    }
    
    func getLocationAddress(location:CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
            var placemark:CLPlacemark!
            if error == nil && placemarks!.count > 0 {
                placemark = placemarks![0] as CLPlacemark
                self.userAddress = placemark.administrativeArea!
                self.defaults.setValue(self.userAddress, forKey: "province")
            }
        })
    }
    

}


