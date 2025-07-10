//
//  NetworkServiceProtocol.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 29.04.2025.
//

import Foundation

/// Defines the high-level network service interface for sending requests using a descriptor-based architecture.
/// Consumers of the package interact with this protocol to execute network requests in a structured, testable, and decoupled manner.
/// This protocol is transport- and framework-agnostic (no Alamofire dependency required).
public protocol NetworkServiceProtocol: Sendable {

    /// Sends a request conforming to `RequestDescriptor`, handling request building, transport, and decoding.
    ///
    /// Use this method when you want full control over the request:
    /// - Select HTTP method (GET, POST, PUT, etc.)
    /// - Attach headers, body, query parameters
    /// - Upload multipart form data
    /// - Decode a typed response
    ///
    /// - Parameter request: A type conforming to `RequestDescriptor`, defining all required request metadata.
    /// - Returns: A decoded value of type `T.ResponseType`, as defined by the descriptor.
    /// - Throws: A `NetworkError` if the request fails or decoding fails.
    func send<T: RequestDescriptor>(_ request: T) async throws -> T.ResponseType
}
