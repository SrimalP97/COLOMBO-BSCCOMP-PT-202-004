//
//  TermsAndConditionsView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-16.
//

import SwiftUI


struct TermsAndConditionsView: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: -2.0){
            Text("Welcome to NIBM-Broker! These terms and conditions outline the rules and regulations for the use of NIBM-Broker Application ........")
                .padding(.all, -3.0)
          
                
            
                
        }
        .font(.title2)
        .navigationTitle("Terms & Conditions")
        
    }

}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}

