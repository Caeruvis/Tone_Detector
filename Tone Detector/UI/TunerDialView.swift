//
//  TunerDialView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct TunerDialView: View {
    let cents: Float

    private var clampedCents: Float {
        min(max(cents, -50), 50)
    }

    private var needleAngle: Double {
        Double(clampedCents / 50) * 45
    }

    var body: some View {
        ZStack {
            ForEach(-5...5, id: \.self) { index in
                TickView(isMajor: index == 0 || index == -4 || index == 4)
                    .rotationEffect(.degrees(Double(index) * 9))
            }

            NeedleView()
                .rotationEffect(.degrees(needleAngle))
                .animation(.easeOut(duration: 0.12), value: needleAngle)
        }
        .frame(width: 360, height: 260)
    }
}

struct TickView: View {
    let isMajor: Bool

    var body: some View {
        Rectangle()
            .fill(Color(red: 0.14, green: 0.22, blue: 0.30))
            .frame(width: isMajor ? 3 : 2, height: isMajor ? 28 : 14)
            .offset(y: -120)
    }
}

struct NeedleView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.14, green: 0.22, blue: 0.30))
                .frame(width: 3, height: 165)
                .offset(y: -82)

            Circle()
                .fill(Color(red: 0.14, green: 0.22, blue: 0.30))
                .frame(width: 14, height: 14)
        }
    }
}
