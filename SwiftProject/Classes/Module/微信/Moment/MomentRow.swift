//
//  MomentRow.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/10.
//

import SwiftUI


struct MomentRow: View {
    let moment: Moment

    var body: some View {
        HStack{
            Avatar(icon: moment.author.icon)
            VStack{
                
            }
        }
    }
}

struct MomentRow_Previews: PreviewProvider {
    static var previews: some View {
        MomentRow(moment: Moment.page1[0])
    }
}
