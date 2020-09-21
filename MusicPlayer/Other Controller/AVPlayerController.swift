//
//  AVPlayerController.swift
//  MusicPlayer
//
//  Created by tantsunsin on 2020/9/19.
//  Copyright © 2020 tantsunsin. All rights reserved.
//

import Foundation
import AVFoundation

//共享播放器，避免退出到前一頁再進入播放器時，出現重複的AVPlayer
class AVPlayerController {
    static let shared = AVPlayerController()
    let player = AVPlayer()
}
