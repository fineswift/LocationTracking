//
//  MainViewModel.swift
//  LocationTracking
//
//  Created by Pineone on 7/15/26.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
@Observable
final class MainViewModel {
    private let useCase: LocationTrackingUseCase = LocationService()
    
    var currentLocation: TrackedLocation? = nil
    
    private var isStarted = false
    
    func startLocationTracking() {
        guard !isStarted else { return }
        isStarted = true
        
        Task {
            for await location in useCase.start() {
                currentLocation = location
            }
        }
    }
}
