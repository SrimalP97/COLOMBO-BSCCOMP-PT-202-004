//
//  UITestLoginView.swift
//  COLOMBO-BSCCOMP-PT-202-004UITests
//
//  Created by Prabuddha Amunugama on 2022-04-17.
//


import XCTest
@testable import COLOMBO_BSCCOMP_PT_202_004


class UITestLoginView: XCTestCase {
    
    
    
    var app: XCUIApplication!
       
       override func setUp() {
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
       }
       
       override func tearDown() {
           app = nil
       }
    

    func testLoginViewElementExistance(){
                          
          
        let loginView_Image = app.images["back image"]
        let loginView_msg = app.staticTexts["Login msg"]
        let loginView_EmailField = app.textFields["Email"]
        let loginView_passField = app.textFields["text pass"]
        let loginView_PassField2 = app.secureTextFields["secure pass"]
        let  loginView_eyebutton = app.secureTextFields[" eye button"]
        let loginView_SignButton = app.buttons["sign in"]
        
       
        XCTAssert(loginView_Image.exists)
        XCTAssertTrue(loginView_msg.exists )
        XCTAssertTrue(loginView_EmailField.exists )
        XCTAssertTrue(loginView_PassField.exists )
        XCTAssertTrue(loginView_PassField2.exists )
        XCTAssertTrue(loginView_eyebutton.exists )
        XCTAssertTrue(loginView_SignButton.exists )

        
      }
    
    
    
    func testLoginFlow() {
               let email = app.textFields["Email"]
               email.tap()
               email.typeText("srimalprabuddha245@gmail.com")

               let pwd = app.secureTextFields["text pass"]
               pwd.tap()
               pwd.typeText("S12345")

               app.buttons["sign in"].tap()
           }
    
    


    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
