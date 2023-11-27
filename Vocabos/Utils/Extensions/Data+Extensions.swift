//
//  Data+Extensions.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import Foundation

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
