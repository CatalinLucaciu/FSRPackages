//
//  RequestDescriptor.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 10.05.2025.
//

import Foundation
import Alamofire

public enum ContentType {
    case json
    case multipart
    case urlEncoded
}

public protocol RequestDescriptor {
    associatedtype ResponseType: Sendable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryParameters: [String: String]? { get }
    var bodyParameters: Parameters? { get }
    var multipartFormData: [MultipartFormField]? { get }
    var contentType: ContentType { get }

    func decode(_ data: Data) throws -> ResponseType
}
