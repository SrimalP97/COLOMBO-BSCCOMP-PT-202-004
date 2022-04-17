//
//  Login.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//



import SwiftUI

struct Login: View {
    @StateObject var loginVM = LoginViewModel()
    @State var visible = false

    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing, content: {
                GeometryReader{_ in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            Image("LoginBackground2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3)
                                .accessibility(identifier: "back image")
                            
                            
                            NavigationLink {
                                                Register()
                                            } label: {
                                                Text("Don't have an account ? | Sign UP")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.purple)
                                            }
                            
                                            .padding()

                            Text("Log into your account")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.7))
                                .accessibility(identifier: "Login msg")
                            TextField("Email", text: self.$loginVM.login.email)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.loginVM.login.email != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.top, 25)
                                .accessibility(identifier: "Email")
                            HStack(spacing: 15){
                                VStack{
                                    if self.visible{
                                        TextField("Password", text: self.$loginVM.login.pass)
                                            .textInputAutocapitalization(.never)
                                            .accessibility(identifier: "text pass")
                                    }else {
                                        SecureField("Password", text: self.$loginVM.login.pass)
                                            .textInputAutocapitalization(.never)
                                            .accessibility(identifier: "secure pass")
                                    }
                                }
                                
                                Button {
                                    self.visible.toggle()
                                } label: {
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.black.opacity(0.7))
                                        .accessibility(identifier: "eye button")
                                }

                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.loginVM.login.pass != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 25)
                            
                            
                    
                            HStack{
                            
                                NavigationLink {
                                    ForgetPassword()
                                } label: {
                                    Text("Forgot your password ?")
                                      
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.red)
                                        .accessibility(identifier: "forgot pass")
                                }
                            }
                            .padding(.top, 20)
                            
                           Spacer()
                            
                            NavigationLink("Terms & Conditions", destination:TermsAndConditionsView()).foregroundColor(.black)

    
                            
                            Button {
                                loginVM.verify()
                            } label: {
                                Text("Sign In")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .accessibility(identifier: "sign in")
                            }
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.top, 25)

                      
                            
                        }
                        .padding(.horizontal, 25)
                    }

                }
                


            })
                   
            
            if self.loginVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$loginVM.message.alert, error: self.$loginVM.message.error, topic: self.$loginVM.message.topic, loading: self.$loginVM.message.isLoading, guestUser: self.$loginVM.message.guestUser)
                }
            }
        }
        
        
       
        
        
    }
    

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
