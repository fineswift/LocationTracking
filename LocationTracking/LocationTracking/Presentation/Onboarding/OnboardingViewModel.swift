//
//  OnboardingViewModel.swift
//  LocationTracking
//
//  Created by Pineone on 7/15/26.
//

import SwiftUI

@MainActor
@Observable
final class OnboardingViewModel {
    private let useCase: LocationTrackingUseCase = LocationService()
    
    var authorizationStatus: LocationAuthorization
    var showAlwaysUpgradeAlert: Bool = false
    
    private var isStarted = false
    
    init() {
        authorizationStatus = useCase.currentAuthorizationSuatus
    }
    
    func startMonitoringAuth() {
        guard !isStarted else { return }
        isStarted = true
        
        Task {
            for await status in useCase.authorizationUpdates() {
                authorizationStatus = status
                
                if status == .authorizedWhenInUse {
                    showAlwaysUpgradeAlert = true
                } else if status == .authorizedAlways {
                    showAlwaysUpgradeAlert = false
                }
            }
        }
    }
    
    func requestAuthorization() {
        useCase.requestAuthorization()
    }
    
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
