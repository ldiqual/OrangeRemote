//
//  SettingsVC.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/26/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import UIKit
import upnpx
import FontAwesome_swift

protocol SettingsVCDelegate: class {
    func settingsVC(_ settingsVC: SettingsVC, didDetectDevice device: BasicUPnPDevice)
}

class SettingsVC: UIViewController {
    
    @IBOutlet fileprivate(set) weak var wifiIconLabel: UILabel!
    @IBOutlet fileprivate(set) weak var wifiDetailsLabel: UILabel!
    @IBOutlet fileprivate(set) weak var networkIconLabel: UILabel!
    @IBOutlet fileprivate(set) weak var networkDetailsLabel: UILabel!
    @IBOutlet fileprivate(set) weak var powerIconLabel: UILabel!
    @IBOutlet fileprivate(set) weak var powerDetailsLabel: UILabel!
    
    weak var delegate: SettingsVCDelegate?
    
    fileprivate let shouldShowBackButton: Bool
    fileprivate var devices = [BasicUPnPDevice]()
    
    init(shouldShowBackButton: Bool) {
        self.shouldShowBackButton = shouldShowBackButton
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = L10n.settingsTitle
        navigationItem.hidesBackButton = !shouldShowBackButton
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Wifi
        wifiIconLabel.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        wifiIconLabel.text = String.fontAwesomeIcon(name: .wifi)
        wifiDetailsLabel.text = L10n.settingsWifi
        
        // Network
        networkIconLabel.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        networkIconLabel.text = String.fontAwesomeIcon(name: .networkWired)
        networkDetailsLabel.text = L10n.settingsNetwork("?")
        
        // Power
        powerIconLabel.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        powerIconLabel.text = String.fontAwesomeIcon(name: .powerOff)
        powerDetailsLabel.text = L10n.settingsPower
        
        startScanning()
    }
    
    fileprivate func startScanning() {
        guard let manager = UPnPManager.getInstance() else {
            return print("Can't get manager")
        }
        
        if let devices = manager.db.rootDevices as? [BasicUPnPDevice] {
            self.devices = devices
        }
        
        manager.db.add(self)
        manager.ssdp.setUserAgentProduct("OrangeRemote", andOS: "iphoneos")
        _ = manager.ssdp.startSSDP // this is a method call
        _ = manager.ssdp.searchSSDP // this is a method call
    }
    
    fileprivate func stopScanning() {
        guard let manager = UPnPManager.getInstance() else {
            return print("Can't get manager")
        }
        
        _ = manager.ssdp.stopSSDP // this is a method call
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
        
        let wrappedDevice = devices.first { device in
            guard let services = device.services as? [String: BasicUPnPService] else {
                return false
            }
            return services.values.contains { service in
                service.urn == "urn:schemas-orange-com:service:X_OrangeSTBRemoteControl:1"
            }
        }
        
        guard let device = wrappedDevice else {
            return print("No matching device yet")
        }
        
        DispatchQueue.main.async {
            self.stopScanning()
            self.delegate?.settingsVC(self, didDetectDevice: device)
        }
    }
}
