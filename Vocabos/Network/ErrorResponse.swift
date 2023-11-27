//
//  ErrorResponse.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import Foundation

struct ErrorResponse: Error {
    let errorMessage: String?
    let errorCode: Int?
    let errorType: ErrorType
}
