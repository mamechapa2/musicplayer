//
//  Playlist.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log

//Clase que creara playlist
class Playlist: NSObject, NSCoding{

    //VARIABLES
    //Nombre de la playlist
    var name: String = ""
    //Lista de canciones contenidas en la playlist
    var songs:[String] = []
    
    //Variable para persistdata
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //Variable para persistdata
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("playlist")
    
    //Struct para persist data
    struct PropertyKey {
        static let name = "name"
        static let songs = "songs"
    }

    //INIT

    //Init que crea una playlist vacia con un nombre
    init?(name: String){
        self.name = name
    }
    
    //convenience init que crea una playlist con un nombre y canciones
    convenience init?(name: String, songs: [String]){
        self.init(name: name)
        
        self.songs = songs
    }

    //required convenience init para persist data
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

    //PERSIST DATA
    //encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(songs, forKey: PropertyKey.songs)
    }
    
    //ADDSONG
    //Agrega una cancion a la playlist
    func addSong(song: String){
        self.songs.append(song)
    }
}
