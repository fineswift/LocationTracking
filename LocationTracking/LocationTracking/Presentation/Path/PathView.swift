//
//  PathView.swift
//  LocationTracking
//
//  Created by Pineone on 7/15/26.
//

import SwiftUI

struct PathView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "point.topleft.down.curvedto.point.bottomright.up.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("과거 이동 경로 화면")
                .font(.title2.bold())
            
            Text("4·5단계에서 로컬 저장소(TrackStore) 및 지오펜싱이 연동되면,\n이 화면에서 과거 이동 경로 선(Polyline)과 방문 시간 이력을 확인할 수 있습니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .navigationTitle("이동 경로")
        .navigationBarTitleDisplayMode(.inline)
    }
}
