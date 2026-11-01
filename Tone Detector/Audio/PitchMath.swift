//
//  PitchMath.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation
import Foundation

enum PitchMath {
    static let noteNames = [
        "C", "C♯", "D", "D♯", "E", "F",
        "F♯", "G", "G♯", "A", "A♯", "B"
    ]

    static func makePitchInfo(frequency: Float) -> PitchInfo {
        guard frequency > 20 else {
            return .empty
        }

        let midiFloat = 69 + 12 * log2(frequency / 440)
        let midi = Int(round(midiFloat))

        let noteIndex = ((midi % 12) + 12) % 12
        let octave = midi / 12 - 1

        let targetFrequency = 440 * pow(2, Float(midi - 69) / 12)
        let cents = 1200 * log2(frequency / targetFrequency)

        return PitchInfo(
            frequency: frequency,
            targetFrequency: targetFrequency,
            noteName: noteNames[noteIndex],
            octave: octave,
            cents: cents,
            midi: midi,
            isValid: true
        )
    }

    static func noteName(for midi: Int) -> String {
        let index = ((midi % 12) + 12) % 12
        return noteNames[index]
    }

    static func octave(for midi: Int) -> Int {
        midi / 12 - 1
    }
}
