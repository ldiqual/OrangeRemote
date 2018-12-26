//
//  ViewController.swift
//  OrangeRemote
//
//  Created by Lois Di Qual on 12/26/18.
//  Copyright © 2018 Lois Di Qual. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIButton!
    
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
        
    }
    
    fileprivate func send(command: Command) {
        RemoteClient.instance.send(command: command).done {
            print("Sent \(command)")
        }.catch { error in
            print("Error: \(error)")
        }
    }
    
    @objc fileprivate func onButtonPressed(button: UIButton) {
        switch button {
            
        case keyLeftButton: send(command: .buttonLeft)
        case keyRightButton: send(command: .buttonRight)
        case keyUpButton: send(command: .buttonUp)
        case keyDownButton: send(command: .buttonDown)
        case okButton: send(command: .ok)
    
        case playPauseButton: send(command: .playPause)
        case recordButton: send(command: .playPause) // TODO: fix
        case volumeUpButton: send(command: .volumeUp)
        case volumeDownButton: send(command: .volumeDown)
        case muteButton: send(command: .mute)
        case channelUpButton: send(command: .channelUp)
        case channelDownButton: send(command: .channelDown)
        case forwardButton: send(command: .forward)
        case backwardButton: send(command: .backward)
            
        default:
            print("Unknown button \(button)")
            
        }
    }
}

