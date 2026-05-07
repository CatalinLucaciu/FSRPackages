# FSRPackages

FSRPackages is a collection of reusable Swift packages used to support modular iOS application development.

The repository contains shared modules for UI design, navigation, networking, authentication, location handling, image classification, Object Capture flows, and domain/service logic. The packages are designed to be reused across iOS projects and to keep app targets smaller, cleaner, and easier to maintain.

## Overview

This repository is structured as a package workspace rather than a single app. Each folder represents an independent Swift Package Manager module with its own `Package.swift`.

The main goal is to separate reusable infrastructure and feature-support code from the application layer. This makes the consuming app easier to reason about while allowing each package to evolve independently.

## Packages

### ShroomHubDesignLibrary

Reusable SwiftUI design system for the ShroomHub app.

Includes:

* shared colors
* typography
* spacing constants
* corner radius and shadow constants
* reusable buttons
* loading, success, and error views
* async content rendering
* reusable mushroom-related UI components
* custom font resources

This package centralizes visual styling and shared UI components so the main app can stay consistent and avoid duplicated view code.

### SHNavigation

Navigation utilities for SwiftUI apps.

Includes:

* shared navigation router
* tab-specific navigation paths
* root navigation path
* helpers for pushing, popping, and resetting navigation stacks

The package is built around SwiftUI `NavigationPath` and supports multiple independent tab navigation stacks.

### SHUtils

General-purpose utilities shared across modules.

Includes:

* `LoadableState`
* async loading helpers
* binding mapping utilities
* date formatting helpers

This package provides small reusable building blocks that are useful across features without tying them to a specific app screen.

### CSRNetworkService

Descriptor-based networking layer built with Alamofire.

Includes:

* `NetworkService`
* `NetworkServiceProtocol`
* `RequestDescriptor`
* typed response decoding
* JSON, URL-encoded, and multipart request support
* multipart form data models
* network error mapping

The package allows features to describe requests in a structured way while keeping transport and decoding logic centralized.

### CSRLocationService

Location service module built on CoreLocation.

Includes:

* current location fetching
* reverse geocoding
* Google Maps URL generation
* location-related error handling
* async/await-based API

This package isolates location logic from app features and exposes a simple protocol-based interface.

### CSRImageClassifier

Image classification module built with CoreML, Vision, SwiftUI, UIKit, and PhotosUI.

Includes:

* camera image picker
* photo library picker
* CoreML/Vision classification view model
* image source selection
* classification payload models
* classification result models
* typed classification errors

The package supports image classification from both camera and photo library sources and returns the captured image together with the top classification results.

### CSRObjectCapture

Object Capture / 3D scanning support package.

Includes:

* scanning flow models
* scan state management
* onboarding and tutorial views
* capture and reconstruction views
* overlay controls
* progress UI
* helper utilities for capture folders and feedback messages
* bundled tutorial media resources

This package explores Apple's Object Capture workflow and separates scanning-related UI and state management from the main app.

### FirebaseAuthPackage

Firebase authentication wrapper.

Includes:

* Firebase authentication protocol
* email/password sign in
* user registration
* sign out
* current user mapping
* app session handling
* authentication error models

The package wraps Firebase Auth behind app-friendly abstractions so the consuming app does not need to depend directly on Firebase implementation details everywhere.

### Additional Packages

The repository also contains additional reusable packages under `Lobont Packages`:

* `AdView`
* `ForesterDomainKit`
* `ForesterServiceKit`

These packages include reusable modules for ad views, domain logic, service gateways, Firebase-backed services, HealthKit-related services, StoreKit-related services, and test support.

## Tech Stack

* Swift
* SwiftUI
* UIKit
* iOS 18+
* Swift Package Manager
* Swift Concurrency
* Observation
* CoreML
* Vision
* PhotosUI
* CoreLocation
* Firebase
* Alamofire
* SDWebImageSwiftUI
* Lottie
* HealthKit
* StoreKit

## Repository Structure

```text
FSRPackages
├── CSRImageClassifier
├── CSRLocationService
├── CSRNetworkService
├── CSRObjectCapture
├── FirebaseAuthPackage
├── SHNavigation
├── SHUtils
├── ShroomHubDesignLibrary
└── Lobont Packages
    ├── AdView
    ├── ForesterDomainKit
    └── ForesterServiceKit
```

## Architecture

The packages follow a modular architecture where each module has a focused responsibility.

The main architectural ideas are:

* keep app targets lightweight
* isolate reusable infrastructure
* avoid duplicating common UI and state handling
* hide third-party dependencies behind package-level abstractions
* use protocols where useful for testability and decoupling
* keep feature-support modules independent from the main app

This structure makes it easier to scale an iOS app without turning the main target into a large, tightly coupled codebase.

## Why This Repository Exists

FSRPackages was created to support cleaner iOS development across app projects.

Instead of keeping all logic directly inside the app target, reusable concerns are extracted into packages:

* UI design system
* navigation
* networking
* authentication
* image classification
* location services
* Object Capture
* generic utilities

This improves separation of concerns and makes the code easier to reuse, test, and maintain.

## Usage

Each package can be added locally through Swift Package Manager.

Example:

```swift
.package(path: "../FSRPackages/SHUtils")
```

Then add the needed product to the target dependencies:

```swift
.product(name: "SHUtils", package: "SHUtils")
```

Some packages depend on external libraries such as Firebase, Alamofire, SDWebImageSwiftUI, and Lottie. Those dependencies are declared in the package manifests where needed.

## Requirements

* iOS 18.0+
* Xcode 16+
* Swift 6.0+
* Swift Package Manager

## Current Status

The repository is under active development.

Current focus areas include:

* improving package boundaries
* refining reusable UI components
* strengthening service abstractions
* improving package documentation
* preparing modules for cleaner reuse across apps
* adding tests where package logic benefits from coverage

## Future Improvements

* add README files for individual packages
* add more usage examples
* improve public API documentation
* add unit tests for networking, auth, and utility packages
* review access control across modules
* clean up older experimental packages
* add CI for package validation
* add sample app integration examples

## What This Project Demonstrates

This repository demonstrates:

* Swift Package Manager modularization
* reusable SwiftUI component design
* design system thinking
* protocol-oriented service abstraction
* async/await-based service APIs
* CoreML and Vision integration
* Firebase abstraction
* descriptor-based networking
* multi-tab SwiftUI navigation management
* Object Capture flow integration
* scalable iOS project organization

## Related Project

These packages are used by ShroomHub, a SwiftUI mushroom discovery and identification app.

ShroomHub repository: [CatalinLucaciu/ShroomHub](https://github.com/CatalinLucaciu/ShroomHub)

## Author

**Cătălin Lucaciu**
**iOS Developer**

GitHub: [CatalinLucaciu](https://github.com/CatalinLucaciu)

## License

This repository is currently intended for portfolio and personal project use.
