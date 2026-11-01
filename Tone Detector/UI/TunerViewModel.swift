//
//  TunerViewModel.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import Foundation
import Combine

@MainActor
final class TunerViewModel: ObservableObject {

    @Published var pitchInfo: PitchInfo = .empty

    private let audioManager = AudioManager()

    init() {

        audioManager.onPitchDetected = { [weak self] frequency in

            guard let self else { return }

            self.pitchInfo =
                PitchMath.makePitchInfo(
                    frequency: frequency
                )
        }
    }

    func start() {

        do {
            try audioManager.start()
        } catch {
            print(error)
        }
    }

    func stop() {
        audioManager.stop()
    }
}
