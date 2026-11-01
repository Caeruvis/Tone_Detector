//
//  PitchMath.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation

enum PitchMath {
	static let note_names = [
		"C", "C♯", "D", "D♯", "E", "F",
		"F♯", "G", "G♯", "A", "A♯", "B"
	]

	static func make_pitch_info(frequency: Float) -> PitchInfo
	{
		guard frequency > 20 else {
			return .empty
		}

		let midi_value = 69 + 12 * log2(frequency / 440)
		let midi = Int(round(midi_value))

		let note_index = ((midi % 12) + 12) % 12
		let octave = midi / 12 - 1

		let target_frequency = 440 * pow(2, Float(midi - 69) / 12)
		let cents = 1200 * log2(frequency / target_frequency)

		return PitchInfo(
			frequency: frequency,
			target_frequency: target_frequency,
			note_name: note_names[note_index],
			octave: octave,
			cents: cents,
			midi: midi,
			is_valid: true
		)
	}

	static func note_name(for midi: Int) -> String
	{
		let index = ((midi % 12) + 12) % 12
		return note_names[index]
	}

	static func octave(for midi: Int) -> Int
	{
		midi / 12 - 1
	}
}
