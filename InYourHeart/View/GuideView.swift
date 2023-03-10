//
//  GuideView.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/18.
//

import SwiftUI

struct GuideView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .center,spacing: 20, content: {
                HeaderComponent()
                Spacer(minLength: 10)
                Text("开始")
                    .fontWeight(.black)
                    .font(.largeTitle)
                    .foregroundColor(.pink)
                
                Text("发现最美丽的目的地，只需要你动动手指头!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                Spacer()
                VStack(alignment: .leading,spacing: 25, content: {
                    GuideComponent(
                      title: "喜爱",
                      subtitle: "右滑照片",
                      description: "如果你喜欢这张图片，就可以按住照片然后向右滑动，它将会保存到我的最爱之中。",
                      icon: "heart.circle")
                    
                    GuideComponent(
                      title: "不喜爱",
                      subtitle: "左滑照片",
                      description: "如果你不喜欢这张图片，就可以按住照片然后向左滑动，你将不会再看到它。",
                      icon: "xmark.circle")
                    
                    GuideComponent(
                      title: "预订",
                      subtitle: "点击按钮",
                      description: "如果你喜欢这个目的",icon: "checkmark.square")
                })
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("让我们继续")
                        .modifier(ButtonModifier())
                })
                .foregroundColor(.white)
            })
            .frame(minWidth: 0,maxWidth: .infinity)
            .padding(.top,15)
            .padding(.bottom,25)
            .padding(.horizontal,25)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
