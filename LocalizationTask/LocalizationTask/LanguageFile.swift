//
//  LanguageFile.swift
//  LocalizationTask
//
//  Created by Saheem Hussain on 29/03/23.
//

import Foundation

enum Language: String {
    case english = "en"
    case arabic = "ar"
    case hindi = "hi"
}

extension String {

    /// Localizes a string using given language from Language enum.
    /// - Parameter language: The language that will be used to localized string.
    /// - Returns: localized string.
    
    func localized(_ language: Language) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle)
    }

    
    
    /// Localizes a string using given language from Language enum.
    /// - Parameters:
    ///  - language: The language that will be used to localized string.
    ///  - args:  dynamic arguments provided for the localized string.
    /// - Returns: localized string
    
//    func localized(_ language: Language, args arguments: CVarArg...) -> String {
//        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
//        let bundle: Bundle
//        if let path = path {
//            bundle = Bundle(path: path) ?? .main
//        } else {
//            bundle = .main
//        }
//        return String(format: localized(bundle: bundle), arguments: arguments)
//    }
    
    
    
    /// Localizes a string using self as key.
    ///
    /// - Parameters:
    ///   - bundle: the bundle where the Localizable.strings file lies.
    /// - Returns: localized string.
    ///
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

//The next step is to implement LocalizationService that will do the next things:

//Provide the current language.
//Save the language in UserDefaults to keep chosen language between app launches.
//Send a notification in case the new language was selected.

class LocalizationService {

    static let shared = LocalizationService()
//    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "language") else {
                return .english
            }
            return Language(rawValue: languageString) ?? .english
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "language")
//                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
