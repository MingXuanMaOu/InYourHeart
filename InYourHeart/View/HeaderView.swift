//
//  HeaderView.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/18.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var showGuidView: Bool
    @Binding var showInfoView: Bool
    
    var body: some View {
        HStack{
            Button(action: {
                self.showInfoView.toggle()
            }, label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24,weight: .regular))
            })
            .accentColor(.primary)
            .sheet(isPresented: $showInfoView, content: {
                InfoView()
            })
            
            Spacer()
            
            Image("logo-InYourHeart-Pink")
                .resizable()
                .scaledToFit()
                .frame(height: 38)
            Spacer()
            
            Button(action: {
                self.showGuidView.toggle()
            }, label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24,weight: .regular))
            })
            .accentColor(.primary)
            .sheet(isPresented: $showGuidView, content: {
                GuideView()
            })
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuideView = false
    @State static var showInfoView = false
    static var previews: some View {
        HeaderView(showGuidView: $showGuideView,showInfoView: $showInfoView)
    }
}
