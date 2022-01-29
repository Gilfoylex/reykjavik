//
//  HomeView.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/20.
//

import SwiftUI

struct HomeView: View {
    let pacProxy = PacProxy();
    let xrayServer = XrayServer();
    var body: some View {
        VStack {
            Button {
                pacProxy.start();
            } label: {
                Text("start pac server")
            }
            
            Button {
                pacProxy.stop();
            } label: {
                Text("stop pac server")
            }
            
            Button {
                xrayServer.Start();
            } label: {
                Text("start xray server")
            }
            
            Button {
                //xrayServer.Stop();
                testConfig();
            } label: {
                Text("print xray server")
            }
        }
        
    }
    
    func testConfig(){
        var config = Xrayconfig(log: DefaultConfig.log, api: DefaultConfig.api, routing: DefaultConfig.routingConifg, policy: DefaultConfig.policyConfig, inbounds: DefaultConfig.inboundConfigs, outbounds: DefaultConfig.outboundConfigs)
        
        do {
            var ret = try JSONEncoder().encode(config);
            var str = String(data: ret, encoding: .utf8)!;
            print(str);
        }
        catch{
            print(error)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
