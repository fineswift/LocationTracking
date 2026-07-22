//
//  TrackedLocation.swift
//  LocationTracking
//
//  Created by Pineone on 7/8/26.
//

import Foundation
import CoreLocation

struct TrackedLocation: Equatable {
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    let activity: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
