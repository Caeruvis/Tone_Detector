//
//  AudioManager.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import AudioKit
import AVFoundation
import Foundation
import SoundpipeAudioKit

final class AudioManager {
	private let engine = AudioEngine()
	private var pitch_tap: PitchTap?

	private var smoothed_frequency: Float = 0

	var on_pitch_detected: ((Float) -> Void)?

	func start() throws
	{
		guard let input = engine.input else {
			return
		}

		engine.output = Mixer(input)

		pitch_tap = PitchTap(input) { [weak self] pitches, amplitudes in
			guard let self else {
				return
			}

			guard let pitch = pitches.first else {
				return
			}
			guard let amplitude = amplitudes.first else {
				return
			}

			self.update_frequency(
				Float(pitch),
				amplitude: Float(amplitude)
			)
		}

		try engine.start()
		pitch_tap?.start()
	}

	func stop()
	{
		pitch_tap?.stop()
		engine.stop()
		smoothed_frequency = 0
	}

	private func update_frequency(_ frequency: Float, amplitude: Float)
	{
		guard amplitude > 0.08 else {
			return
		}

		guard frequency >= 20, frequency <= 200000 else {
			return
		}

		if smoothed_frequency == 0 {
			smoothed_frequency = frequency
		} else {
			smoothed_frequency =
				smoothed_frequency * 0.82 + frequency * 0.18
		}

		DispatchQueue.main.async {
			self.on_pitch_detected?(self.smoothed_frequency)
		}
	}
}
