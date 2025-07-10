//
//  File.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 07.05.2025.
//

import Foundation
import UIKit

public struct ClassificationPayload {
    public let image: UIImage
    public let results: [ClassificationResult]
}
