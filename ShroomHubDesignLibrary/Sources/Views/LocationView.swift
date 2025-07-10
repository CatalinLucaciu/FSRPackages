//
//  LocationView.swift
//  ShroomHubDesignLibrary
//
//  Created by Catalin Lucaciu on 25.05.2025.
//


import SwiftUI
import SHUtils

public struct LocationView: View {
    let locationName: String?
    let locationUrl: URL?

    public init(locationName: String?, locationUrl: URL?) {
        self.locationName = locationName
        self.locationUrl = locationUrl
    }

    public var body: some View {
        Button {
            if let url = locationUrl {
                UIApplication.shared.open(url)
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(SHColor.forestGreen)
                Text(locationName ?? "")
                    .font(.regular14)
                    .foregroundStyle(SHColor.mediumGray)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Image(systemName: "arrow.up.right.square")
                    .foregroundColor(SHColor.forestGreen)
            }
            .background(Color.clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
