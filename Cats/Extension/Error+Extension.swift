//
//  Error+Extension.swift
//  Cats
//
//  Created by Simão Neves Samouco on 10/09/2025.
//

import Foundation

extension Error {
    
    /// Returns a message suitable for displaying to the user.
    ///
    /// This property provides a human-readable message for any error. If the error
    /// conforms to `CatsErros` and provides an `errorDescription`, that description
    /// is used. Otherwise, it falls back to the standard `localizedDescription`.
    var displayMessage: String {
        (self as? CatsErros)?.errorDescription ?? self.localizedDescription
    }
    
}
