//  Created by Khristoffer Julio on 14/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import Alamofire
import MapKit

class APIClient {
    func fetchVenusWithRequest(_ request: VenueRequest, completion: @escaping (Bool, FourSquareVenues?, Error?) -> Void) {
            Alamofire.request(request.url, method: request.httpMethod, parameters: request.parameters)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success:
                        guard
                            let data = response.data,
                            let result = try? JSONDecoder().decode(FourSquareVenues.self, from: data)
                        else {
                            completion(true, nil, nil)
                            return
                        }
                        completion(true, result, nil)
                    case .failure(let error):
                        completion(false, nil, error)
                    }
                })
        }
} 
