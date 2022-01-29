//
//  MainView.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/20.
//

import SwiftUI

struct MainView: View {
    @State var currentTab : String = "HOME"
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TabButton(tabName: "HOME", sfSymbolName: "house")
                
                TabButton(tabName: "PROXY", sfSymbolName: "xserve")
                
                Spacer()
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.top, 40)
            
            switch currentTab {
            case "HOME" :
                HomeView()
            case "PROXY" :
                ProxyView()
                
            default: HomeView()
            }
        }
    }
    
    func onTaped(tabName: String){
        currentTab = tabName
    }
    @ViewBuilder
    func TabButton(tabName: String, sfSymbolName: String) ->some View {
        Button {
            onTaped(tabName: tabName)
        } label: {
            HStack(spacing:10) {
                Image(systemName: sfSymbolName)
                    .resizable()
                    //.renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(currentTab == tabName ? .blue : .gray)
                    .frame(width: 22, height: 22)
                Text(tabName)
                    .foregroundColor(currentTab == tabName ? .blue : .gray)
                
                Spacer()
            }
            .padding(.leading, 10)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
