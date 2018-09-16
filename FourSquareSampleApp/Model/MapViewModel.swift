//  Created by Khristoffer Julio on 14/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import MapKit

protocol VenueDelegate {
    /// Call everytime there's changes to venues
    func refreshData()
}

class MapViewModel {
    /// handles API request to venues
    private let apiClient = APIClient()
    
    /// reference to viewcontroller as we need to send updates when theres changes
    var delegate: VenueDelegate?
    
    /// list of venues fetched from apiclient and used to display data on delegate
    var venues: [Venue] = [Venue]() {
        didSet {
            delegate?.refreshData()
        }
    }
    
    init(delegate: VenueDelegate) {
        self.delegate = delegate
    }
    
    func fetchNearVenues(location: CLLocationCoordinate2D) {
        let request = VenueRequest(version: versionDateString(), coordinate: location)
        apiClient.fetchVenusWithRequest(request) { [weak self] (success, data, error) in
            guard
                success,
                let newVenues = data?.response.venues
            else {
                return
            }
            self?.venues = newVenues
        }
    }
    
    func versionDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMDD"
        return formatter.string(from: Date())
    }
}

