//
//  WeChatFind.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/25.
//

import SwiftUI

struct WeChatFind: View {
    var body: some View {
        ScrollView{
            VStack{
                Group{
                    NavigationLink(destination: MomentHome()){
                        WeChatFindRow(icon: "discover_moment", title: "朋友圈")
                    }
                    Line()
                }
                Group{
                    WeChatFindRow(icon: "discover_qrcode", title: "扫一扫")
                    Separator().padding(.leading,52)
                    WeChatFindRow(icon: "discover_shake", title: "摇一摇")
                    Line()
                }
                Group {
                    WeChatFindRow(icon: "discover_see", title: "看一看")
                    Separator().padding(.leading, 52)
                    WeChatFindRow(icon: "discover_search", title: "搜一搜")
                    Line()
                }
                Group {
                    WeChatFindRow(icon: "discover_nearby", title: "附近的人")
                    Line()
                }
                Group {
                    WeChatFindRow(icon: "discover_shop", title: "购物")
                    Separator().padding(.leading, 52)
                    WeChatFindRow(icon: "discover_game", title: "游戏")
                    Line()
                }
                Group {
                    WeChatFindRow(icon: "discover_miniprogram", title: "小程序")
                }
            }.background(Color("cell"))
            
        }.background(Color("light_gray"))
    }
    
    struct Line: View {
        var body: some View {
            Rectangle()
                .foregroundColor(Color("light_gray"))
                .frame(height: 8)
        }
    }
}

struct WeChatFind_Previews: PreviewProvider {
    static var previews: some View {
        WeChatFind()
    }
}
