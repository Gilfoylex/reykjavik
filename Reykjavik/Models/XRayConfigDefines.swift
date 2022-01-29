//
//  XRayConfigDefine.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/27.
//

import Foundation

// MARK: - Log
struct Log: Codable {
    var access, error : String?
    var loglevel: String	    
    var dnsLog: Bool?
}

// MARK: - API
struct API: Codable {
    var tag = "api"
    var services: [String] // "HandlerService", "LoggerService", "StatsService"
}

// MARK: - Rule
struct Rule: Codable {
    var type: String?
    var domain, ip: [String]?
    var port, sourcePort, network: String?
    var source, user, inboundTag, ruleProtocol: [String]?
    var attrs, outboundTag, balancerTag: String?
}

// MARK: - Routing
struct Routing: Codable {
    var domainStrategy: String
    var rules: [Rule]
}

// MARK: - Level
struct Level: Codable {
    var handshake, connIdle, uplinkOnly, downlinkOnly: Int?
    var statsUserUplink = true
    var statsUserDownlink = true
    var bufferSize: Int?
}

// MARK: - PolicySystem
struct PolicySystem: Codable {
    var statsInboundUplink = true
    var statsInboundDownlink = true
    var statsOutboundUplink = true
    var statsOutboundDownlink = true
}

// MARK: -Policy
struct Policy : Codable {
    var levels : Dictionary<String, Level>
    var system : PolicySystem
}

// MARK: - Allocate
struct Allocate: Codable {
    var strategy: String
    var refresh, concurrency: Int
}

// MARK: - Settings
struct Settings: Codable {
}

// MARK: - Sniffing
struct Sniffing: Codable {
    var enabled: Bool
    var destOverride: [String]
}

struct Account: Codable {
    var user, pass: String
}

// MARK: -入站协议
struct InBoundProtocols : Codable {
    // MARK: -DokodemoDoor
    var address: String?
    var port: Int?
    var network: String?
    var timeout: Int?
    var followRedirect: Bool?
    var userLevel: Int?
    
    // MARK: - HTTP
    //var timeout: Int
    var accounts: [Account]?
    var allowTransparent: Bool?
    //var userLevel: Int
    
    // MARK: - SOCKS
    var auth: String?
    //var accounts: [Account]
    var udp: Bool?
    var ip: String?
    //var userLevel: Int
}

struct TlsSetting : Codable {
    var serverName: String
    var allowInsecure = true
    var rejectUnknownSni : Bool?
    var alpn: [String]?
    var minVersion, maxVersion, cipherSuites: String?
    //var certificates: [JSONAny]
    //var disableSystemRoot, enableSessionResumption: Bool
    //var fingerprint: String
}

struct TcpSetting : Codable {
    var acceptProxyProtocol = false;
    var headers : [String: String]?
}

struct WsSetting : Codable {
    var path = ""
    var headers : [String : String]?
}

// MARK: - StreamSettings
struct StreamSettings: Codable {
    var network = "tcp"
    var security = "none"
    var tlsSettings : TlsSetting?
    var xtlsSettings : TlsSetting?
    var tcpSettings : TcpSetting?
    var wsSetting : WsSetting?
    var sockopt: Sockopt?
}

// MARK: - Sockopt
struct Sockopt: Codable {
    var mark: Int?
    var tcpFastOpen = false
    var tproxy, domainStrategy, dialerProxy: String?
    var acceptProxyProtocol: Bool?
}


// MARK: - InBound
struct InBound : Codable {
    var tag: String
    var listen : String
    var port : Int
    var inBoundProtocol : String
    var settings : InBoundProtocols
    var streamSettings : StreamSettings?
    var sniffing: Sniffing?
    var allocate: Allocate?
    
    enum CodingKeys: String, CodingKey {
        case listen, port, settings, tag, sniffing, allocate, streamSettings
        case inBoundProtocol = "protocol"
    }
}

// MARK: - VLessUser
struct VLessUser: Codable {
    var id :String
    var encryption = "none"
    var flow: String?
    var level: Int = 0
}

// MARK: - VnextVless
struct VnextVless: Codable {
    var address: String
    var port: Int
    var users: [VLessUser] = []
}

// MARK: - TrojanServer
struct TrojanServer: Codable {
    var address: String
    var port: Int
    var password : String
    var level: Int = 0
}

struct Response : Codable {
    var type : String
}

// MARK: - OutboundSettings
struct OutboundSettings : Codable {
    // balckhole
    var response : Response?
    
    // freedom
    var domainStrategy : String?
    var redirect : String?
    var userLevel : Int?
    
    // vless
    var vnext : [VnextVless]?
    
    // trojan
    var servers : [TrojanServer]?
}

// MARK: - Outbound
struct Outbound: Codable {
    var tag = ""
    var outboundProtocol: String
    var sendThrough : String?
    var settings: OutboundSettings?
    var streamSettings: StreamSettings?
    var proxySettings: ProxySettings?
    var mux: Mux?

    enum CodingKeys: String, CodingKey {
        case sendThrough, settings, tag, streamSettings, proxySettings, mux
        case outboundProtocol = "protocol"
    }
}

// MARK: - Mux
struct Mux: Codable {
    var enable = false
    var concurrency = 8
}

// MARK: - ProxySettings
struct ProxySettings: Codable {
    var tag: String
}

struct EmptyProject : Codable {
    
}

// MARK: - Xrayconfig
struct Xrayconfig: Codable {
    var log : Log
    var api : API
    var routing: Routing
    var policy: Policy
    var inbounds : [InBound]
    var outbounds : [Outbound]
    var transport : EmptyProject?
    var stats = EmptyProject()
    var reverse : EmptyProject?
    var fakedns: EmptyProject?
}
