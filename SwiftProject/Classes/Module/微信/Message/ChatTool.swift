//
//  ChatTool.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import SwiftUI

struct ChatTool: View {
    let proxy : GeometryProxy
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            Separator(color: Color("chat_send_line"))
            ZStack(){
                Color("chat_send_background")
                VStack(){
                    HStack(spacing:12){
                        Image("chat_send_voice")
                        TextField("", text: $text)
                            .frame(height:40)
                            .background(Color("chat_send_text_background"))
                            .cornerRadius(4)
                        
                        Image("chat_send_emoji")
                        Image("chat_send_more")
                    }
                    .frame(height: 56)
                    .padding(.horizontal, 12)
                    Spacer()
                }
            }
            .frame(height: proxy.safeAreaInsets.bottom + 56)
        }
    }
}

//struct ChatTool_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatTool(proxy: .swiftui)
//    }
//}
