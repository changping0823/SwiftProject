//
//  ChatDetailList.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import SwiftUI

struct ChatDetailList: View {
    @State private var messages: [Message] = []
    var body: some View {
        ScrollView(){
            ScrollViewReader{ proxy in
                LazyVStack(spacing:0){
                    ForEach(messages){message in
                        if let createdAt = message.createdAt {
                            Time(date: createdAt.date)
                        }
                        ChatItem(
                            message: message,
                            isMe: message.member.identifier == Member.me.identifier
                        )
                        .id(message.id)
                    }
                }
                .background(Color("light_gray"))
                .onChange(of: messages, perform: { value in
                    if let lastId = value.last?.id{
                        proxy.scrollTo(lastId, anchor: .top)
                    }
                })
            }
        }
        .onAppear(perform: load)
    }
    
    func load() {
        guard messages.isEmpty else { return }
        messages = Message.all
    }
    
    struct Time: View {
        let date: Date
        
        var body: some View {
            Text(date.formatString)
                .foregroundColor(Color("chat_time"))
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
        }
    }
}

struct ChatDetailList_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailList()
    }
}
