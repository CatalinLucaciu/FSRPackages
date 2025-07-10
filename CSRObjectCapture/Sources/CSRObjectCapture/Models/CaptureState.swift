//
//  CaptureState.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 27.03.2025.
//

import Foundation

public enum CaptureState: Equatable {
    public enum NotReadyReason {
        case noPermission
        case noObjectCaptureSupport
        case idle
    }
    
    case notReady(reason: NotReadyReason)
    case initializing
    case detecting
    case objectDetected
    case readyToScan
    case scanning
    case reviewing
    case processing(progress: Double)
    case completed(url: URL)
    case failed(error: Error)
    case cancelled
    
    public static func == (lhs: CaptureState, rhs: CaptureState) -> Bool {
        switch (lhs, rhs) {
        case let (.notReady(lReason), .notReady(rReason)):
            return lReason == rReason
        case (.initializing, .initializing):
            return true
        case (.detecting, .detecting):
            return true
        case (.objectDetected, .objectDetected):
            return true
        case (.readyToScan, .readyToScan):
            return true
        case (.scanning, .scanning):
            return true
        case (.reviewing, .reviewing):
            return true
        case (.processing(let lProgress), .processing(let rProgress)):
            return lProgress == rProgress
        case (.completed(let lUrl), .completed(let rUrl)):
            return lUrl == rUrl
        case (.failed(let lError), .failed(let rError)):
            return String(reflecting: lError) == String(reflecting: rError)
        case (.cancelled, .cancelled):
            return true
        default:
            return false
        }
    }
}
