//
//  WeChatHomeListRow.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/25.
//

import SwiftUI

struct WeChatHomeListRow: View {
    let chat: Chat
    var body: some View {
        HStack(spacing: 12){
            Image(chat.sender.icon)
                .renderingMode(.original)
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(8.0)
            VStack(alignment: .leading, spacing: 5){
                HStack(alignment: .top){
                    Text(chat.sender.name)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(chat.time)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                Text(chat.desc)
                    .lineLimit(1)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
        }
        .padding(EdgeInsets.init(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
}

struct WeChatHomeListRow_Previews: PreviewProvider {
    static var previews: some View {
        WeChatHomeListRow(chat: .swiftui)
    }
}
