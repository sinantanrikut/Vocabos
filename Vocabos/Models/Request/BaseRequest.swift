//
//  BaseRequest.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import Foundation

// MARK: - BaseRequest
struct BaseRequest<D: Codable>: Codable {
    let data: D?
}
