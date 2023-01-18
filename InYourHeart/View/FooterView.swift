//
//  FooterView.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/18.
//

import SwiftUI

struct FooterView: View {
    
    @State private var isAnimated = false
    @Binding var showHeartAlert: Bool
    
    var body: some View {
        HStack{
            Image(systemName: "xmark.circle")
                .font(.system(size: 42,weight: .light))
            Spacer()
            Button(action: {
                self.showHeartAlert.toggle()
            }, label: {
                Text("心中的目的地")
                    .font(.system(.subheadline,design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.horizontal,20)
                    .padding(.vertical,12)
                    .accentColor(Color.pink)
                    .background(Capsule().stroke(Color.pink,lineWidth: 2))
            })
            Spacer()
            Image(systemName: "heart.circle")
                .font(.system(size: 42,weight: .light))
        }
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    @State static var showAlert: Bool = false
    static var previews: some View {
        FooterView(showHeartAlert: $showAlert)
    }
}
