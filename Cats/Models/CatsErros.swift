//
//  CatsErros.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//

/// Represents possible errors throughout the app.
enum CatsErros: Error {
    
    /// Indicates a malformed or invalid URL was constructed.
    case invalidURL
    /// Indicates decoding of the received data failed.
    case decodingFailed
    /// Indicates a network or data fetching failure occurred.
    case fecthingDataFailed
    // TODO: add documentation here
    case invalidImageData
    
    /// Provides a localized error description for each error case.
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "errors.invalidURL".localized
        case .decodingFailed:
            return "errors.decodingFailed".localized
        case .fecthingDataFailed:
            return "errors.fetchingDataFailed".localized
        case .invalidImageData:
            // TODO: Add string for this case
            return "errors.fetchingDataFailed".localized
        }
    }
    
}
