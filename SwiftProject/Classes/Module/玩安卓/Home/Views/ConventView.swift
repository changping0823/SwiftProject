//
//  ConventView.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/24.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailContentView()) {
                Text("按钮").font(.largeTitle)
            }
                .navigationBarTitle("你好哇，李銀河", displayMode: .inline)
                .navigationBarItems(
                    leading:Button("返回") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
        }
    }
    @Environment(\.presentationMode) var presentationMode
}

struct DestinationView: View {

    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            Text("你好哇，李银河。你好哇，李银河。你好哇，李银河")
                .background(Color.green)
                .font(.title)
            
            Text("你好哇，李银河")
                .background(Color.red)
                .font(.title)
            
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("按钮").font(.largeTitle)
            })
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.red)
            .foregroundColor(.white)
            
        })
        
    }
    
    @Environment(\.presentationMode) var presentationMode
}

struct ConventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
            
    }
}
