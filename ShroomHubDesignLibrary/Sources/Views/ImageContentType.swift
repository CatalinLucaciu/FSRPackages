//
//  ImageContentType.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 13.05.2025.
//

import Foundation
import SHUtils

public enum ImageContentType {
    case remote(URL?)
    case local(String)
}
