//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jeffrey Chau on 2/09/2015.
//  Copyright (c) 2015 Tigerspike. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}