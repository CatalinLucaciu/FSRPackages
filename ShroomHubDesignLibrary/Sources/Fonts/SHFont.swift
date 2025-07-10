//
//  SHFont.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 27.02.2025.
//

import SwiftUI

public enum SHFont: String {
    case regular = "poppins.regular"
    case bold = "poppins.bold"
    case medium = "poppins.medium"
    case semiBold = "poppins.semibold"
}

// MARK: - Regular
public extension Font {
    static var regular10: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 10,
                    relativeTo: .headline)
    }
    static var regular12: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 12,
                    relativeTo: .headline)
    }
    static var regular14: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 14,
                    relativeTo: .headline)
    }
    static var regular16: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 16,
                    relativeTo: .headline)
    }
    static var regular18: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 18,
                    relativeTo: .headline)
    }
    static var regular20: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 20,
                    relativeTo: .headline)
    }
    static var regular22: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 22,
                    relativeTo: .headline)
    }
    static var regular24: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 24,
                    relativeTo: .headline)
    }
    static var regular26: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 26,
                    relativeTo: .headline)
    }
    static var regular28: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 28,
                    relativeTo: .headline)
    }
    static var regular30: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 30,
                    relativeTo: .headline)
    }
    static var regular32: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 32,
                    relativeTo: .headline)
    }
    static var regular34: Font {
        Font.custom(SHFont.regular.rawValue,
                    size: 34,
                    relativeTo: .headline)
    }
}

// MARK: - Medium
public extension Font {
    static var medium10: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 10,
                    relativeTo: .headline)
    }
    static var medium12: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 12,
                    relativeTo: .headline)
    }
    static var medium14: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 14,
                    relativeTo: .headline)
    }
    static var medium16: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 16,
                    relativeTo: .headline)
    }
    static var medium18: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 18,
                    relativeTo: .headline)
    }
    static var medium20: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 20,
                    relativeTo: .headline)
    }
    static var medium22: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 22,
                    relativeTo: .headline)
    }
    static var medium24: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 24,
                    relativeTo: .headline)
    }
    static var medium26: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 26,
                    relativeTo: .headline)
    }
    static var medium28: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 28,
                    relativeTo: .headline)
    }
    static var medium30: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 30,
                    relativeTo: .headline)
    }
    static var medium32: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 32,
                    relativeTo: .headline)
    }
    static var medium34: Font {
        Font.custom(SHFont.medium.rawValue,
                    size: 34,
                    relativeTo: .headline)
    }
}

// MARK: - SemiBold
public extension Font {
    static var semiBold10: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 10,
                    relativeTo: .headline)
    }
    static var semiBold12: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 12,
                    relativeTo: .headline)
    }
    static var semiBold14: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 14,
                    relativeTo: .headline)
    }
    static var semiBold16: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 16,
                    relativeTo: .headline)
    }
    static var semiBold18: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 18,
                    relativeTo: .headline)
    }
    static var semiBold20: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 20,
                    relativeTo: .headline)
    }
    static var semiBold22: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 22,
                    relativeTo: .headline)
    }
    static var semiBold24: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 24,
                    relativeTo: .headline)
    }
    static var semiBold26: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 26,
                    relativeTo: .headline)
    }
    static var semiBold28: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 28,
                    relativeTo: .headline)
    }
    static var semiBold30: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 30,
                    relativeTo: .headline)
    }
    static var semiBold32: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 32,
                    relativeTo: .headline)
    }
    static var semiBold34: Font {
        Font.custom(SHFont.semiBold.rawValue,
                    size: 34,
                    relativeTo: .headline)
    }
}

// MARK: - Bold
public extension Font {
    static var bold10: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 10,
                    relativeTo: .headline)
    }
    static var bold12: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 12,
                    relativeTo: .headline)
    }
    static var bold14: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 14,
                    relativeTo: .headline)
    }
    static var bold16: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 16,
                    relativeTo: .headline)
    }
    static var bold18: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 18,
                    relativeTo: .headline)
    }
    static var bold20: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 20,
                    relativeTo: .headline)
    }
    static var bold22: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 22,
                    relativeTo: .headline)
    }
    static var bold24: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 24,
                    relativeTo: .headline)
    }
    static var bold26: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 26,
                    relativeTo: .headline)
    }
    static var bold28: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 28,
                    relativeTo: .headline)
    }
    static var bold30: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 30,
                    relativeTo: .headline)
    }
    static var bold32: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 32,
                    relativeTo: .headline)
    }
    static var bold34: Font {
        Font.custom(SHFont.bold.rawValue,
                    size: 34,
                    relativeTo: .headline)
    }
}
