//
//  PitchInfo.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation

struct PitchInfo {
    let frequency: Float
    let targetFrequency: Float
    let noteName: String
    let octave: Int
    let cents: Float
    let midi: Int
    let isValid: Bool

    static let empty = PitchInfo(
        frequency: 0,
        targetFrequency: 0,
        noteName: "--",
        octave: 0,
        cents: 0,
        midi: 0,
        isValid: false
    )
}
