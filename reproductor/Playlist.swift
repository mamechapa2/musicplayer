//
//  Playlist.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log

class Playlist: NSObject, NSCoding{
    var name: String = ""
    var songs:[String] = []
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("playlist")
    
    struct PropertyKey {
        static let name = "name"
        static let songs = "songs"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(songs, forKey: PropertyKey.songs)
    }
    
    init?(name: String){
        self.name = name
    }
    
    convenience init?(name: String, songs: [String]){
        self.init(name: name)
        
        self.songs = songs
    }
    
    func addSong(song: String){
        self.songs.append(song)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("No se puede decodificar", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let songs = aDecoder.decodeObject(forKey: PropertyKey.songs) as? [String] else{
            os_log("No se puede decodificar", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: name, songs: songs)
    }
}
