//
//  ContentView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var view_model = TunerViewModel()

	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()
			tuner_content
		}
		.onAppear {
			view_model.start()
		}
		.onDisappear {
			view_model.stop()
		}
	}

	private var tuner_content: some View {
		VStack {
			Spacer()

			TunerDialView(cents: view_model.pitch_info.cents)

			NoteStripView(pitch_info: view_model.pitch_info)
				.frame(height: 150)
				.padding(.top, 8)

			frequency_readings

			Spacer()
		}
	}

	private var frequency_readings: some View {
		VStack(spacing: 24) {
			frequency_row(
				"current_value",
				frequency: view_model.pitch_info.frequency
			)
			frequency_row(
				"standard_value",
				frequency: view_model.pitch_info
					.target_frequency
			)
		}
		.font(.system(size: 20, weight: .semibold))
		.foregroundStyle(Color(red: 0.14, green: 0.22, blue: 0.30))
		.padding(.top, 12)
	}

	private func frequency_row(
		_ label: LocalizedStringKey,
		frequency: Float
	) -> some View
	{
		let value =
			view_model.pitch_info.is_valid
			? String(format: "%.2f", frequency)
			: "--"

		return HStack(spacing: 12) {
			Text(label)
			Text(value)
			Text("hz")
		}
	}
}

#Preview {
	ContentView()
}
