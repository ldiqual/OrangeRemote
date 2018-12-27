//
//  RemoteClient.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/26/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import upnpx

class RemoteClientError: Error {
    let description: String
    init(description: String) {
        self.description = description
    }
}

class RemoteClient {
    
    static let instance = RemoteClient()
    var baseUrl: URL?
    
    init() {}
    
    func send(command: Command) -> Promise<Void> {
        
        guard let baseUrl = baseUrl else {
            return Promise(error: RemoteClientError(description: "Base url is not set"))
        }
        
        let params: [String: Any] = [
            "operation": "01",
            "key": command.rawValue,
            "mode": 0
        ]
        
        let url = baseUrl.appendingPathComponent("remoteControl/cmd")
        
        return Promise { resolver in
            Alamofire.request(url, parameters: params).responseJSON { response in
                switch response.result {
                case .success:
                    return resolver.fulfill(())
                case .failure(let error):
                    return resolver.reject(error)
                }
            }
        }
    }
}
