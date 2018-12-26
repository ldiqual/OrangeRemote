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

class RemoteClient {
    
    static let instance = RemoteClient()
    
    init() {}
    
    func send(command: Command) -> Promise<Void> {
        
        let params: [String: Any] = [
            "operation": "01",
            "key": command.rawValue,
            "mode": 0
        ]
        
        return Promise { resolver in
            Alamofire.request("http://192.168.1.10:8080/remoteControl/cmd", parameters: params).responseJSON { response in
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
