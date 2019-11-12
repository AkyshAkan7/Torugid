//
//  ViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 9/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class MapViewController: UIViewController {

    var zoom: Float = 13
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = locationManager.location?.coordinate

        if let location = location {
            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: zoom)
        }
        
        mapView.isMyLocationEnabled = true
        setupLocationManager()
        addMarkers()
    }
    
    @IBAction func centerOnUserLocation(_ sender: Any) {
        let location = locationManager.location?.coordinate
        
        if let location = location {
            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: zoom)
        }
    }
    
    
    @IBAction func zoomInButton(_ sender: Any) {
        if zoom < 20 {
            zoom += 0.7
        }

        mapView.animate(toZoom: zoom)
    }
    
    @IBAction func zoomOutButton(_ sender: Any) {
        if zoom > 10 {
            zoom -= 0.7
        }
        
        mapView.animate(toZoom: zoom)
    }
    
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func addMarkers() {
        let markerALocation = CLLocationCoordinate2DMake(43.157410, 77.058953)
        let markerA = GMSMarker(position: markerALocation)
        markerA.title = "Спортивный Комплекс МЕДЕУ"
        markerA.snippet = "Комплекс с катком"
        markerA.map = mapView
        
        let markerBLocation = CLLocationCoordinate2DMake(43.050510, 76.985011)
        let markerB = GMSMarker(position: markerBLocation)
        markerB.title = "Большое Алматинское озеро"
        markerB.snippet = "Озеро, Гора и Каньон"
        markerB.map = mapView
        
        let markerCLocation = CLLocationCoordinate2DMake(43.162839, 77.048591)
        let markerC = GMSMarker(position: markerCLocation)
        markerC.title = "Shymbylak Mountain resort"
        markerC.snippet = "Живописный лыжный курорт"
        markerC.map = mapView
        
        let markerDLocation = CLLocationCoordinate2DMake(43.129805, 76.905049)
        let markerD = GMSMarker(position: markerDLocation)
        markerD.title = "Кок-Тюбе"
        markerD.snippet = "Гора"
        markerD.map = mapView
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locationManager.location?.coordinate
//
//        if let location = location {
//            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: zoom)
//        }
//    }
}