//
//  VenueDetailsViewController.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 16/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import UIKit
import MapKit

class VenueDetailsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var category: UILabel!
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeMapView()
        setupUI()
    }
    
    
    func initializeMapView() {
        mapView.mapType = MKMapType.hybrid
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
    }
    
    func setupUI() {
        guard let venue = venue else {
            return
        }
        
        let venueMarker = MKPointAnnotation()
        venueMarker.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        venueMarker.title = venue.name
        mapView.addAnnotation(venueMarker)
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(venueMarker.coordinate, 200, 200)
        mapView.setRegion(viewRegion, animated: false)
        
        // set center to venue
        let venueLocation = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        mapView.setCenter(venueLocation, animated: true)
        
        name.text = venue.name
        address.text = venue.location.formattedAddress?.joined(separator: "\n")
        distance.text = "\(venue.location.distance) meters"
        category.text = venue.categories.first?.name ?? "none"
    }
}
