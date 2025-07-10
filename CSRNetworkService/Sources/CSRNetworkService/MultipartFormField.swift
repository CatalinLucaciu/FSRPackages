//
//  MultipartFormField.swift
//  CSRNetworkService
//
//  Created by Catalin Lucaciu on 10.05.2025.
//

import Foundation

public struct MultipartFormField {
    public enum FieldType {
        case text(String)
        case file(data: Data, fileName: String, mimeType: String)
    }
    
    public init(name: String, type: FieldType) {
        self.name = name
        self.type = type
    }

    public let name: String
    public let type: FieldType
}
