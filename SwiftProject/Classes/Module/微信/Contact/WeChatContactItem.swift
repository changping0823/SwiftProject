//
//  WeChatContactItem.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import SwiftUI

enum Style {
    case system
    case member
}

struct WeChatContactItem: View {
    let icon: String
    let title: String
    let style: Style
    
    var body: some View {

        HStack(spacing:12){/// spacing : 组件之间的间距
            Image(icon)
                .renderingMode(.original)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(style == .system ? 4 : 6)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }.padding(EdgeInsets.init(top: 10, leading: 16, bottom: 10, trailing: 16))
    }
    

}

struct WeChatContactItem_Previews: PreviewProvider {
    static var previews: some View {
        WeChatContactItem(icon: "contact_new_friend", title: "新的朋友", style: .system)
    }
}
