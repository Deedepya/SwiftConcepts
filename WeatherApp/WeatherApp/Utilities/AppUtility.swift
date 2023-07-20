//
//  AppUtility.swift
//  WeatherApp
//
//  Created by dedeepya reddy salla on 03/06/23.
//

import CoreLocation

protocol AppUtilityProtocol: AnyObject {
    func locationUpdated()
}

class AppUtility: NSObject {

    private var locationManager: CLLocationManager?
    weak var delegate: AppUtilityProtocol?
    
    override init() {
        super.init()
    }
    
    // MARK: - Request Permissions
    func requestUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate methods
extension AppUtility: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let coordinates = Coordinates(lon: userLocation.coordinate.longitude, lat: userLocation.coordinate.latitude)
        coordinates.setEncodedData(toObject: &UserDefaults.currentLocation)
        delegate?.locationUpdated()
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
