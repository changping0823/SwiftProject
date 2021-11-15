//
//  WeChatHomeList.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/25.
//

import SwiftUI

struct WeChatHomeList: View {
    @State private var chats:[Chat] = []
    var body: some View {
        ScrollView{
            VStack(){
                ForEach(chats){ chat in
                    NavigationLink(destination: ChatDetail(chat:chat)) {
                        WeChatHomeListRow(chat: chat)
                    }
                    Separator().padding(.leading, 76)
                }
            }
            .background(Color("cell"))
        }
        .onAppear(perform: loadData)
    }
    
    func loadData(){
        guard chats.isEmpty else {
            return
        }
        chats = Chat.all
    }
}

struct WeChatHomeList_Previews: PreviewProvider {
    static var previews: some View {
        WeChatHomeList()
    }
}
