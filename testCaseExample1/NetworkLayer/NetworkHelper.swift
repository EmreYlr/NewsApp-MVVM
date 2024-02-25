//
//  NetworkHelper.swift
//  testCaseExample1
//
//  Created by Emre on 25.02.2024.
//

import Foundation
import Alamofire
final class NetworkHelper{
    static let BASE_URL = "https://newsapi.org/v2/"
    static let API_KEY = "&apiKey=e6dfab9067f44cc29723b8e9606a9584"
}

enum HTTPMethods {
    case get
    case post
}

extension HTTPMethods {
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}

enum ErrorTypes: String,Error{
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
}

