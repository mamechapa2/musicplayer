//
//  Playlist.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit

class Playlist: NSObject{
    var name: String = ""
    var songs:[String] = []
    
    func encode(with aCoder: NSCoder) {
    }
    
    init?(name: String){
        self.name = name
    }
}
