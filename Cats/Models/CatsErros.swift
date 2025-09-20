//
//  RocketsErros.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


enum CatsErros: Error {
    
    case invalidURL
    case decodingFailed
    case fecthingDataFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "errors.decodingFailed".localized
        case .decodingFailed:
            return "errors.invalidURL".localized
        case .fecthingDataFailed:
            return "errors.fetchingDataFailed".localized
        }
    }
    
}
