//
//  UIImage+Extension.swift
//  Cats
//
//  Created by Simão Neves Samouco on 06/08/2025.
//


import UIKit

extension UIImage {
    
    static let defaultErrorImage = UIImage(systemName: "airplane.circle")!
    
    /// An estimate of the image's memory footprint in bytes.
    ///
    /// Calculated as `width × height × scale² × 4`, where 4 represents
    /// the number of bytes per pixel in a standard RGBA colour space.
    ///
    /// - Note: This is an approximation. Actual memory usage may vary
    ///   depending on the image's colour space and internal representation.
    var estimatedByteSize: Int {
        Int(size.width * size.height * scale * scale) * 4
    }
    
}
