//
//  WeChatMeListView.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI

struct WeChatMeListView: View {
    var body: some View {
        ScrollView{
            Group{
                WeChatMeHeader()
                Line()
            }
            Group{
                WeChatMeRow(icon: "me_pay", title: "支付")
                Line()
            }
            Group{
                WeChatMeRow(icon: "me_favorite", title: "收藏")
                Separator().padding(.leading, 52)
                WeChatMeRow(icon: "me_photo_album", title: "相册")
                Separator().padding(.leading, 52)
                WeChatMeRow(icon: "me_bank_card", title: "卡包")
                Separator().padding(.leading, 52)
                WeChatMeRow(icon: "me_emoji", title: "表情")
                Line()
            }
            Group {
                WeChatMeRow(icon: "me_setting", title: "设置")
                Line()
            }
        }.background(Color("cell"))
    }
    
    
    struct Line: View {
        var body: some View {
            Rectangle()
                .foregroundColor(Color("light_gray"))
                .frame(height: 8)
        }
    }
}

struct WeChatMeListView_Previews: PreviewProvider {
    static var previews: some View {
        WeChatMeListView()
    }
}
