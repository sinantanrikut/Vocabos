//
//  Image+Extensions.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 23.09.2023.
//

import SwiftUI

extension Image {
    
    static func custom(_ name: ImageName, color: IconScheme? = nil) -> Image {
        if let color {
            return Image(name.rawValue + "_" + color.rawValue)
        }
        return Image(name.rawValue)
    }
    
    enum IconScheme: String {
        case light
        case dark
    }
    
    enum ImageName: String {
        case logo
        case greeting_bg
  
    }
    
}
