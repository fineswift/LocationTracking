//
//  OnboardingView.swift
//  LocationTracking
//
//  Created by Pineone on 7/15/26.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            headerView
            description
            
            Spacer()
            
            startButton
        }
        .task {
            viewModel.startMonitoringAuth()
        }
        .alert("항상 허용 권한이 필요합니다.", isPresented: $viewModel.showAlwaysUpgradeAlert) {
            Button("설정으로 이동", role: .none) {
                viewModel.openSettings()
            }
            
            Button("나중에", role: .cancel) {}
        } message: {
            Text("지오펜싱 및 백그라운드 위치 추적을 위해 설정 화면에서 위치 권한을 '항상 허용'으로 변경해주세요.")
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            Image(systemName: "location.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("백그라운드 위치 모니터링")
                .font(.title.bold())
        }
    }
    
    private var description: some View {
        Text("앱을 종료하거나 스마트폰 화면이 꺼져 있어도 안전하게 위치를 기록하려면 **[항상 허용]** 권한이 필요합니다.")
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
    }
    
    private var startButton: some View {
        Button {
            viewModel.requestAuthorization()
        } label: {
            Text("위치 권한 시작하기")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .cornerRadius(12)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
}
