//
//  Avatar.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI

struct Avatar: View {
    let icon: String
    var width: CGFloat? = 42
    var height: CGFloat? = 42
    var cornerRadius: CGFloat = 4
    
    
    var body: some View {
        Image(icon)
            .resizable()
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(icon: "data_avatar7",width: 42,height: 42)
    }
}
