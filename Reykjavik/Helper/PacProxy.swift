//
//  PacProxy.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/20.
//

import Foundation
import Swifter
import Dispatch


//  这个类的接口不是线程安全的，记得都要在主线程下调用
class PacProxy {
    private var _server : HttpServer
    private var _semaPhore : DispatchSemaphore
    private var _isStarted : Bool = false;
    init(){
        _semaPhore = DispatchSemaphore(value: 0);
        _server = HttpServer();
        _server.listenAddressIPv4 = "127.0.0.1"
        _server["/desktop/:path"] = directoryBrowser("/Users/puma/Desktop/")
//        server["/pacProxy.pac"] = scopes {
//            html {
//              body {
//                h1 { inner = "hello" }
//              }
//            }
//        }
    }
    
    public func start(){
        if (self._isStarted){
            return;
        }
        self._isStarted = true;
        DispatchQueue.global().async(execute: DispatchWorkItem {
            do {
                try self._server.start(9080, forceIPv4: true)
                print("Server has started ( port = \(try self._server.port()) ). Try to connect now...")
                self._semaPhore.wait()
            } catch {
                print("Server start error: \(error)")
                self._semaPhore.signal()
            }
            
            DispatchQueue.main.async {
                self._isStarted = false;
            }
        })
    }
    
    public func stop() {
        self._server.stop();
        self._semaPhore.signal();
    }
}
