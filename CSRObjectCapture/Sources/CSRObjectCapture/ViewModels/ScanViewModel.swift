//
//  ScanViewModel.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 27.03.2025.
//

import RealityKit
import SwiftUI
import Combine
import AVFoundation
import OSLog

@MainActor
@Observable
public class ScanViewModel {
    public private(set) var captureState: CaptureState = .notReady(reason: .idle)
    public private(set) var feedbackMessage: LocalizedStringKey?
    public private(set) var imageCount: Int = 0
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.CSRObjectCapture", category: "ScanViewModel")
    private var captureSession: ObjectCaptureSession?
    private var sessionTask: Task<Void, Never>?
    private var captureMode: CaptureMode
    private var captureFolderManager: CaptureFolderManagerMyOwn?
    
    public init(captureMode: CaptureMode) {
        self.captureMode = captureMode
    }
    
    deinit {
        print("s-o dus")
    }
    
}

public extension ScanViewModel {
    func startSession() async throws {
        guard captureSession == nil else {
            logger.error("Capture Object already initialized")
            return
        }
        guard try await checkPermissionAndCapabilities() else { return }
        logger.info("Initializing ObjectCaptureSession...")
        captureState = .initializing
        feedbackMessage = "Initializing..."
        createCaptureFolder()
        self.captureSession = ObjectCaptureSession()
        
        sessionTask = Task { [weak self] in
            await self?.monitorSessionOutputs()
        }
        
        guard let captureFolderManager else {
            logger.error("Capture folder not initialized")
            throw ScanError.generic
        }
        let configuration = createObjectSessionConfiguration(for: captureFolderManager)
        logger.info("Starting capture session with configuration and folder...")
        captureSession?.start(imagesDirectory: captureFolderManager.imagesFolderURL,
                              configuration: configuration)
    }
    
    func stopSession() {
        logger.info("Stopping session monitoring and releasing session reference...")
        sessionTask?.cancel()
        captureSession = nil
        
        switch captureState {
        case .completed, .failed:
            break
        default:
            captureState = .notReady(reason: .idle)
            feedbackMessage = nil
            imageCount = 0
        }
    }
}

// MARK: - Utils
private extension ScanViewModel {
    func checkPermissionAndCapabilities() async throws -> Bool {
        guard ObjectCaptureSession.isSupported else {
            captureState = .notReady(reason: .noObjectCaptureSupport)
            logger.error("Capture not supported on this device.")
            return false
        }
        let cameraPermissionStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraPermissionStatus {
        case .authorized:
            return true
        case .notDetermined:
            return await grantCameraAccess()
        default:
            captureState = .notReady(reason: .noPermission)
            feedbackMessage = "Camera access is required to use this app."
            return false
        }
    }
    
    func grantCameraAccess() async -> Bool {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        if granted {
            logger.info("Camera access granted")
            return true
        } else {
            logger.info("Camera access denied")
            captureState = .notReady(reason: .noPermission)
            return false
        }
    }
    
    func createObjectSessionConfiguration(for captureFolderManager: CaptureFolderManagerMyOwn) -> ObjectCaptureSession.Configuration {
        var configuration = ObjectCaptureSession.Configuration()
        configuration.isOverCaptureEnabled = true
        configuration.checkpointDirectory = captureFolderManager.checkpointFolderURL
        return configuration
    }
    
    func createCaptureFolder() {
        do {
            self.captureFolderManager = try CaptureFolderManagerMyOwn()
            logger.log("Capture folder created at: \(self.captureFolderManager?.captureFolderURL.path ?? "")")
        } catch {
            logger.error("Failed to create capture folder: \(error)")
            captureState = .failed(error: error)
            feedbackMessage = "Storage Error"
            return
        }
    }
}
private extension ScanViewModel {
    func monitorSessionOutputs() async {
        guard let session = captureSession else { return }
        print("Starting Monitoring Sessions")
        for await newState in session.stateUpdates {
            updateSessionState(newState)
            if Task.isCancelled {
                logger.info("Session monitoring task cancelled.")
                break
            }
        }
    }
    
    @MainActor
    func updateSessionState(_ state: ObjectCaptureSession.CaptureState) {
        feedbackMessage = feedback(for: state)
        captureState = mapState(state)
    }
    
    func feedback(for state: ObjectCaptureSession.CaptureState) -> LocalizedStringKey? {
        switch state {
        case .initializing:
            return "Initializing..."
        case .detecting:
            return "Aim at your object"
        case .ready:
            return "Ready to Scan"
        case .capturing:
            return nil
        case .finishing:
            return "Finishing Capture..."
        case .completed:
            return "Capture Complete - Review"
        case .failed:
            return "Capture Failed"
        @unknown default:
            return "Unknown Session State"
        }
    }
    
    func mapState(_ state: ObjectCaptureSession.CaptureState) -> CaptureState {
        switch state {
        case .initializing:
            return .initializing
        case .ready:
            if self.captureMode == .object {
                // In object mode, 'ready' usually happens AFTER detection.
                // The session might go initializing -> detecting -> ready
                // We need to see the detection updates first. Let's assume
                // for now it means ready to start capturing *after* detection.
                return .readyToScan // Or maybe wait for detection update?
            } else { // Area Mode
                return  .readyToScan
            }
        case .detecting:
            return .detecting
        case .capturing:
            return .scanning
        case .finishing:
            // This state happens briefly before .completed or .failed internally
            return .processing(progress: 0.0)
        case .completed:
            // This means the *capture* part is done, not necessarily processing yet.
            // Usually transitions to Reviewing state in the UI workflow.
            return .reviewing
        case .failed(let error):
            stopSession()
            return .failed(error: error)
        @unknown default:
            print("Unhandled session state: \(state)")
            // TODO: add this to our future error state
            return .failed(error: NSError(domain: "CSRObjectCapture", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown session state"]))
        }
    }
}
