//
//  RemoteVC.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/26/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import UIKit
import FontAwesome_swift
import upnpx

protocol RemoteVCDelegate: class {
    func remoteVCDidPressSettingsButton(_ remoteVC: RemoteVC)
}

class RemoteVC: UIViewController {
    
    @IBOutlet weak var keyLeftButton: UIButton!
    @IBOutlet weak var keyRightButton: UIButton!
    @IBOutlet weak var keyUpButton: UIButton!
    @IBOutlet weak var keyDownButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var volumeUpButton: UIButton!
    @IBOutlet weak var volumeDownButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var channelUpButton: UIButton!
    @IBOutlet weak var channelDownButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    weak var delegate: RemoteVCDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = L10n.remoteTitle
        let icon = UIImage.fontAwesomeIcon(name: .cog, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(onSettingsButtonPressed))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allButtons: [UIButton] = [
            keyLeftButton,
            keyRightButton,
            keyUpButton,
            keyDownButton,
            okButton,
            
            playPauseButton,
            recordButton,
            volumeUpButton,
            volumeDownButton,
            muteButton,
            channelUpButton,
            channelDownButton,
            forwardButton,
            backwardButton,
            
            returnButton,
            menuButton,
        ]
            
        allButtons.forEach { button in
            button.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)
        }
        
        keyLeftButton.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        keyRightButton.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
        keyUpButton.setTitle(String.fontAwesomeIcon(name: .chevronUp), for: .normal)
        keyDownButton.setTitle(String.fontAwesomeIcon(name: .chevronDown), for: .normal)
        okButton.setTitle(String.fontAwesomeIcon(name: .check), for: .normal)
        
        playPauseButton.setTitle(String.fontAwesomeIcon(name: .play), for: .normal)
        recordButton.setTitle(String.fontAwesomeIcon(name: .video), for: .normal)
        volumeUpButton.setTitle(String.fontAwesomeIcon(name: .volumeUp), for: .normal)
        volumeDownButton.setTitle(String.fontAwesomeIcon(name: .volumeDown), for: .normal)
        muteButton.setTitle(String.fontAwesomeIcon(name: .volumeMute), for: .normal)
        channelUpButton.setTitle(String.fontAwesomeIcon(name: .plusCircle), for: .normal)
        channelDownButton.setTitle(String.fontAwesomeIcon(name: .minusCircle), for: .normal)
        forwardButton.setTitle(String.fontAwesomeIcon(name: .forward), for: .normal)
        backwardButton.setTitle(String.fontAwesomeIcon(name: .backward), for: .normal)
        
        returnButton.setTitle(String.fontAwesomeIcon(name: .longArrowAltLeft), for: .normal)
        menuButton.setTitle(String.fontAwesomeIcon(name: .alignJustify), for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    fileprivate func onRemoteButtonPressed(command: Command) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        RemoteClient.instance.send(command: command).done {
            print("Sent \(command)")
        }.catch { error in
            print("Error: \(error)")
        }
    }
    
    @objc fileprivate func onButtonPressed(button: UIButton) {
        switch button {
            
        case keyLeftButton: onRemoteButtonPressed(command: .buttonLeft)
        case keyRightButton: onRemoteButtonPressed(command: .buttonRight)
        case keyUpButton: onRemoteButtonPressed(command: .buttonUp)
        case keyDownButton: onRemoteButtonPressed(command: .buttonDown)
        case okButton: onRemoteButtonPressed(command: .ok)
    
        case playPauseButton: onRemoteButtonPressed(command: .playPause)
        case recordButton: onRemoteButtonPressed(command: .record)
        case volumeUpButton: onRemoteButtonPressed(command: .volumeUp)
        case volumeDownButton: onRemoteButtonPressed(command: .volumeDown)
        case muteButton: onRemoteButtonPressed(command: .mute)
        case channelUpButton: onRemoteButtonPressed(command: .channelUp)
        case channelDownButton: onRemoteButtonPressed(command: .channelDown)
        case forwardButton: onRemoteButtonPressed(command: .forward)
        case backwardButton: onRemoteButtonPressed(command: .backward)
            
        case returnButton: onRemoteButtonPressed(command: .return)
        case menuButton: onRemoteButtonPressed(command: .menu)
            
        default:
            print("Unknown button \(button)")
            
        }
    }
    
    @objc fileprivate func onSettingsButtonPressed() {
        delegate?.remoteVCDidPressSettingsButton(self)
    }
}
