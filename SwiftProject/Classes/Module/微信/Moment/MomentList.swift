//
//  MomentList.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI

struct MomentList: View {
    @State private var moments: [Moment] = []
    
    var body: some View {
        ScrollView{
            LazyVStack{
                MomentHeaderView()
                ForEach(self.moments){moment in
                    VStack(spacing:0){
                        MomentRow(moment: moment)
                        Separator()
                    }
                }
            }
            .background(Color("cell"))
        }
        .onAppear(){
            load()
        }
    }
    
    func load() {
        guard moments.isEmpty else { return }
        moments = Moment.page1
    }
}

struct MomentList_Previews: PreviewProvider {
    static var previews: some View {
        MomentList()
    }
}
