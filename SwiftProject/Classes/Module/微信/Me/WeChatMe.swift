//
//  WeChatMe.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/25.
//

import SwiftUI

struct WeChatMe: View {
    var body: some View {
        ZStack{
            VStack{
                Color("cell").frame(height:300)
                Color("light_gray")
            }
            WeChatMeListView()
        }
    }
}

struct WeChatMe_Previews: PreviewProvider {
    static var previews: some View {
        WeChatMe()
    }
}
