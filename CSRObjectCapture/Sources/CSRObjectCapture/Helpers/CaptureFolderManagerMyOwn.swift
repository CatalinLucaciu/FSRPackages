//
//  CaptureFolderManager.swift
//  CSRObjectCapture
//
//  Created by Catalin Lucaciu on 28.03.2025.
//

import Observation
import Foundation
import OSLog

public final class CaptureFolderManagerMyOwn {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.CSRObjectCapture",
                                category: "CaptureFolderManager")
    public let captureFolderURL: URL
    public let imagesFolderURL: URL
    public let checkpointFolderURL: URL
    public let modelsFolderURL: URL
    
    public static let imagesFolderName = "Images"
    public static let checkpointFolderName = "Checkpoints"
    public static let modelsName = "Models"
    
    public init() throws {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            let errorMessage = "Could not access documents directory"
            throw FolderError.couldNotCreate(description: errorMessage)
        }
        
        self.captureFolderURL = Self.createCaptureFolderURL(in: documentsDirectory)
        self.imagesFolderURL = self.captureFolderURL.appending(path: Self.imagesFolderName,
                                                               directoryHint: .isDirectory)
        self.checkpointFolderURL = self.captureFolderURL.appending(path: Self.checkpointFolderName,
                                                                   directoryHint: .isDirectory)
        self.modelsFolderURL = self.captureFolderURL.appending(path: Self.modelsName,
                                                               directoryHint: .isDirectory)
        logger.info("Attempting to create capture root folder: \(self.captureFolderURL.path, privacy: .public)")
        try self.createDirectoryIfNeeded(at: captureFolderURL)
        do {
            logger.info("Attempting to create capture images folder: \(self.imagesFolderURL.path, privacy: .public)")
            try self.createDirectoryIfNeeded(at: imagesFolderURL)
            logger.info("Attempting to create capture checkPoint folder: \(self.imagesFolderURL.path, privacy: .public)")
            try self.createDirectoryIfNeeded(at: checkpointFolderURL)
            logger.info("Attempting to create capture models folder: \(self.modelsFolderURL.path, privacy: .public)")
            try self.createDirectoryIfNeeded(at: modelsFolderURL)
        } catch {
            let errorDesc = "Failed to create subdirectories: \(error.localizedDescription)"
            logger.error("\(errorDesc)")
            try? deleteFolder(at: self.captureFolderURL)
            throw FolderError.couldNotCreate(description: errorDesc)
        }
    }
}


private extension CaptureFolderManagerMyOwn {
    func deleteFolder(at path: URL) throws {
        guard FileManager.default.fileExists(atPath: path.path) else {
            logger.info("Nothing to delete at \(path.path)")
            return
        }
        do {
            try FileManager.default.removeItem(at: path)
            logger.info("Succesfully delete item at \(path.path)")
        } catch {
            let errorDesc = "Could not delete item at \(path.path)"
            logger.error("\(errorDesc)")
            throw FolderError.deletionError(description: errorDesc)
        }
    }
    
    static func createCaptureFolderURL(in documentsURL: URL) -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let formattedDate = formatter.string(from: Date())
        let folderName = "ObjectCapture_\(formattedDate)"
        let finalURL = documentsURL.appending(path: folderName, directoryHint: .isDirectory)
        return finalURL
    }
    
    func createDirectoryIfNeeded(at url: URL) throws {
        let doesFileExist = try verifyExistanceOfDirectory(at: url)
        
        guard !doesFileExist else { return }
        logger.debug("Creating directory: \(url.path, privacy: .public)")
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            guard try verifyExistanceOfDirectory(at: url) else {
                let errorDesc = "Directory creation failed verification at path: \(url.path)"
                logger.error("\(errorDesc)")
                throw FolderError.couldNotCreate(description: errorDesc)
            }
            logger.debug("Successfully created directory: \(url.path, privacy: .public)")
        } catch {
            let errorDesc = "Error during FileManager.createDirectory: \(error.localizedDescription)"
            logger.error("\(errorDesc)")
            throw FolderError.couldNotCreate(description: errorDesc)
        }
    }
    
    func verifyExistanceOfDirectory(at url: URL) throws -> Bool {
        var isDirectory: ObjCBool = false
        let doseFileExist = FileManager.default.fileExists(atPath: url.path,
                                                           isDirectory: &isDirectory)
        if doseFileExist {
            guard isDirectory.boolValue else {
                let errorDescription = "File exists at path \(url.path) but is not a directory"
                logger.error("\(errorDescription)")
                throw FolderError.existanceError(description: errorDescription)
            }
            logger.debug("Directory already exists at: \(url.path, privacy: .public)")
            return true
        } else {
            return false
        }
    }
}

public extension CaptureFolderManagerMyOwn {
    enum FolderError: Error, LocalizedError {
        case couldNotCreate(description: String)
        case existanceError(description: String)
        case deletionError(description: String)
        
        public var errorDescription: String? {
            switch self {
            case let .couldNotCreate(description):
                return "Folder Creation Failed: \(description)"
            case let .existanceError(description):
                return "Could not find Folder: \(description)"
            case let .deletionError(description):
                return "Could not delete Folder: \(description)"
            }
        }
    }
}

// Note: For this to allow user access via Files app, the *host application*
// keys in its Info.plist:
// 1. 'Supports Document Browser' (LSSupportsOpeningDocumentsInPlace) = YES
// 2. 'Application supports iTunes file sharing' (UIFileSharingEnabled) = YES
