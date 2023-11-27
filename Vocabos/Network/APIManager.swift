//
//  APIManager.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import Foundation
import Combine
import SwiftUI

final class APIManager {
    private var authToken = ""
    private var accessToken = ""
    private var showLoading = true
    
    public static let shared = APIManager()
    
    private let apiCallListener = ApiCallListenerManager.shared

    private init() {}

    public func setAuthToken(with token: String) {
        authToken = token
    }

    public func setAccessToken(with token: String) {
        accessToken = token
    }
    
    public func fetchData<T: Decodable, D: Encodable>(url: URL, body: BaseRequest<D>, showLoading: Bool = true, method: HttpMethod = .post) -> AnyPublisher<T, Error> {
//        self.showLoading = showLoading
//        if showLoading { apiCallListener.onPreExecute() }
        
        var request =  URLRequest(url: url)
        let session = URLSession.shared
        
        // method
        request.httpMethod = method.rawValue
        
        // headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(DeviceInfo.language ?? "en", forHTTPHeaderField: "Lang")
        request.addValue(authToken, forHTTPHeaderField: "AuthToken")
        request.addValue(accessToken, forHTTPHeaderField: "AccessToken")
        
        // body
        request.httpBody = try? JSONEncoder().encode(body)
        printSuccess("Request headers: ", request.allHTTPHeaderFields ?? ["":""])
        printSuccess("Request body: ", body)
        printSuccess("Request URL: ", url)
        
        // dataTask
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(tryMapHandler)
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func sendData<T: Decodable>(url: URL, imageData: Data?, filePathKey: String) -> AnyPublisher<T, Error> {
        showLoading = true
        //apiCallListener.onPreExecute()
        
        var request =  URLRequest(url: url)
        let session = URLSession.shared
        
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        
        // method
        request.httpMethod = HttpMethod.post.rawValue
        
        // headers
        request.addValue(DeviceInfo.language ?? "en", forHTTPHeaderField: "Lang")
        request.addValue(authToken, forHTTPHeaderField: "AuthToken")
        request.addValue(accessToken, forHTTPHeaderField: "AccessToken")
        request.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        
        // body
        let requestData = createRequestBody(imageData: imageData, boundary: bodyBoundary, attachmentKey: filePathKey, fileName: "\(filePathKey).jpg")
        request.httpBody = requestData
        
        // dataTask
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(tryMapHandler)
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createRequestBody(imageData: Data?, boundary: String, attachmentKey: String, fileName: String) -> Data {
        let lineBreak = "\r\n"
        var requestBody = Data()
        
        if let imageData = imageData {
            requestBody.appendString("\(lineBreak)--\(boundary + lineBreak)")
            requestBody.appendString("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)")
            requestBody.appendString("Content-Type: image/jpeg \(lineBreak + lineBreak)")
            requestBody.append(imageData)
            requestBody.appendString("\(lineBreak)--\(boundary)--\(lineBreak)")
        }
        
        printSuccess(requestBody)
        
        return requestBody
    }
    
    public lazy var handleCompletion: ((Subscribers.Completion<Error>) -> Void) = { [weak self] completion in
        switch completion {
        case .finished:
            printSuccess("Finished!")
        case .failure(let error):
            printError(error.localizedDescription)
            guard let self else { return }
//            if self.showLoading { self.apiCallListener.onPostExecute() }
        }
    }
    
    private lazy var tryMapHandler: (URLSession.DataTaskPublisher.Output) throws -> Data = { output in
        printSuccess("\(String(data: output.data, encoding: .utf8) ?? "")")
        guard let response = output.response as? HTTPURLResponse else {
            throw ErrorResponse(errorMessage: "", errorCode: 500, errorType: .serverError)
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw ErrorResponse(errorMessage: "", errorCode: response.statusCode, errorType: .missingData)
        }
//        if self.showLoading { self.apiCallListener.onPostExecute() }
        return output.data
    }
}
