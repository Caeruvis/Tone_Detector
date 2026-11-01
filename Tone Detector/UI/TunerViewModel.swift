//
//  TunerViewModel.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Combine
import Foundation

@MainActor
final class TunerViewModel: ObservableObject {
	@Published var pitch_info: PitchInfo = .empty

	private let audio_manager = AudioManager()

	init()
	{
		audio_manager.on_pitch_detected = { [weak self] frequency in
			guard let self else {
				return
			}

			self.pitch_info = PitchMath.make_pitch_info(
				frequency: frequency
			)
		}
	}

	func start()
	{
		do {
			try audio_manager.start()
		} catch {
			print(error)
		}
	}

	func stop()
	{
		audio_manager.stop()
	}
}
