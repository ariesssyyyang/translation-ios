//
//  ReplaceTranslationView.swift
//  TranslationLab
//
//  Created by Aries on 2025/1/16.
//

import SwiftUI
import Translation

struct ReplaceTranslationView: View {

    private typealias TranslationConfiguration = TranslationSession.Configuration
    private typealias LocaleLanguage = Locale.Language

    @State private var configuration: TranslationConfiguration?
    @State private var targetText: String?

    @State private var sourceText = """
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    """

    var body: some View {
        VStack {
            Text(targetText ?? sourceText)

            Spacer()

            Button("Translate") {
                if configuration == nil {
                    configuration = TranslationSession.Configuration(source: LocaleLanguage(identifier: "en-US"),
                                                                     target: LocaleLanguage(identifier: "zh-Hant-TW"))
                } else {
                    configuration?.invalidate()
                }
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .translationTask(configuration) { session in
            do {
                let response = try await session.translate(sourceText)
                targetText = response.targetText
            } catch {
                print("Error", error)
            }
        }
    }
}
