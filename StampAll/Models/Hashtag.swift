//
//  Hashtag.swift
//  StampAll
//
//  Created by Дмитро  on 07.08.2022.
//

import Foundation

class Hashtag {
    var hashtags: [String: File] = ["Hastag1": File(), "Hastag2": File()]
    lazy var hashtagsArray =  Array(hashtags.keys)
}
