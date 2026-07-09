//
//  LocationTrackingUseCase.swift
//  LocationTracking
//
//  Created by Pineone on 7/8/26.
//

import Foundation

protocol LocationTrackingUseCase {
    func requestAuthorization()
    func authorizationUpdates() -> AsyncStream<LocationAuthorization>
    func start() -> AsyncStream<TrackedLocation>
    func stop()
}
