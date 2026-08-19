//
//  LanguageManager.swift
//  FlexX
//
//  Created by Dhaarani M on 16/08/26.
//

import Foundation

final class LanguageManager {

    static let shared = LanguageManager()

    private let languageKey = "selectedLanguage"

    private init() {}

    var currentLanguage: String {
        UserDefaults.standard.string(
            forKey: languageKey
        ) ?? "en"
    }

    func setLanguage(_ language: String) {

        UserDefaults.standard.set(
            language,
            forKey: languageKey
        )

        UserDefaults.standard.set(
            [language],
            forKey: "AppleLanguages"
        )

        UserDefaults.standard.synchronize()
    }
}
