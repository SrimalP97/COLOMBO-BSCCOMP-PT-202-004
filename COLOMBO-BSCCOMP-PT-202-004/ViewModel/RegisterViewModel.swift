//
//  RegisterViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//



import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    @Published var register = RegisterModel(nic: "", name: "", dob: Date(), gender: "Male.", mobile: "", email: "", pass: "", repass: "")
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    @Published var genderArray = ["Male", "Female", "Other"]
    @Published var closedRange = Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    @Published var visible = false
    @Published var revisible = false
    @AppStorage("current_status") var status = false

    let ref = Firestore.firestore()
    
    
    func verifyRegistration(){
  
        if self.register.nic != "" && self.register.name != "" && self.register.dob.formatted(date: .long, time: .omitted) != Date.init().formatted(date: .long, time: .omitted) && self.register.gender != "Male." && self.register.mobile != "" && self.register.email != "" && self.register.pass != "" && self.register.repass != "" {
            if self.register.nic.isValidNIC{
                if  self.register.mobile.isValidContact {
                    if self.register.pass == self.register.repass {
                        createNewAccount()
                    }else{
                            self.message.error = "Password mismatch"
                            self.message.alert.toggle()
                    }
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

    
    func createNewAccount(){
        self.message.alert.toggle()
        self.message.isLoading = true
        Auth.auth().createUser(withEmail: self.register.email, password: self.register.pass) { (res , err)  in
            if err != nil {
                self.message.isLoading = false
                self.message.error = err!.localizedDescription
            }else{
                let uid = res?.user.uid
                self.ref.collection("Users").document(uid!).setData([
                    "uid" : uid,
                    "nic" : self.register.nic,
                    "name" :self.register.name,
                    "dob" : self.register.dob.formatted(date: .long, time: .omitted),
                    "gender" : self.register.gender,
                    "mobile" : self.register.mobile,
                    "email" : self.register.email,
                    "dateCreated" : Date.init()
                    
                ]) { (err) in
                    if err != nil {
                        self.message.isLoading = false
                        self.message.error = err!.localizedDescription
                    }else{
                        self.message.isLoading = false
                        self.message.topic = "Success"
                        self.message.error = "Registered Successfully"
                        self.register = RegisterModel(nic: "", name: "", dob: Date(), gender: "Male.", mobile: "", email: "", pass: "", repass: "")
                    }
                }
            }
        }
    }
}













//import SwiftUI
//import Firebase
//
//class RegisterViewModel: ObservableObject {
//    @Published var register = RegisterModel(nic: "", name: "", dob: Date(), gender: "Male.", mobile: "", email: "", pass: "", repass: "")
//    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
//    @Published var genderArray = ["Male", "Female", "Other"]
//    @Published var closedRange = Calendar.current.date(byAdding: .year, value: -120, to: Date())!
//    @Published var visible = false
//    @Published var revisible = false
//    @AppStorage("current_status") var status = false
//
//    let ref = Firestore.firestore()
//
//
//    func verifyRegistration(){
//
//        if self.register.nic != "" && self.register.name != "" && self.register.dob.formatted(date: .long, time: .omitted) != Date.init().formatted(date: .long, time: .omitted) && self.register.gender != "Male." && self.register.mobile != "" && self.register.email != "" && self.register.pass != "" && self.register.repass != "" {
//            if self.register.nic.isValidNIC{
//                if  self.register.mobile.isValidContact {
//                    if self.register.pass == self.register.repass {
//                        createNewAccount()
//                    }else{
//                            self.message.error = "Invalid Password"
//                            self.message.alert.toggle()
//                    }
//                }else{
//                    self.message.error = "Invalid Phone Number"
//                    self.message.alert.toggle()
//                }
//            }else{
//                self.message.error = "Invalid NIC ID"
//                self.message.alert.toggle()
//            }
//        } else {
//            self.message.error = "Please Fill the all the Fields properly"
//            self.message.alert.toggle()
//        }
//    }
//
//
//    @available(iOS 15.0, *)
//    func createNewAccount(){
//        self.message.alert.toggle()
//        self.message.isLoading = true
//        Auth.auth().createUser(withEmail: self.register.email, password: self.register.pass) { (res , err)  in
//            if err != nil {
//                self.message.isLoading = false
//                self.message.error = err!.localizedDescription
//            }else{
//                let uid = res?.user.uid
//                if #available(iOS 14.0, *) {
//                    self.ref.collection("Users").document(uid!).setData([
//                        "uid" : uid,
//                        "nic" : self.register.nic,
//                        "name" :self.register.name,
//                        "dob" : self.register.dob.formatted(date: .long, time: .omitted),
//                        "gender" : self.register.gender,
//                        "mobile" : self.register.mobile,
//                        "email" : self.register.email,
//                        "dateCreated" : Date.init()
//
//                    ]) { (err) in
//                        if err != nil {
//                            self.message.isLoading = false
//                            self.message.error = err!.localizedDescription
//                        }else{
//                            self.message.isLoading = false
//                            self.message.topic = "Success"
//                            self.message.error = "Registered Successfully"
//                            self.register = RegisterModel(nic: "", name: "", dob: Date(), gender: "Male.", mobile: "", email: "", pass: "", repass: "")
//                        }
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
//            }
//        }
//    }
//}
//
//
//
//
//
