//
//  SettingViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI
import Firebase

class SettingViewModel: ObservableObject {
    @AppStorage("current_status") var status = false
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    @Published var userDetails = RegisterModel(nic: "", name: "", dob: Date(), gender: "Male.", mobile: "", email: "", pass: "", repass: "")
    
    let defaults = UserDefaults.standard
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init(){
        initialization()
    }
    
    func verify(){
  
        if self.userDetails.nic != "" && self.userDetails.name != ""  && self.userDetails.mobile != "" {
            if self.userDetails.nic.isValidNIC{
                if  self.userDetails.mobile.isValidContact {
                    updateUserDetails()
                }else{
                    self.message.error = "Invalid Phone Number"
                    self.message.alert.toggle()
                }
            }else{
                self.message.error = "Invalid NIC ID"
                self.message.alert.toggle()
            }
        } else {
            self.message.error = "Please Fill the all the Fields properly"
            self.message.alert.toggle()
        }
    }
    
    func updateUserDetails(){
        ref.collection("Users").document(uid).updateData([
            "nic": self.userDetails.nic,
            "name": self.userDetails.name,
            "mobile": self.userDetails.mobile
        ]){ (err) in
            if err != nil { return}
            self.saveObjects()
        }
    }
    
    func initialization(){
        userDetails.mobile = defaults.string(forKey: "userMobile") ?? ""
        userDetails.nic = defaults.string(forKey: "userNIC") ?? ""
        userDetails.name = defaults.string(forKey: "userName") ?? ""
        userDetails.email = defaults.string(forKey: "userEmail") ?? ""
        userDetails.gender = defaults.string(forKey: "userGender") ?? ""
    }
    
    func logout(){
        self.defaults.removeObject(forKey: "userMobile")
        self.defaults.removeObject(forKey: "userNIC")
        self.defaults.removeObject(forKey: "userName")
        self.defaults.removeObject(forKey: "userDOB")
        self.defaults.removeObject(forKey: "userEmail")
        self.defaults.removeObject(forKey: "userGender")
        self.defaults.removeObject(forKey: "province")
        try! Auth.auth().signOut()
        self.status = true
    }
    
    func saveObjects(){
        self.defaults.removeObject(forKey: "userNIC")
        self.defaults.removeObject(forKey: "userName")
        self.defaults.removeObject(forKey: "userMobile")
        fetchUser() { userDetails in
            self.message.alert.toggle()
            self.message.topic = "Success"
            self.message.error = "Profile Details Updated Successfully"
            self.defaults.setValue(userDetails.nic, forKey: "userNIC")
            self.defaults.setValue(userDetails.name, forKey: "userName")
            self.defaults.setValue(userDetails.mobile, forKey: "userMobile")
        }
        
    }
}

