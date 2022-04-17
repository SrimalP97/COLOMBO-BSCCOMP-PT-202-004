//
//  AdvertisementItemView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//





import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct AdvertisementItemView: View {
    @Binding var alert: Bool
    @Binding var topic: String
    @Binding var error: String
    @Binding var guestUser: Bool
    @Binding var showDetails: Bool
    @Binding var selectedADS: PostAds!
    
    var adsDetails : PostAds
    
    var body: some View {
        VStack(spacing: 15){
            HStack(spacing: 10){
                Text(adsDetails.landORhouse)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
            
            }
            
            WebImage(url: URL(string: adsDetails.imagesArray[0])!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                .clipped()

            
            HStack{
                Text("\(adsDetails.townVillage) - \(adsDetails.province)")
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            HStack{
                Text("Price : Rs.\(adsDetails.price, specifier: "%.2f") \nLand Size: \(adsDetails.landSize, specifier: "%.2f") perch")
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            HStack{
                Spacer(minLength: 0)
                Text(adsDetails.dateCreated,style: .time)
                    .font(.caption)
                    .foregroundColor(.black)

            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(2)
        .onTapGesture {
            if ((Auth.auth().currentUser?.uid.isEmpty) == nil){
                alert = true
                topic = "Information"
                error = "Login before view details"
                guestUser = true
            }else{
                withAnimation(.spring()){
                    showDetails = true
                    selectedADS = adsDetails
                }
            }
        }
    }
}













