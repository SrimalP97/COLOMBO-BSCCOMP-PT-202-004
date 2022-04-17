//
//  ContentView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-07.
//



import SwiftUI





struct ContentView: View {
    @AppStorage("current_status") var status = false
    
    var body: some View {
    

        NavigationView{
            if status{
                Home()
            }else{
                Home()
            }
        }
    

        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
