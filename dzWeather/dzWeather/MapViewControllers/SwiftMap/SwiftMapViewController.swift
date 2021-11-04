//
//  MapViewController.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit
import MapKit
import CoreLocation

class SwiftMapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let anotation_ = MKPointAnnotation()
    var dispatchItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.showsUserLocation = true
        map.delegate = self
        anotation_.coordinate = map.centerCoordinate
        map.addAnnotation(anotation_)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation { result in
            guard result else { return }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func setupLocation(_ completion: (Bool) -> ()) {
        guard CLLocationManager.locationServicesEnabled() else {
            completion(false)
            return
        }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .denied:
            completion(false)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default: break
        }
    }
}
extension SwiftMapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        anotation_.coordinate = mapView.centerCoordinate
        
        self.cityNameLabel.text = " "
        self.dispatchItem?.cancel()
        self.dispatchItem = DispatchWorkItem {
            guard self.dispatchItem?.isCancelled == false else { return }
            let location = CLLocation(latitude: self.map.centerCoordinate.latitude, longitude: self.map.centerCoordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en")) { placemark, error in
                if let _ = error {
                    self.cityNameLabel.text = "error"
                } else {
                    guard let place = placemark?.first else { return }
                    let street = "\(place.country ?? "") \(place.city ?? "")"
                    self.cityNameLabel.text = street
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.dispatchItem!)
    }
}
extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
}
