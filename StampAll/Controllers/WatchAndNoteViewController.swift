//
//  WatchAndNoteViewController.swift
//  StampAll
//
//  Created by Дмитро  on 03.08.2022.
//

import Cocoa

class WatchAndNoteViewController: NSViewController {

    @IBOutlet private weak var videoControlMenu: VideoControlMenu!
    
    var videoPlayer: VideoPlayerViewController? {
        guard isViewLoaded else { return nil }
        return children.compactMap { $0 as? VideoPlayerViewController }.first
    }
    
    var textEditor: TextEditorViewController? {
        guard isViewLoaded else { return nil }
        return children.compactMap { $0 as? TextEditorViewController }.first
    }
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        videoControlMenu.delegate = self
    }
}

// MARK: - VideoControlMenuViewDelegate
extension WatchAndNoteViewController: VideoControlMenuViewDelegate {
    func sliderChanged(value: Double) {
        videoPlayer?.fastForward(to: value)
    }
    
    func buttonTapped(_ isVideoPlaying: Bool) {
        if isVideoPlaying {
            videoPlayer?.pauseVideo()
        } else {
            videoPlayer?.playVideo()
        }
    }
}



