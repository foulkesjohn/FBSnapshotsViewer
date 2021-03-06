//
//  TestClassNameExtractorSpec.swift
//  FBSnapshotsViewerTests
//
//  Created by Anton Domashnev on 15.08.17.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Quick
import Nimble

@testable import FBSnapshotsViewer

class FailedTestClassNameExtractorSpec: QuickSpec {
    override func spec() {
        var subject: TestClassNameExtractor!
        
        beforeEach {
            subject = FailedTestClassNameExtractor()
        }
        
        describe(".extractTestClassName") {
            context("given kaleidoscopeCommandMessage") {
                context("with valid line") {
                    var logLine: ApplicationLogLine!
                    
                    beforeEach {
                        logLine = ApplicationLogLine.kaleidoscopeCommandMessage(line: "ksdiff \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/reference_testFail@2x.png\" \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/failed_testFail@2x.png\"")
                    }
                    
                    it("extracts test name") {
                        expect(try? subject.extractTestClassName(from: logLine)).to(equal("FBSnapshotsViewerExampleTests"))
                    }
                }
                
                context("with invalid line") {
                    it("throws exception") {
                        expect { try subject.extractTestClassName(from: ApplicationLogLine.kaleidoscopeCommandMessage(line: "foo/bar")) }.to(throwError())
                    }
                }
            }
            
            context("given applicationNameMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.applicationNameMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given fbReferenceImageDirMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given snapshotTestErrorMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.snapshotTestErrorMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given unknown") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.unknown) }.to(throwError())
                }
            }
            
            context("given referenceImageSavedMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.referenceImageSavedMessage(line: "bar/bar")) }.to(throwError())
                }
            }
        }
    }
}

class RecordedTestClassNameExtractorSpec: QuickSpec {
    override func spec() {
        var subject: TestClassNameExtractor!
        
        beforeEach {
            subject = RecordedTestClassNameExtractor()
        }
        
        describe(".extractTestClassName") {
            context("given kaleidoscopeCommandMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.kaleidoscopeCommandMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given applicationNameMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.applicationNameMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given fbReferenceImageDirMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given snapshotTestErrorMessage") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.snapshotTestErrorMessage(line: "foo/bar")) }.to(throwError())
                }
            }
            
            context("given unknown") {
                it("throws exception") {
                    expect { try subject.extractTestClassName(from: ApplicationLogLine.unknown) }.to(throwError())
                }
            }
            
            context("given referenceImageSavedMessage") {
                context("with valid line") {
                    var logLine: ApplicationLogLine!
                    
                    beforeEach {
                        logLine = ApplicationLogLine.referenceImageSavedMessage(line: "2017-04-25 21:15:37.107 FBSnapshotsViewerExample[56034:787919] Reference image save at: /Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages_64/FBSnapshotsViewerExampleTests/testRecord@2x.png")
                    }
                    
                    it("extracts test name") {
                        expect(try? subject.extractTestClassName(from: logLine)).to(equal("FBSnapshotsViewerExampleTests"))
                    }
                }
                
                context("with invalid line") {
                    it("throws exception") {
                        expect { try subject.extractTestClassName(from: ApplicationLogLine.referenceImageSavedMessage(line: "bar/bar")) }.to(throwError())
                    }
                }
            }
        }
    }
}
