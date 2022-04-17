//
//  AdvertisementDetailView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//




import SwiftUI
import SDWebImageSwiftUI

struct AdvertisementDetailView: View {
    var adsDetail: PostAds!
    @Binding var show: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack{
                Button {
                    self.show = false
                } label: {
                    Image(systemName: "chevron.left")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("Color"))
                }
                
                
                Spacer()

            }
            .padding()
            VStack(alignment: .center, spacing: 20) {
                
                WebImage(url: URL(string: adsDetail.imagesArray[0]))
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                    .clipped()

                HStack {
                    Spacer()
                    Text(adsDetail.dateCreated,style: .date)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.trailing,20)
                VStack(alignment: .leading, spacing: 10) {
                    Text(adsDetail.landORhouse)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)

                    Text("Price : Rs.\(adsDetail.price, specifier: "%.2f") \nLand Size: \(adsDetail.landSize, specifier: "%.2f") perch")
                        .font(.headline)
                        .multilineTextAlignment(.leading)

                    Text("\(adsDetail.townVillage),\(adsDetail.district) - \(adsDetail.province)".uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Images")
                        .foregroundColor(.gray)
                        .font(.caption)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 20){
                            ForEach(1..<adsDetail.imagesArray.count, id: \.self){i in
                                WebImage(url: URL(string: adsDetail.imagesArray[i]))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray.opacity(0.5))
                                    }
                                    .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / 4,height: 100)
                                    .clipped()
                                    .cornerRadius(20)
                                
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    Text("Original Document")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    WebImage(url: URL(string: adsDetail.deedImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 30,height: UIScreen.main.bounds.height - 100)
                        .clipped()
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640, alignment: .center)
            }
        }
        .background(Color.white)
    }
}
