//
//  VideoPlayerViewController.swift
//  StampAll
//
//  Created by Дмитро  on 07.08.2022.
//

import AppKit
import AVFoundation

class  VideoPlayerViewController: NSViewController {
   @IBOutlet private weak var videoContainerView: NSView!
   
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
  
    let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        videoContainerView.wantsLayer = true
        videoContainerView.layer = playerLayer
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
//        player.play()
    }
    
    override func viewDidLayout() {
        playerLayer.frame = videoContainerView.frame
    }
    
    
    func playVideo() {
        player.play()
    }
    
    func pauseVideo() {
        player.pause()
    }
    
    func getTimeString(from time: CMTime)  -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int (totalSeconds/3600)
        let minutes = Int (totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes, seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    
    func fastForward(to value: Double) {
        player.seek(to: CMTimeMake(value: Int64(value * 1000), timescale: 1000))
    }
}
