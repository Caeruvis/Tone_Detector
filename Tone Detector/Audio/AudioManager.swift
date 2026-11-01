//
//  AudioManager.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation
import AudioKit
import SoundpipeAudioKit
import AVFoundation

final class AudioManager {
    private let engine = AudioEngine()
    private var pitchTap: PitchTap?

    private var smoothedFrequency: Float = 0

    var onPitchDetected: ((Float) -> Void)?

    func start() throws {
        guard let input = engine.input else {
            return
        }

        engine.output = Mixer(input)

        pitchTap = PitchTap(input) { [weak self] pitches, amplitudes in
            guard let self else { return }

            guard let pitch = pitches.first else { return }
            guard let amplitude = amplitudes.first else { return }

            let frequency = Float(pitch)
            let amp = Float(amplitude)

            guard amp > 0.08 else {
                return
            }

            guard frequency >= 20, frequency <= 200000 else {
                return
            }

            if self.smoothedFrequency == 0 {
                self.smoothedFrequency = frequency
            } else {
                self.smoothedFrequency =
                    self.smoothedFrequency * 0.82 + frequency * 0.18
            }

            DispatchQueue.main.async {
                self.onPitchDetected?(self.smoothedFrequency)
            }
        }

        try engine.start()
        pitchTap?.start()
    }

    func stop() {
        pitchTap?.stop()
        engine.stop()
        smoothedFrequency = 0
    }
}
