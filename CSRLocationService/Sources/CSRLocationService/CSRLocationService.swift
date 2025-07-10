//
//  File.swift
//  CSRLocationService
//
//  Created by Catalin Lucaciu on 08.05.2025.
//

import CoreLocation

public protocol LocationProviding {
    func getCurrentLocation() async throws -> CLLocation
    func reverseGeoCode(
        latitude: Double,
        longitude: Double
    ) async -> ReverseGeocodedLocation?
}


public actor CSRLocationService: LocationProviding {
    let manager = CLLocationManager()
    
    public init() { }
    
    public func getCurrentLocation() async throws -> CLLocation {
        guard CLLocationManager.locationServicesEnabled() else {
            throw LocationError.servicesDisabled
        }
        manager.requestWhenInUseAuthorization()
        
        for try await update in CLLocationUpdate.liveUpdates() {
            if let location = update.location {
                return location
            }
        }
                
        throw LocationError.unableToFetch
    }
    
    public func reverseGeoCode(
        latitude: Double,
        longitude: Double
    ) async -> ReverseGeocodedLocation? {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        do {
            var address = ""
            let placemarks = try await geoCoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                address = [
                    placemark.name,
                    placemark.subLocality,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                    ]
                    .compactMap{ $0 }
                    .joined(separator: ", ")
            } else {
                address = "Latitude: \(latitude) Longitude: \(longitude)"
            }
            let urlString = "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)"
            guard let mapsURL = URL(string: urlString) else { return nil }

            return ReverseGeocodedLocation(address: address, mapsURL: mapsURL)
        } catch {
            return nil
        }
    }
}
