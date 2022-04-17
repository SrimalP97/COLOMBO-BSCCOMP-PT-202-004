//
//  SettingView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI
import Firebase

struct SettingView: View {
    @StateObject private var settingVM = SettingViewModel()
    
    var body: some View {
        ZStack{
            VStack{
            
                Form{
                Section(header: Text("My Profile")) {
                    TextField("Name", text: $settingVM.userDetails.name).textInputAutocapitalization(.never)
                    TextField("NIC", text: $settingVM.userDetails.nic).textInputAutocapitalization(.never)
                    TextField("Mobile Number", text: $settingVM.userDetails.mobile).textInputAutocapitalization(.never)
                    Text(settingVM.userDetails.email).foregroundColor(.gray)
                    Text(settingVM.userDetails.gender).foregroundColor(.gray)
                }

                Section(header: Text("Action")){
                    Button {
                        self.settingVM.logout()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
        }
            if self.settingVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$settingVM.message.alert, error: self.$settingVM.message.error, topic: self.$settingVM.message.topic, loading: self.$settingVM.message.isLoading, guestUser: $settingVM.message.guestUser)
                }
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    self.settingVM.verify()
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



