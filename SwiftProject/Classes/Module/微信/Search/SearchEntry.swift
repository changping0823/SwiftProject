//
//  SearchEntry.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import SwiftUI

struct SearchEntry: View {
    @State private var isSearchPresented: Bool = false
    
    var body: some View {
        Button(action: {self.isSearchPresented.toggle()}){
            VStack{
                Spacer()
                HStack(spacing: 4){
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundColor(Color.secondary)
                    Text("搜索")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                    Spacer()
                }
                Spacer()
            }
            .background(Color("search_corner_background"))
            .cornerRadius(6)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            
        }
        .background(Color("light_gray"))
        .sheet(isPresented: $isSearchPresented, content: {
            SearchHome()
        })
    }
}

struct SearchEntry_Previews: PreviewProvider {
    static var previews: some View {
        SearchEntry()
    }
}
