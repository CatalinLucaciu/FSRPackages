//
//  Tab.swift
//  SHNavigation
//
//  Created by Catalin Lucaciu on 16.03.2025.
//

public enum SHTab: String, CaseIterable, Hashable {
    case home
    case objectCapture
    case map
    case collection
    
    public var title: String {
        switch self {
        case .home:
            homeTitle
        case .map:
            mapTitle
        case .collection:
            collectionTitle
        case .objectCapture:
            objectCaptureTitle
        }
    }
    
    public var systemImage: String {
        switch self {
        case .home:
            homeImage
        case .map:
            mapImage
        case .collection:
            collectionImage
        case .objectCapture:
            objectCaptureImage
        }
    }
}

// MARK: - Strings
private extension SHTab {
    var homeTitle: String {
        "Home"
    }
    
    var mapTitle: String {
        "Map"
    }
    
    var collectionTitle: String {
        "Collection"
    }
    
    var objectCaptureTitle: String {
        "3D Map"
    }
    
    var homeImage: String {
        "house.fill"
    }
    
    var mapImage: String {
        "map.fill"
    }
    
    var objectCaptureImage: String {
        "cube.transparent"
    }
    
    var collectionImage: String {
        "tray.full"
    }
}

