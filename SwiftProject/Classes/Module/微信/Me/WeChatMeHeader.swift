//
//  WeChatMeHeader.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI

struct WeChatMeHeader: View {
    @State var me = Member.me

    var body: some View {
        
        HStack(spacing:20){
            Avatar(icon: me.icon, width: 62, height: 62, cornerRadius: 6)
            VStack(alignment:.leading,spacing:10){
                Text(me.name)
                    .font(.system(size: 22, weight: .medium))
                HStack{
                    Text("微信号：\(me.identifier ?? "")")
                        .foregroundColor(Color.secondary)
                    Spacer()
                    Image("me_qrcode")
                    Image("cell_detail_indicator")
                }
            }
        }.padding(EdgeInsets.init(top: 88, leading: 20, bottom: 30, trailing: 20))
    }
}

struct WeChatMeHeader_Previews: PreviewProvider {
    static var previews: some View {
        WeChatMeHeader()
    }
}
