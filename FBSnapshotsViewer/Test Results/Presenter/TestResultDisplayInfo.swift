//
//  TestResultDisplayInfo.swift
//  FBSnapshotsViewer
//
//  Created by Anton Domashnev on 02/03/2017.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Foundation

struct TestResultDisplayInfo: AutoEquatable {
    let referenceImageURL: URL
    let diffImageURL: URL?
    let failedImageURL: URL?
    let testName: String
    let canBeViewedInKaleidoscope: Bool
    let testResult: SnapshotTestResult

    init(testResult: SnapshotTestResult, kaleidoscopeViewer: ExternalViewer.Type = KaleidoscopeViewer.self) {
        self.testResult = testResult
        self.canBeViewedInKaleidoscope = kaleidoscopeViewer.isAvailable() && kaleidoscopeViewer.canView(snapshotTestResult: testResult)
        switch testResult {
        case let .recorded(testName, referenceImagePath):
            self.testName = testName
            self.referenceImageURL = URL(fileURLWithPath: referenceImagePath)
            self.diffImageURL = nil
            self.failedImageURL = nil
        case let .failed(testName, referenceImagePath, diffImagePath, failedImagePath):
            self.testName = testName
            self.referenceImageURL = URL(fileURLWithPath: referenceImagePath)
            self.diffImageURL = URL(fileURLWithPath: diffImagePath)
            self.failedImageURL = URL(fileURLWithPath: failedImagePath)
        }
    }
}
