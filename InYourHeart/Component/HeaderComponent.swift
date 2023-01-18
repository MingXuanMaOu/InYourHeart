//
//  HeaderComponent.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/18.
//

import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        VStack(alignment: .center,spacing: 20, content: {
            Capsule()
                .frame(width: 128,height: 6)
                .foregroundColor(.secondary)
                .opacity(0.2)
            Image("logo-InYourHeart")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
        })
    }
}

struct HeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeaderComponent()
    }
}
