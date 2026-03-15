//
//  Secrets.swift
//  Cats
//
//  Created by Simão Neves Samouco on 15/03/2026.
//

import Foundation

enum Secrets {
    
    static var catAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "CAT_API_KEY") as? String,
              !key.isEmpty else {
            assertionFailure("Missing CAT_API_KEY in Info.plist")
            return ""
        }
        return key
    }
    
}
