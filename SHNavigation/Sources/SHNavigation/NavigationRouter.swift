//
//  NavigationRouter.swift
//  SHNavigation
//
//  Created by Catalin Lucaciu on 16.03.2025.
//

import SwiftUI
import Observation

@MainActor
public final class NavigationRouter: ObservableObject {
    @Published public var rootPath = NavigationPath()
    @Published private var paths: [SHTab: NavigationPath] = [
        .home: NavigationPath(),
        .map: NavigationPath(),
        .objectCapture: NavigationPath(),
        .collection: NavigationPath()
    ]
    public static let shared = NavigationRouter()
    
    public func path(for tab: SHTab) -> Binding<NavigationPath> {
        Binding(
        get: { self.paths[tab] ?? .init() },
        set: { self.paths[tab] = $0 }
        )
    }
    
    public func navigate(
        to destination: any Hashable,
        in tab: SHTab
    ) {
        paths[tab]?.append(destination)
    }
    
    public func navigate(to destination: any Hashable) {
        rootPath.append(destination)
    }
    
    public func pop(in tab: SHTab) {
        paths[tab]?.removeLast()
    }
    
    public func pop() {
        rootPath.removeLast()
    }
    
    public func popToRoot(in tab: SHTab) {
        paths[tab] = .init()
    }
    
    public func popToRoot() {
        rootPath = .init()
    }
    
    private init() {}
    
}
