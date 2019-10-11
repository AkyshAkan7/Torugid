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

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 43.235299, longitude: 76.909867, zoom: 13)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let UniversityLocation = CLLocationCoordinate2DMake(43.235299, 76.909867)
        let marker = GMSMarker(position: UniversityLocation)
        marker.title = "IITU University"
        marker.map = mapView
    }
    
}
