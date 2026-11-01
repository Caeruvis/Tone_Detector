//
//  NoteStripView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct NoteStripView: View {
    let pitchInfo: PitchInfo

    var body: some View {
        let centerMidi = pitchInfo.isValid ? pitchInfo.midi : 69
        let displayMIDIs = (-4...4).map { centerMidi + $0 }

        HStack(spacing: 42) {
            ForEach(Array(displayMIDIs.enumerated()), id: \.offset) { index, midi in
                let distance = abs(index - 4)

                NoteItemView(
                    midi: midi,
                    isCenter: index == 4,
                    isLeading: index == 0,
                    distance: distance
                )
                .frame(width: index == 4 ? 130 : 85, height: 130)
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
}

struct NoteItemView: View {
    let midi: Int
    let isCenter: Bool
    let isLeading: Bool
    let distance: Int

    private var note: String {
        PitchMath.noteName(for: midi)
    }

    private var octave: Int {
        PitchMath.octave(for: midi)
    }

    private var baseNote: String {
        note.replacingOccurrences(of: "♯", with: "")
    }

    private var hasSharp: Bool {
        note.contains("♯")
    }

    private var opacity: Double {
        if isCenter { return 1 }
        return max(0.12, 0.75 - Double(distance) * 0.12)
    }

    private var color: Color {
        isCenter ? Color(red: 1.0, green: 0.0, blue: 0.0) : Color(red: 0.14, green: 0.22, blue: 0.30)
    }

    private var baseFontSize: CGFloat {
        isCenter ? 96 : 64
    }

    private var markFontSize: CGFloat {
        isCenter ? 34 : 22
    }

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Text(baseNote)
                .font(.system(size: baseFontSize, weight: .bold, design: .rounded))

            VStack(spacing: isCenter ? 2 : 0) {
                Text(hasSharp ? "♯" : "")
                    .font(.system(size: markFontSize, weight: .bold, design: .rounded))
                    .frame(height: isCenter ? 34 : 22)

                Text("\(octave)")
                    .font(.system(size: markFontSize, weight: .bold, design: .rounded))
                    .frame(height: isCenter ? 34 : 22)
            }
            .offset(y: isCenter ? 14 : 8)
        }
        .foregroundStyle(color.opacity(opacity))
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}
