//
//  SettingsVC.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/26/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import UIKit
import upnpx

class SettingsVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    fileprivate var devices = [BasicUPnPDevice]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let manager = UPnPManager.getInstance() else {
            return print("Can't get manager")
        }
        
        if let devices = manager.db.rootDevices as? [BasicUPnPDevice] {
            self.devices = devices
        }
        
        manager.db.add(self)
        manager.ssdp.setUserAgentProduct("OrangeRemote", andOS: "iphoneos")
        _ = manager.ssdp.searchSSDP // this is a method call
    }
}

extension SettingsVC: UPnPDBObserver {
    func uPnPDBWillUpdate(_ sender: UPnPDB!) {
        
    }
    
    func uPnPDBUpdated(_ sender: UPnPDB!) {
        
        guard let manager = UPnPManager.getInstance() else {
            return print("Can't get manager")
        }
        
        guard let devices = manager.db.rootDevices as? [BasicUPnPDevice] else {
            return print("Can't get devices")
        }
        
        self.devices = devices.filter { device in
            guard let services = device.services as? [String: BasicUPnPService] else {
                return false
            }
            return services.values.contains { service in
                service.urn == "urn:schemas-orange-com:service:X_OrangeSTBRemoteControl:1"
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
