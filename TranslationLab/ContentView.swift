//
//  ContentView.swift
//  TranslationLab
//
//  Created by Aries on 2025/1/16.
//

import SwiftUI
import SwiftData

enum TranslationType: Int, CaseIterable {
    case present, replace, batch, instant

    var title: String {
        switch self {
        case .present: return "PRESENT"
        case .replace: return "REPLACE"
        case .batch: return "BATCH"
        case .instant: return "INSTANT"
        }
    }
}

struct ContentView: View {

    @State private var translationType: TranslationType = .present

    var translationTypes: [TranslationType] = TranslationType.allCases

    var body: some View {
        VStack {
            Picker("Display different interfaces", selection: $translationType) {
                ForEach(translationTypes, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)

            Spacer().frame(height: 20)

            switch translationType {
            case .present:
                PresentTranslationView()
            case .replace:
                ReplaceTranslationView()
            case .batch:
                BatchTranslationView()
            case .instant:
                InstantTranslationView()
            }

            Spacer()
        }
        .padding(.all)
    }
}

#Preview {
    ContentView()
}
