//
//  ServiceProvider.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import Foundation

class ServiceProvider {
    
    public static let shared = ServiceProvider()
    
    private init() {}
    
    func getRequestUrl(endPoint: EndPoint) -> URL {
        #if targetEnvironment(simulator)
        let baseUrl = BaseUrl.prod
        #else
        let baseUrl = BaseUrl.prod
        #endif
        return URL(string: baseUrl.rawValue + endPoint.rawValue)!
    }
    
    func setBaseRequest<R: Codable>(from data: R) -> BaseRequest<R> {
        BaseRequest<R>(data: data)
    }
    
}

fileprivate enum BaseUrl: String {
    case test = "testlink"
    case prod = "prodlink"
}

enum HttpMethod: String {
    case post = "POST"
}

