//
//  WeChatContact.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/25.
//

import SwiftUI

struct WeChatContact: View {
    var body: some View {
        ZStack(){
            VStack {
                Color("light_gray").frame(height: 300) // 下拉时露出的灰色背景
                Spacer() // 避免到底部上拉出现背景
            }
            
            WeChatContactList()
        }
    }
}

struct WeChatContact_Previews: PreviewProvider {
    static var previews: some View {
        WeChatContact()
    }
}
