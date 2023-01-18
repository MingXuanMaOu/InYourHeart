//
//  TitleModifier.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/19.
//

import SwiftUI

struct TitleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.title)
            .foregroundColor(.pink)
    }
}
