//
//  ACEViewSwiftTests.swift
//  ACEViewSwiftTests
//
//  Created by Vasilis Akoinoglou on 24/11/15.
//  Copyright © 2015 Vasilis Akoinoglou. All rights reserved.
//

import XCTest
@testable import ACEViewSwift



class ACEViewSwiftTests: XCTestCase {
    
    class ACEDelegate: ACEViewDelegate {
        
        var didLoadExpectation: XCTestExpectation?
        
        // didLoad should be called on the delegate
        @objc func aceViewDidLoad() {
            didLoadExpectation?.fulfill()
        }
    }
    
    var aceView: ACEView!
    var delegate: ACEDelegate!
    
    
    func wait(seconds: NSTimeInterval = 5.0) {
        waitForExpectationsWithTimeout(seconds, handler: nil)
    }
    
    override func setUp() {
        super.setUp()
        
        aceView = ACEView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        
        delegate = ACEDelegate()
        aceView.delegate = delegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testACEViewInitialization() {
        
        let readyExpectation = expectationWithDescription("onReady")
        
        delegate.didLoadExpectation = expectationWithDescription("onDidLoad")
        
        // onReady should be called eventually
        aceView.onReady = {
            readyExpectation.fulfill()
        }
        
        wait()
    }
    
    func testStringAccessor() {
        let readyExpectation = expectationWithDescription("onReady")
        
        aceView.onReady = {
            readyExpectation.fulfill()
            XCTAssertTrue(self.aceView.string.isEmpty, "String should be empty on initialization")
            let newValue = "Something"
            self.aceView.string = newValue
            XCTAssertEqual(self.aceView.string, newValue, "String should be 'Something' at this point")
        }
        
        wait()
    }
    
    func testMode() {
        let readyExpectation = expectationWithDescription("onReady")
        
        aceView.onReady = {
            readyExpectation.fulfill()
            XCTAssertEqual(self.aceView.mode.name, "text", "Mode should be 'text' by default")
            let newMode = ACEMode.HTML
            self.aceView.mode = newMode
            XCTAssertEqual(self.aceView.mode, newMode)
            XCTAssertEqual(self.aceView.mode.name, "html", "Mode should be now changed to 'html'")
        }
        
        wait()
    }
    
    func testTheme() {
        let readyExpectation = expectationWithDescription("onReady")
        
        aceView.onReady = {
            readyExpectation.fulfill()
            XCTAssertEqual(self.aceView.theme.name, "None", "Theme should be 'None' by default")
            let newTheme = ACETheme.Monokai
            self.aceView.theme = newTheme
            XCTAssertEqual(self.aceView.theme, ACETheme.Monokai)
            XCTAssertEqual(self.aceView.theme.name, "monokai", "Mode should be now changed to 'Monokai'")
        }
        
        wait()
    }
    
}