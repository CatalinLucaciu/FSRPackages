//
//  Binding+Map.swift
//  SHUtils
//
//  Created by Catalin Lucaciu on 15.03.2025.
//

import SwiftUI

public extension Binding {
    @MainActor
    func map<NewValue>(
        _ transform: @escaping (Value) -> NewValue
    ) -> Binding<NewValue> {
        Binding<NewValue>(get: { transform(wrappedValue) },
                          set: { _ in })
    }
}
