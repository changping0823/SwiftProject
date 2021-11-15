//
//  WeChatMeRow.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI

struct WeChatMeRow: View {
    let icon: String
    let title: String
    
    
    
    var body: some View {
        HStack(spacing:10){
            Image(icon)
            Text(title)
            Spacer()
            Image("cell_detail_indicator")
        }.padding(EdgeInsets.init(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct WeChatMeRow_Previews: PreviewProvider {
    static var previews: some View {
        WeChatMeRow(icon: "me_pay", title: "支付")
    }
}
