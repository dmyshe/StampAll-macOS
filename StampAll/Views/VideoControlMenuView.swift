//
//  VideoControlMenuView.swift
//  StampAll
//
//  Created by Дмитро  on 07.08.2022.
//

import AppKit


protocol VideoControlMenuViewDelegate : AnyObject {
    func buttonTapped(_ isVideoPlaying: Bool)
    func sliderChanged(value: Double)
}

class VideoControlMenuView: NSView {
    weak var delegate: VideoControlMenuViewDelegate?
    
    //MARK: - IBOultets
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var slider: NSSlider!
    
    private var isVideoPlaying = false

    
    // MARK: - IBActions
    @IBAction func tooglePlayButton(_ sender: NSButton) {
        let playIcon = NSImage(systemSymbolName: "play.fill", accessibilityDescription: nil)
        let pauseIcon = NSImage(systemSymbolName: "pause.fill",accessibilityDescription: nil)
        
        playButton.image = isVideoPlaying ? pauseIcon : playIcon
        
        isVideoPlaying.toggle()
  
        delegate?.buttonTapped(isVideoPlaying)
    }
    
    @IBAction private func sliderValueChanged(_ sender: NSSlider) {
        delegate?.sliderChanged(value: sender.doubleValue)
       }
}
