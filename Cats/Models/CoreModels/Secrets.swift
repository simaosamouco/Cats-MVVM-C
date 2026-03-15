//
//  Secrets.swift
//  Cats
//
//  Created by Simão Neves Samouco on 15/03/2026.
//

import Foundation

/// Provides access to sensitive configuration values stored in `Info.plist`.
///
/// Secrets are injected at build time via `.xcconfig` files, ensuring they are
/// never hardcoded in source code or committed to version control.
enum Secrets {
    
    /// The API key used to authenticate requests to The Cat API.
    static var catAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "CAT_API_KEY") as? String,
              !key.isEmpty else {
            assertionFailure("Missing CAT_API_KEY in Info.plist")
            return ""
        }
        return key
    }
    
}
