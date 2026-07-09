//
//  LocationService.swift
//  LocationTracking
//
//  Created by Pineone on 7/8/26.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, LocationTrackingUseCase {
    private let manager = CLLocationManager()

    func start() -> AsyncStream<TrackedLocation> {
        AsyncStream { _ in }
    }

    func stop() {
    }
}
