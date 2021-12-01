//
//  AppleMapViewController.swift
//  dzWeather
//
//  Created by Янина on 30.10.21.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift

class AppleMapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempTextLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let anotation = MKPointAnnotation()
    let coordinate = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D())
    let disposeBag = DisposeBag()
    var dispatchItem: DispatchWorkItem?
    var dataWeather: DataWeather? {
        didSet {
            DispatchQueue.main.async {
                self.setup()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinate
            .debounce(DispatchTimeInterval.seconds(5), scheduler: MainScheduler.instance)
            .subscribe( onNext: { coordinate in
                self.httpManagerGetDataLocation()
            })
            .disposed(by: disposeBag)
        
        map.showsUserLocation = true
        map.delegate = self
        anotation.coordinate = map.userLocation.coordinate
        map.setCenter(map.userLocation.coordinate, animated: true)
        map.addAnnotation(anotation)
        let coor = map.userLocation.coordinate
        HttpManager.shared.getDataLocation(locationLat: "\(coor.latitude)", locationLon: "\(coor.longitude)") { dataWeather in
            self.dataWeather = dataWeather
        }
    }
    
    func httpManagerGetDataLocation () {
        HttpManager.shared.getDataLocation(locationLat: "\(map.centerCoordinate.latitude)", locationLon: "\(map.centerCoordinate.longitude)") { dataWeather in
            self.dataWeather = dataWeather
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation { result in
            guard result else { return }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func setup() {
        guard let dataWeather = dataWeather  else { return }
        cityNameLabel.text = dataWeather.city
        tempLabel.text = "\(Int(dataWeather.temp - 273.15))°C"
        tempTextLabel.text = dataWeather.description
        windSpeedLabel.text = "wind \(dataWeather.windSpeed)"
        humidityLabel.text = "humidity \(dataWeather.humidity)%"
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
            completion(true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default: break
        }
    }
}

extension AppleMapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        anotation.coordinate = mapView.centerCoordinate
        coordinate.onNext(mapView.centerCoordinate)
        
//        self.dispatchItem?.cancel()
//        self.dispatchItem = DispatchWorkItem {
//            guard self.dispatchItem?.isCancelled == false else { return }
//            self.httpManagerGetDataLocation()
////            let location = CLLocation(latitude: self.map.centerCoordinate.latitude, longitude: self.map.centerCoordinate.longitude)
////            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en")) { placemark, error in
////                if let _ = error {
////                    self.cityNameLabel.text = "error"
////                }
////                else {
////                    guard let place = placemark?.first else { return }
////                    let city = "\(place.country ?? "") \(place.city ?? "")"
////                    self.cityNameLabel.text = city
////                }
////            }
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.dispatchItem!)
        
    }
}

//extension CLPlacemark {
//    /// street name, eg. Infinite Loop
//    var streetName: String? { thoroughfare }
//    /// // eg. 1
//    var streetNumber: String? { subThoroughfare }
//    /// city, eg. Cupertino
//    var city: String? { locality }
//    /// neighborhood, common name, eg. Mission District
//    var neighborhood: String? { subLocality }
//    /// state, eg. CA
//    var state: String? { administrativeArea }
//    /// county, eg. Santa Clara
//    var county: String? { subAdministrativeArea }
//    /// zip code, eg. 95014
//    var zipCode: String? { postalCode }
//}
