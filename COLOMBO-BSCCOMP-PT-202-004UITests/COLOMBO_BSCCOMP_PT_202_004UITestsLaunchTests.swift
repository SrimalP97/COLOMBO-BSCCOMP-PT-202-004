//
//  COLOMBO_BSCCOMP_PT_202_004UITestsLaunchTests.swift
//  COLOMBO-BSCCOMP-PT-202-004UITests
//
//  Created by Prabuddha Amunugama on 2022-04-07.
//

import XCTest

class COLOMBO_BSCCOMP_PT_202_004UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
