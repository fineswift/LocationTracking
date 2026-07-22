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
    
    private var authContinuation: AsyncStream<LocationAuthorization>.Continuation?
    private var locationContinuation: AsyncStream<TrackedLocation>.Continuation?
    
    var currentAuthorizationSuatus: LocationAuthorization {
        mapAuthorizationStatus(manager.authorizationStatus)
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func authorizationUpdates() -> AsyncStream<LocationAuthorization> {
        let (stream, continuation) = AsyncStream.makeStream(of: LocationAuthorization.self)
        
        authContinuation = continuation
        continuation.yield(mapAuthorizationStatus(manager.authorizationStatus))
        
        continuation.onTermination = { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.authContinuation = nil
            }
        }
        
        return stream
    }
    
    func start() -> AsyncStream<TrackedLocation> {
        let (stream, continuation) = AsyncStream.makeStream(of: TrackedLocation.self)
        
        locationContinuation = continuation
        manager.startUpdatingLocation()
        
        continuation.onTermination = { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.locationContinuation = nil
            }
        }
        
        return stream
    }

    func stop() {
        manager.stopUpdatingLocation()
        locationContinuation?.finish()
        locationContinuation = nil
    }
    
    private func mapAuthorizationStatus(_ status: CLAuthorizationStatus) -> LocationAuthorization {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        default:
            return .notDetermined
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let domainAuth = mapAuthorizationStatus(manager.authorizationStatus)
        authContinuation?.yield(domainAuth)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let tracked = TrackedLocation(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            timestamp: location.timestamp,
            activity: "추적중"
        )
        locationContinuation?.yield(tracked)
    }
}
