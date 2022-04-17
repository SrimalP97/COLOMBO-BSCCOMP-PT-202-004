//
//  Register.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI

struct Register: View {
    @StateObject var registerVM = RegisterViewModel()
    @Environment(\.presentationMode) var present
     
    var body: some View {
        ZStack{
            ZStack(alignment: .topLeading, content: {
                GeometryReader{_ in
                    ScrollView{
                        LazyVStack{
                        Text(" Create your account !")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding(.top, 15)
                            
                            TextField("NIC(ex: 972660892)", text: self.$registerVM.register.nic)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.registerVM.register.nic != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 20)
                            
                            TextField("Name", text: self.$registerVM.register.name)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.registerVM.register.name != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 20)
                            
                            DatePicker("DOB", selection: $registerVM.register.dob, in: registerVM.closedRange...Date(), displayedComponents: .date)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.registerVM.register.dob.formatted(date: .long, time: .omitted) != Date.init().formatted(date: .long, time: .omitted) ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 20)
                            
                            HStack(spacing: 15){
                                Text("Gender")
                                Spacer()
                                Picker("Gender", selection: $registerVM.register.gender) {
                                    ForEach(registerVM.genderArray, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.gender != "Male." ? Color("Color") :  Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            TextField("Mobile", text: self.$registerVM.register.mobile)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.registerVM.register.mobile != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 20)
                            
                            TextField("Email", text: self.$registerVM.register.email)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.registerVM.register.email != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 20)
                            
                            HStack(spacing: 15){
                                VStack{
                                    if self.registerVM.visible{
                                        TextField("Password", text: self.$registerVM.register.pass)
                                            .textInputAutocapitalization(.never)
                                    }else {
                                        SecureField("Password", text: self.$registerVM.register.pass)
                                            .textInputAutocapitalization(.never)
                                    }
                                }
                                
                                Button {
                                    self.registerVM.visible.toggle()
                                } label: {
                                    Image(systemName: self.registerVM.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }

                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.pass != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            HStack(spacing: 15){
                                VStack{
                                    if self.registerVM.revisible{
                                        TextField("Re-enter Password", text: self.$registerVM.register.repass)
                                            .textInputAutocapitalization(.never)
                                    }else {
                                        SecureField("Re-enter Password", text: self.$registerVM.register.repass)
                                            .textInputAutocapitalization(.never)
                                    }
                                }

                                Button {
                                    self.registerVM.revisible.toggle()
                                } label: {
                                    Image(systemName: self.registerVM.revisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                }

                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.registerVM.register.repass != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 20)
                            
                            Button {
                                registerVM.verifyRegistration()
                            } label: {
                                Text("Sign Up")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.top, 20)

                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    self.present.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color("Color"))
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Color"))
                    }
                }
                .padding()

            })
            if self.registerVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$registerVM.message.alert, error: self.$registerVM.message.error, topic: self.$registerVM.message.topic, loading: self.$registerVM.message.isLoading, guestUser: $registerVM.message.guestUser)
                }
            }
        }
    
    }

}


