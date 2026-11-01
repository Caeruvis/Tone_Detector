//
//  PitchInfo.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation

struct PitchInfo {
	let frequency: Float
	let target_frequency: Float
	let note_name: String
	let octave: Int
	let cents: Float
	let midi: Int
	let is_valid: Bool

	static let empty = PitchInfo(
		frequency: 0,
		target_frequency: 0,
		note_name: "--",
		octave: 0,
		cents: 0,
		midi: 0,
		is_valid: false
	)
}
