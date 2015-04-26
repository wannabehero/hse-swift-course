//
//  MapViewController.swift
//  HSEProject
//
//  Created by Sergey Pronin on 4/21/15.
//  Copyright (c) 2015 Sergey Pronin. All rights reserved.
//

import UIKit
//!! не забыть импортировать
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 55, longitude: 37)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Near Moscow"
        annotation.subtitle = "Hello!"
        mapView.addAnnotation(annotation)
        
        let coordinate2 = CLLocationCoordinate2D(
            latitude: 37, longitude: 55)
        var coordinates = [coordinate, coordinate2]
        let overlay = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        
        mapView.addOverlay(overlay)
        
        mapView.region = MKCoordinateRegionMake(coordinate, MKCoordinateSpan(latitudeDelta: 10,
                longitudeDelta: 10))
    }
}


extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        view.pinColor = .Green
        view.canShowCallout = true
        
        return view
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 4
        renderer.strokeColor = UIColor.redColor()
        
        return renderer
    }
}

