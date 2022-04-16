//
//  LoginViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var login = LoginModel(email: "", pass: "")
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    @AppStorage("current_status") var status = true
    let defaults = UserDefaults.standard
    
    func verify(){
        if self.login.email != "" && self.login.pass != "" {
            loginWithEmail();
        } else {
            self.message.error = "Please Fill the all the Fields properly"
            self.message.alert.toggle()
        }
    }
    
    func loginWithEmail(){
        self.message.alert.toggle()
        self.message.isLoading = true
        Auth.auth().signIn(withEmail: self.login.email, password: self.login.pass) { (res , err)  in
            if err != nil {
                self.message.isLoading = false
                self.message.error = err!.localizedDescription
            }else{
                
                fetchUser() { userDetails in
                    self.defaults.setValue(userDetails.mobile, forKey: "userMobile")
                    self.defaults.setValue(userDetails.nic, forKey: "userNIC")
                    self.defaults.setValue(userDetails.name, forKey: "userName")
                    self.defaults.setValue(userDetails.dob, forKey: "userDOB")
                    self.defaults.setValue(userDetails.email, forKey: "userEmail")
                    self.defaults.setValue(userDetails.gender, forKey: "userGender")
                    self.message.alert.toggle()
                    self.message.isLoading = false
                    self.status = false
                }

            }
        }
    }
    
}

