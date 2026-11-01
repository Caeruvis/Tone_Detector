//
//  ContentView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TunerViewModel()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()

                TunerDialView(cents: viewModel.pitchInfo.cents)

                NoteStripView(pitchInfo: viewModel.pitchInfo)
                    .frame(height: 150)
                    .padding(.top, 8)

                VStack(spacing: 24) {
                    HStack(spacing: 12) {
                        Text("current_value")
                        Text(
                            viewModel.pitchInfo.isValid
                            ? String(format: "%.2f", viewModel.pitchInfo.frequency)
                            : "--"
                        )
                        Text("hz")
                    }

                    HStack(spacing: 12) {
                        Text("standard_value")
                        Text(
                            viewModel.pitchInfo.isValid
                            ? String(format: "%.2f", viewModel.pitchInfo.targetFrequency)
                            : "--"
                        )
                        Text("hz")
                    }
                }
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color(red: 0.14, green: 0.22, blue: 0.30))
                .padding(.top, 12)

                Spacer()
            }
        }
        .onAppear {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
}

#Preview {
    ContentView()
}
