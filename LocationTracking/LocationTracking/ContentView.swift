//
//  ContentView.swift
//  LocationTracking
//
//  Created by Pineone on 7/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        Group {
            if onboardingViewModel.authorizationStatus == .authorizedAlways {
                MainView()
            } else {
                OnboardingView(viewModel: $onboardingViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
