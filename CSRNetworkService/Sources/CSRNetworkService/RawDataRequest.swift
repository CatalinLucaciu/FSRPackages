//
//  RawDataRequest.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 11.05.2025.
//

import Foundation
import Alamofire
import CSRNetworkService

public struct RawDataRequest: RequestDescriptor {
    public typealias ResponseType = Data

    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }

    public var baseURL: URL { url.deletingLastPathComponent() }
    public var path: String { url.lastPathComponent }
    public var method: HTTPMethod = .get
    public var headers: HTTPHeaders? = nil
    public var queryParameters: [String : String]? = nil
    public var bodyParameters: Parameters? = nil
    public var multipartFormData: [MultipartFormField]? = nil
    public var contentType: ContentType = .json

    public func decode(_ data: Data) throws -> Data {
        data
    }
}
