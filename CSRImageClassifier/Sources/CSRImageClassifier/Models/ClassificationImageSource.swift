//
//  ClassificationImageSource.swift
//  CSRImageClassifier
//
//  Created by Catalin Lucaciu on 31.05.2025.
//


public enum ClassificationImageSource: Equatable, Identifiable {
    public var id: Self { self }
    
    case camera
    case library

    public static func == (lhs: ClassificationImageSource, rhs: ClassificationImageSource) -> Bool {
        switch (lhs, rhs) {
        case (.camera, .camera), (.library, .library):
            return true
        default:
            return false
        }
    }
}
