//
//  LocationAuthorization.swift
//  LocationTracking
//
//  Created by Pineone on 7/9/26.
//

import Foundation

enum LocationAuthorization {
    case notDetermined
    case restricted
    case denied
    case authorizedWhenInUse
    case authorizedAlways
    
    var allowsUpdates: Bool {
        self == .authorizedWhenInUse || self == .authorizedAlways
    }
}
