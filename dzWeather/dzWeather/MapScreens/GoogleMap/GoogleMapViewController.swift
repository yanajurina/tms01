//
//  GoogleMapViewController.swift
//  dzWeather
//
//  Created by Янина on 4.11.21.
//

import UIKit
import GoogleMaps
import CoreLocation
import RxSwift

class GoogleMapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()

    
    var dataWeather: DataWeather? {
        didSet {
            DispatchQueue.main.async {
                self.setup()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
//        let marker = GMSMarker(position: CLLocationCoordinate2D)
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        //        tapGesture.delegate = self
        //        map.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation { result in
            guard result else { return }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func setup() {
        guard let dataWeather = dataWeather  else { return }
//        cityNameLabel.text = dataWeather.city
//        dataLabel.text = "\(dataWeather.data)"
//        tempLabel.text = "\(Int(dataWeather.temp - 273.15))°C"
//        tempTextLabel.text = dataWeather.description
//        windSpeedLabel.text = "wind \(dataWeather.windSpeed)"
//        humidityLabel.text = "humidity \(dataWeather.humidity)%"
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
    
    //    @objc func tap(_ recognizer: UITapGestureRecognizer) {
    //        let point: CGPoint = recognizer.location(in: map)
    //        let tapPoint: CLLocationCoordinate2D = map.convert(point, toCoordinateFrom: map)
    //        let pointAnotation = MKPointAnnotation()
    //        pointAnotation.coordinate = tapPoint
    //        map.addAnnotation(pointAnotation)
    //
    //    }
}
extension GoogleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard (locations.first?.coordinate) != nil else { return }
    }
}
extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("willMove")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("didChange position \(position.target)")
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt \(position.target)")
    }
}
