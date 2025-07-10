//
//  NetworkService.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 29.04.2025.
//

import Foundation
import Alamofire

import Foundation
import Alamofire

public final class NetworkService: NetworkServiceProtocol {
    private let session: Session

    public init(session: Session = .default) {
        self.session = session
    }

    public func send<T: RequestDescriptor>(_ request: T) async throws -> T.ResponseType {
        let fullURL = request.baseURL.appendingPathComponent(request.path)

        switch request.contentType {
        case .json, .urlEncoded:
            let encoding: ParameterEncoding = (request.contentType == .json) ? JSONEncoding.default : URLEncoding.default

            let afRequest = session.request(
                fullURL,
                method: request.method,
                parameters: request.bodyParameters,
                encoding: encoding,
                headers: request.headers
            )

            let data = try await afRequest.validate().serializingData().value
            return try request.decode(data)

        case .multipart:
            guard let multipartFields = request.multipartFormData else {
                throw NetworkError.invalidMultipartData
            }

            return try await withCheckedThrowingContinuation { continuation in
                session.upload(
                    multipartFormData: { multipart in
                        for field in multipartFields {
                            switch field.type {
                            case .text(let value):
                                multipart.append(Data(value.utf8), withName: field.name)
                            case .file(let data, let fileName, let mimeType):
                                multipart.append(data, withName: field.name, fileName: fileName, mimeType: mimeType)
                            }
                        }
                    },
                    to: fullURL,
                    method: request.method,
                    headers: request.headers
                )
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoded = try request.decode(data)
                            continuation.resume(returning: decoded)
                        } catch {
                            continuation.resume(throwing: error)
                        }

                    case .failure(let error):
                        continuation.resume(throwing: NetworkError.from(error.asAFError ?? AFError.sessionTaskFailed(error: error)))
                    }
                }
            }
        }
    }
}

