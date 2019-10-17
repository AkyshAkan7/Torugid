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

    
    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        
        let markerALocation = CLLocationCoordinate2DMake(43.157410, 77.058953)
        let markerA = GMSMarker(position: markerALocation)
        markerA.title = "Спортивный Комплекс МЕДЕУ"
        markerA.map = mapView
        
        let markerBLocation = CLLocationCoordinate2DMake(43.050510, 76.985011)
        let markerB = GMSMarker(position: markerBLocation)
        markerB.title = "Большое Алматинское озеро"
        markerB.map = mapView
        
        let markerCLocation = CLLocationCoordinate2DMake(43.162839, 77.048591)
        let markerC = GMSMarker(position: markerCLocation)
        markerC.title = "Shymbylak Mountain resort"
        markerC.map = mapView
        
        let markerDLocation = CLLocationCoordinate2DMake(43.129805, 76.905049)
        let markerD = GMSMarker(position: markerDLocation)
        markerD.title = "Кок-Тюбе"
        markerD.map = mapView
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locationManager.location?.coordinate
        
        if let location = location {
            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: 13)
        }
    }
}
