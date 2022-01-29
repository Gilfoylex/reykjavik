//
//  DefaultConfig.swift
//  Reykjavik
//
//  Created by PUMA on 2022/1/29.
//

import Foundation

struct DefaultConfig {
    static var SocksPort = 2334
    static var HttpPort = 2335
    static var PacPort = 2336
    static var ApiPort = 2337
    static var log = Log(loglevel: "Debug")
    static var api = API(tag: "api", services: ["StatsService"])
    static var apiRule = Rule(type: "field", inboundTag: ["api"], outboundTag: "api")
    static var apiAdblock = Rule(type: "field", domain: ["geosite:category-ads-all"], outboundTag: "block")
    static var routingConifg = Routing(domainStrategy: "AsIs", rules: [Self.apiRule, Self.apiAdblock])
    static var policyConfig = Policy(levels: ["0": Level()], system: PolicySystem())
    static var inboundConfigs = [
        InBound(tag: "MainSockTag", listen: "127.0.0.1", port: SocksPort, inBoundProtocol: "socks", settings: InBoundProtocols(udp: true)),
        InBound(tag: "MainHttpTag", listen: "127.0.0.1", port: HttpPort, inBoundProtocol: "http", settings: InBoundProtocols()),
        InBound(tag: "MainApiTag", listen: "127.0.0.1", port: ApiPort, inBoundProtocol: "dokodemo-door", settings: InBoundProtocols(address: "127.0.0.1")),
    ]
    
    static var outboundConfigs = [
        // 自由出口
        Outbound(tag: "direct_out", outboundProtocol: "freedom"),
        
        // 出到黑洞，用于广告拦截，一定要放到最后一个
        Outbound(tag: "block", outboundProtocol: "blackhole")
    ]
}
