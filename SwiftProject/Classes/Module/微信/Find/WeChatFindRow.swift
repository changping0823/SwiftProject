//
//  WeChatFindRow.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/8.
//

import SwiftUI

struct WeChatFindRow: View {
    let icon: String
    let title: String
    
    
    var body: some View {

        HStack{
            Image(icon)
                .renderingMode(.original)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            Spacer()
            Image("cell_detail_indicator")
        }.padding()
        .frame(height:54)
        
    }
}

struct WeChatFindRow_Previews: PreviewProvider {
    static var previews: some View {
        WeChatFindRow(icon: "discover_moment", title: "朋友圈")
    }
}
