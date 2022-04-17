//
//  LoginViewModelTest.swift
//  COLOMBO-BSCCOMP-PT-202-004Tests
//
//  Created by Prabuddha Amunugama on 2022-04-17.
//



import XCTest
@testable import COLOMBO_BSCCOMP_PT_202_004

var viewModel : LoginViewModel!

func setUp() {
        viewModel = .init()
    }




class LoginViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
        func testLoginwithCorrcetDetailsSetSuccessPresentToTrue() {
              
               viewModel.loginWithEmail()
               viewModel.message.isLoading = false
               XCTAssertTrue(viewModel.status)
           }
           
           func testServerRespondsWithUnkownCredentials() {
               viewModel.login.email = "valid@mail.com"
               viewModel.login.pass = "password"
               XCTAssertNotNil(viewModel.login.email)
               XCTAssertNotNil(viewModel.login.pass)

               viewModel.message.error = "Error Login Credititals"
               viewModel.message.topic = "Error"
               viewModel.message.alert.toggle()

               let testExpectation = expectation(description: "Expected login completion success message to be called")

               viewModel.loginWithEmail()

               testExpectation.fulfill()

               waitForExpectations(timeout: 1, handler: nil)
           }
       }
        
        
        
        
        
        
        
        
    }

   



