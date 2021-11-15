//
//  MomentHome.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/8.
//

import SwiftUI

struct MomentHome: View {
    
    @Environment(\.statusBarStyle) var statusBarStyle
    
    var body: some View {
        GeometryReader(){ proxy in
            ZStack{
                VStack {
                    Color.black.frame(height: 300) // 下拉时露出的黑色背景
                    Spacer() // 避免到底部上拉出现黑色背景
                }
                MomentList()
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .navigationBarTitle("朋友圈")
        .onDisappear(){
            self.statusBarStyle.current = .default
        }
        
    }
}

struct MomentHome_Previews: PreviewProvider {
    static var previews: some View {
        MomentHome()
    }
}
