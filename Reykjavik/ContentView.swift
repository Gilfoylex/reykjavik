//
//  ContentView.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .frame(minWidth: 600, idealWidth: 600, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity)
            //.frame(width: getRect().width / 1.75, height: getRect().height - 130)
        //HomeView()
            //force light theme
            .preferredColorScheme(.dark)
        //Text("hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
