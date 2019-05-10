//
//  Playlist.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log

//Clase playlist que almacena tanto el nombre como las canciones de una playlist
class Playlist: NSObject, NSCoding{
    var name: String = "" //Nombre de la playlist
    var songs:[String] = [] //Array para las canciones de la playlist
    
    //Variables persist data
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
    
    //Init para las playlist
    init?(name: String){
        self.name = name
    }
    
    //Init para cargar playlist de memoria
    convenience init?(name: String, songs: [String]){
        self.init(name: name)
        
        self.songs = songs
    }
    
    //Funcion que añade una cancion a la playlist
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
