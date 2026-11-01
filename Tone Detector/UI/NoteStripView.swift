//
//  NoteStripView.swift
//  Tone Detector
//
//  Created by 杨哲仁 on 5/23/26.
//

import SwiftUI

struct NoteStripView: View {
	let pitch_info: PitchInfo

	var body: some View {
		let center_midi = pitch_info.is_valid ? pitch_info.midi : 69
		let display_midis = (-4...4).map { center_midi + $0 }

		HStack(spacing: 42) {
			ForEach(
				Array(display_midis.enumerated()),
				id: \.offset
			) { index, midi in
				let distance = abs(index - 4)

				NoteItemView(
					midi: midi,
					is_center: index == 4,
					distance: distance
				)
				.frame(
					width: index == 4 ? 130 : 85,
					height: 130
				)
			}
		}
		.frame(height: 150)
		.frame(maxWidth: .infinity)
	}
}

struct NoteItemView: View {
	let midi: Int
	let is_center: Bool
	let distance: Int

	private var note: String {
		PitchMath.note_name(for: midi)
	}

	private var octave: Int {
		PitchMath.octave(for: midi)
	}

	private var base_note: String {
		note.replacingOccurrences(of: "♯", with: "")
	}

	private var has_sharp: Bool {
		note.contains("♯")
	}

	private var opacity: Double {
		if is_center {
			return 1
		}
		return max(0.12, 0.75 - Double(distance) * 0.12)
	}

	private var color: Color {
		is_center
			? Color(red: 1.0, green: 0.0, blue: 0.0)
			: Color(red: 0.14, green: 0.22, blue: 0.30)
	}

	private var base_font_size: CGFloat {
		is_center ? 96 : 64
	}

	private var mark_font_size: CGFloat {
		is_center ? 34 : 22
	}

	private var note_font: Font {
		.system(size: base_font_size, weight: .bold, design: .rounded)
	}

	private var mark_font: Font {
		.system(size: mark_font_size, weight: .bold, design: .rounded)
	}

	var body: some View {
		HStack(alignment: .center, spacing: 2) {
			Text(base_note)
				.font(note_font)

			accidental_and_octave
		}
		.foregroundStyle(color.opacity(opacity))
		.lineLimit(1)
		.minimumScaleFactor(0.7)
	}

	private var accidental_and_octave: some View {
		VStack(spacing: is_center ? 2 : 0) {
			Text(has_sharp ? "♯" : "")
				.font(mark_font)
				.frame(height: is_center ? 34 : 22)

			Text("\(octave)")
				.font(mark_font)
				.frame(height: is_center ? 34 : 22)
		}
		.offset(y: is_center ? 14 : 8)
	}
}
