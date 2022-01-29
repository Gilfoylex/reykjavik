//
//  XrayCoreServer.swift
//  Reykjavik
//
//  Created by PUMA on 2021/11/20.
//

import Foundation
import Dispatch

//let x : String? = Bundle.main.path(forResource: "config", ofType: ".json");
//if (x == nil){
//    return;
//}

//// Swift example
//#if arch(arm64)
//    print("arm64")
//#elseif arch(x86_64)
//    print("x86_64")
//#endif
class XrayServer {
    private var _xrayPath = "";
    private var _configPath = "";
    let _workQueue = DispatchQueue(label: "com.gilfoyle.xray")
    private let _outputPipe = Pipe()
    private let _errorPipe = Pipe()
    private let _semaPhore = DispatchSemaphore(value: 0)
    private let _task = Process();
    
    init(){
#if arch(arm64)
        // TODO
#elseif arch(x86_64)
        let xrayPath = Bundle.main.path(forResource: "xray-intel", ofType: "");
        if (xrayPath != nil){
            _xrayPath = xrayPath!;
        }
#endif
        
        let configPath = Bundle.main.path(forResource: "config", ofType: ".json");
        if (configPath != nil){
            _configPath = configPath!;
        }
        
        _task.executableURL = URL(fileURLWithPath: _xrayPath)
        _task.arguments = ["run", "-config", _configPath]
        _task.standardOutput = self._outputPipe
    }
    
    public func Start() {
        _workQueue.async {
            do {
                self.Stop()
                self._outputPipe.fileHandleForReading.readabilityHandler = { pipe in
                    if let line = String(data: pipe.availableData, encoding: String.Encoding.utf8) {
                        print("new out put: \(line)")
                    } else {
                        print("Error decoding data: \(pipe.availableData)")
                    }
                    
                }
                try self._task.run()
                self._task.waitUntilExit()
                self._outputPipe.fileHandleForReading.readabilityHandler = nil
            } catch {
                print("Server xray error: \(error)")
            }
            
            self._outputPipe.fileHandleForReading.readabilityHandler = nil
        }
    }
    
    private func PrintOut() {
        
    }
    
    public func Stop(){
        if (self._task.isRunning){
            self._task.terminate()
        }
    }
    
}
