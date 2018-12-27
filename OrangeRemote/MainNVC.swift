//
//  MainNVC.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/27/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import UIKit
import upnpx

class MainNVC: UINavigationController {
    
    fileprivate static let kServerBaseUrl = "serverBaseUrl"
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        if let baseUrl = UserDefaults.standard.url(forKey: MainNVC.kServerBaseUrl) {
            RemoteClient.instance.baseUrl = baseUrl
            
            let remoteVC = RemoteVC()
            remoteVC.delegate = self
            
            viewControllers = [remoteVC]
        } else {
            
            let remoteVC = RemoteVC()
            remoteVC.delegate = self
            
            let settingsVC = SettingsVC(shouldShowBackButton: false)
            settingsVC.delegate = self
            
            viewControllers = [remoteVC, settingsVC]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .black
    }
    
    func setDevice(_ device: BasicUPnPDevice) {
        
        guard var components = URLComponents(url: device.baseURL, resolvingAgainstBaseURL: true) else {
            return print("Can't create url components")
        }
        components.path = "/"
        
        guard let baseUrl = components.url else {
            return print("Can't find base url")
        }
        
        RemoteClient.instance.baseUrl = baseUrl
        UserDefaults.standard.set(baseUrl, forKey: MainNVC.kServerBaseUrl)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainNVC: RemoteVCDelegate {
    func remoteVCDidPressSettingsButton(_ remoteVC: RemoteVC) {
        let settingsVC = SettingsVC(shouldShowBackButton: true)
        settingsVC.delegate = self
        pushViewController(settingsVC, animated: true)
    }
}

extension MainNVC: SettingsVCDelegate {
    func settingsVC(_ settingsVC: SettingsVC, didDetectDevice device: BasicUPnPDevice) {
        setDevice(device)
        popViewController(animated: true)
    }
}
