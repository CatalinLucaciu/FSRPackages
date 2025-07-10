//
//  NetworkError.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 29.04.2025.
//

import Foundation
import Alamofire

public enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case cancelled
    case invalidMultipartData
    case unknown

    // MARK: - Error Mapping

    public static func from(_ afError: AFError, data: Data? = nil) -> NetworkError {
        switch afError {
        case .invalidURL(_):
            return .invalidURL
        case .sessionTaskFailed(let error):
            if let urlError = error as? URLError {
                switch urlError.code {
                case .cancelled:
                    return .cancelled
                case .notConnectedToInternet, .timedOut, .cannotFindHost, .cannotConnectToHost, .networkConnectionLost:
                    return .requestFailed(urlError)
                default:
                    return .requestFailed(urlError)
                }
            }
            return .requestFailed(error)
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let statusCode):
                return .httpError(statusCode: statusCode, data: data)
            case .customValidationFailed(let error):
                return .requestFailed(error)
            default:
                return .requestFailed(afError)
            }
        case .responseSerializationFailed(let reason):
            switch reason {
            case .decodingFailed(let error),
                 .jsonSerializationFailed(let error):
                return .decodingError(error)
            default:
                return .decodingError(afError)
            }
        default:
            return .requestFailed(afError)
        }
    }

    // MARK: - Equatable

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL): return true
        case (.requestFailed(let lErr), .requestFailed(let rErr)): return lErr.localizedDescription == rErr.localizedDescription
        case (.invalidResponse, .invalidResponse): return true
        case (.httpError(let lhsCode, _), .httpError(let rhsCode, _)): return lhsCode == rhsCode
        case (.decodingError(let lErr), .decodingError(let rErr)): return lErr.localizedDescription == rErr.localizedDescription
        case (.cancelled, .cancelled): return true
        case (.unknown, .unknown): return true
        default: return false
        }
    }

    // MARK: - Localized Description

    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL was invalid."
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Received an invalid server response."
        case .httpError(let statusCode, let data):
            var desc = "HTTP error with status code: \(statusCode)"
            if let data = data, let errorString = String(data: data, encoding: .utf8) {
                desc += ", Body: \(errorString)"
            }
            return desc
        case .decodingError(let error):
            return "Failed to decode response data: \(error.localizedDescription)"
        case .cancelled:
            return "Network request was cancelled."
        case .unknown:
            return "An unknown network error occurred."
        case .invalidMultipartData:
            return "Multipart data is missing or malformed."
        }
    }
}
