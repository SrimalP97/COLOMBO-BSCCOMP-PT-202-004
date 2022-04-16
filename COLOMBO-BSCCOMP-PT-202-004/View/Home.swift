//
//  Home.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI
import Firebase
import Photos

struct Home: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var locationManager = LocationManagerHelper()

    var body: some View {
        ZStack{
            VStack(spacing: 10){
                HStack(spacing: 15){

                    if ((Auth.auth().currentUser?.uid.isEmpty) != nil){
                        NavigationLink {
                            SettingView()
                                .navigationBarTitle("Account")
                        } label: {
                            Image(systemName: "square.grid.2x2")
                                .font(.title)
                                .foregroundColor(Color.gray)
                        }
                        .navigationBarTitle("Home", displayMode: .inline)
                        .padding()
                    }
                    else{
                        NavigationLink {
                            Login()

                        } label: {
                            Image(systemName: "person.fill")
                                .font(.title)
                                .foregroundColor(Color.blue)
                        }
                        .padding()
                    }

                    
                    Spacer(minLength: 0)
                    
                    Text(locationManager.userlocation == nil ? "  Locating..." : locationManager.userAddress)
                        .font(.title3)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    if ((Auth.auth().currentUser?.uid.isEmpty) != nil){
                        NavigationLink {
                            AdvertisementView()
                                .navigationBarTitle("New Advertisement")
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .foregroundColor(Color.gray)
                        }
                        .navigationBarTitle("Home", displayMode: .inline)
                        .padding()
                    }

                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15){
                    Picker("Filter", selection: $homeVM.filteredData) {
                        ForEach(homeVM.filterArray, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange (of: homeVM.filteredData) { value in
                        if value == "Price Low to High"{
                            self.homeVM.lowToHigh()
                        } else if value == "Price High to Low"{
                            self.homeVM.highToLow()
                        }
                    }
                    
                    TextField("Search",text: $homeVM.search)
                        .textInputAutocapitalization(.never)
                    if homeVM.search != "" {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
            
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach( homeVM.filteredAdvertisement){ data in
                        AdvertisementItemView(alert: $homeVM.message.alert, topic: $homeVM.message.topic, error: $homeVM.message.error, guestUser: $homeVM.message.guestUser, showDetails: $homeVM.showDetails, selectedADS: $homeVM.selecetdADS, adsDetails: data)

                    }
                }
                
                .background(Color.white.opacity(0.6))
            }
            
            if locationManager.noLocation{
                Text("Please Enable Location Access In Settings To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100 , height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
            
            if self.homeVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$homeVM.message.alert, error: self.$homeVM.message.error, topic: self.$homeVM.message.topic, loading: self.$homeVM.message.isLoading, guestUser: $homeVM.message.guestUser)
                }
            }
            
            if homeVM.showDetails{
                GeometryReader{_ in
                    AdvertisementDetailView(adsDetail: homeVM.selecetdADS, show: $homeVM.showDetails)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            locationManager.locationManager.delegate = locationManager
        }
        .onChange(of: homeVM.search, perform: { value in
            // to avoid Continuos Search Request...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == homeVM.search && homeVM.search != ""{
                    // search data.....
                    homeVM.searchData()
                }
            }
            
            if homeVM.search == ""{
                withAnimation(.linear) {
                    homeVM.filteredAdvertisement = homeVM.advertisementPost
                }
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
