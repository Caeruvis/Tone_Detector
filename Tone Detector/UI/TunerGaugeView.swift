//
//  TunerGaugeView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct TunerGaugeView: View {
    let cents: Float
    let isValid: Bool

    private var clampedCents: Float {
        min(max(cents, -50), 50)
    }

    private var angle: Double {
        Double(clampedCents / 50) * 45
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(.secondary.opacity(0.25), lineWidth: 8)
                .frame(width: 240, height: 240)

            Rectangle()
                .fill(isValid ? .primary : .secondary)
                .frame(width: 4, height: 100)
                .offset(y: -50)
                .rotationEffect(.degrees(angle))
                .animation(.easeOut(duration: 0.08), value: angle)

            VStack {
                Spacer()

                HStack {
                    Text("♭")
                    Spacer()
                    Text("0")
                    Spacer()
                    Text("♯")
                }
                .font(.title2)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
            .frame(width: 260, height: 260)
        }
    }
}
