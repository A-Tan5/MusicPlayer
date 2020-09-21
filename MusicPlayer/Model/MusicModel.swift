//
//  MusicModel.swift
//  MusicPlayer
//
//  Created by tantsunsin on 2020/8/3.
//  Copyright © 2020 tantsunsin. All rights reserved.
//

import Foundation

struct music : Equatable, Codable{
    var trackName : String?
    var artistName : String?
    
    func getFileURL() -> URL? {   //本機音樂的URL
        let url = Bundle.main.url(forResource: trackName, withExtension: "mp3")!
        return url
    }
    
    var previewUrl : String?
    var GetPreviewURL : URL? {    //線上音樂的URL
        get{
            URL(string: previewUrl!)!
        }
    }
    var artworkUrl100 : String?   // 用這個值是否為nil，判斷圖片要從URL來還是本機
}

var MusicInLocal : [music] = [music(trackName: "台北帝國", artistName: "黑名單工作室"), music(trackName: "抓狂", artistName: "黑名單工作室"), music(trackName: "傷心無話", artistName: "黑名單工作室"), music(trackName: "阿爸的話", artistName: "黑名單工作室"), music(trackName: "慶端陽", artistName: "黑名單工作室"), music(trackName: "計程車", artistName: "黑名單工作室"), music(trackName: "民主阿草", artistName: "黑名單工作室"), music(trackName: "新莊街", artistName: "黑名單工作室"), music(trackName: "播種", artistName: "黑名單工作室")]


struct MusicDownload : Codable{
    var resultCount : Int
    var results : [music]
    
}

enum RepeatTypes {
    case NotRepeat
    case RepeatAll
    case RepeatOne
}

enum RandomTypes{
    case NotRandom
    case Random
}
