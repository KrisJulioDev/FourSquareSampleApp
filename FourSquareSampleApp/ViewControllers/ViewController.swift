//
//  ViewController.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 15/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, VenueDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    final let venueDetailSegue = "showDetails"
    let locationManager = CLLocationManager()
    var initialFetchDone = false
    
    lazy var viewModel: MapViewModel = {
        return MapViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initializeLocationService()
        fetchVenues()
    }
    
    func configureUI() {
        mapView.mapType = MKMapType.hybrid
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        tableView.register(VenueCell.self, forCellReuseIdentifier: VenueCell.reuseIdentifier)
    }
    
    func initializeLocationService() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? VenueDetailsViewController,
            let venue = sender as? Venue
        else {
            // handle other case if any
            return
        }
        destination.venue = venue
    }
    
    // MARK: Actions
    @IBAction func fetchVenues() {
        guard let location = mapView.userLocation.location else {
            return
        }
        
        // viewModel will fetch for venues and feed it to venue observable
        viewModel.fetchNearVenues(location: location.coordinate)
        initialFetchDone = true
    }
    
    // MARK: Venue Datasource
    func refreshData() {
        tableView.reloadData()
        plotMarkOnVenues()
    }
    
    func plotMarkOnVenues() {
        // clear marker first
        mapView.removeAnnotations(mapView.annotations)
        
        viewModel.venues.forEach { (venue) in
            let marker = MKPointAnnotation()
            marker.title = venue.name
            marker.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            mapView.addAnnotation(marker)
        }
    }
    
    func showError(_ error: ResponseError) {
        let alert = UIAlertController.init(title: error.title, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: TableView Delegate and Data source
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VenueCell.reuseIdentifier, for: indexPath)
        
        guard let venueCell = cell as? VenueCell else {
            return cell
        }
        
        // get venue model and assign values to cell components
        let venue = viewModel.venues[indexPath.row]
        venueCell.configure(name: venue.name, distance: venue.location.distance)
        
        return venueCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.venues.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venue = viewModel.venues[indexPath.row]
        performSegue(withIdentifier: venueDetailSegue, sender: venue)
    }
}

// MARK: MapKit Delegate
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        // center to user and fetch on load only once
        guard initialFetchDone == false else {
            return
        }
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(viewRegion, animated: false)
        fetchVenues()
    }
}
