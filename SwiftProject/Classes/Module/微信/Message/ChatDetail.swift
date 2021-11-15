//
//  ChatDetail.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import SwiftUI

struct ChatDetail: View {
    let chat: Chat
    
    var body: some View {
        GeometryReader{proxy in
            VStack(spacing: 0){
                Separator(color: Color("navigation_separator"))
                ChatDetailList()
                ChatTool(proxy: proxy)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("light_gray"))
        .navigationBarTitle(Text(chat.sender.name), displayMode: .inline)
        .onTapGesture {
            /// 隐藏键盘
            UIApplication.shared.endEditing()
        }
    }
}

struct ChatDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetail(chat: .swiftui)
    }
}
