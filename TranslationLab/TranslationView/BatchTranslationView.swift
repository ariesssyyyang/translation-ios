//
//  BatchTranslationView.swift
//  TranslationLab
//
//  Created by Aries on 2025/1/16.
//

import SwiftUI
import Translation

struct BatchTranslationView: View {

    private typealias TranslationConfiguration = TranslationSession.Configuration
    private typealias TranslationRequest = TranslationSession.Request
    private typealias LocaleLanguage = Locale.Language

    @State private var configuration: TranslationConfiguration?

    @State private var texts: [String] = [
        "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness.",
        "No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.",
        "Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.",
        "To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it?",
        "But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure? On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee",
    ]

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(texts, id: \.self) { text in
                        Text(text)
                    }
                    Spacer()
                }
            }

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
            let requests = texts.enumerated().map { index, sourceText in
                TranslationRequest(sourceText: sourceText, clientIdentifier: "\(index)")
            }
            do {
                for try await response in session.translate(batch: requests) {
                    guard
                        let index = response.clientIdentifier.flatMap({ Int($0) }),
                        index < texts.count
                    else { continue }
                    texts[index] = response.targetText
                }
            } catch {
                print("Error", error)
            }
        }
    }
}
