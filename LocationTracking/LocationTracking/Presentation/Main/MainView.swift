//
//  MainView.swift
//  LocationTracking
//
//  Created by Pineone on 7/15/26.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var viewModel = MainViewModel()
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                mapView
                
                Divider()
            }
            .navigationTitle("위치 모니터링")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    pathNavigationButton
                }
            }
        }
        .task {
            viewModel.startLocationTracking()
        }
    }
    
    private var mapView: some View {
        Map(position: $cameraPosition) {
            if let loc = viewModel.currentLocation {
                Marker("내 위치 (\(loc.activity))", coordinate: loc.coordinate)
                .tint(.blue)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.45)
        .onChange(of: viewModel.currentLocation) { _, newValue in
            if let loc = newValue {
                withAnimation {
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: loc.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                        )
                    )
                }
            }
        }
    }
    
    private var pathNavigationButton: some View {
        NavigationLink(destination: PathView()) {
            HStack(spacing: 4) {
                Text("경로")
                Image(systemName: "chevron.right")
            }
            .font(.subheadline.bold())
        }
    }
}
