//
//  AddToPlaylist.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log

class AddToPlaylist: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableViewPlaylist: UITableView!
    
    //Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewPlaylist.delegate = self
        myTableViewPlaylist.dataSource = self
        
        myTableViewPlaylist.reloadData()
    }

    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Table view, funciones para configurarlo
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(Playlists.count)
        //print("hey")
        return Playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hola", for: indexPath)
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    //Si pulsamos sobre una cancion en el table view, esta sera borrada. Despues se guardara en memoria la playlist
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Playlists[indexPath.row].songs.append(songName)
        savePlaylistTo()
        performSegue(withIdentifier: "addedSong", sender: self)
    }
    
    //Guarda las playlist en memoria si se modifican
    func savePlaylistTo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Playlists, toFile: Playlist.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Playlist guardadas", log: OSLog.default, type: .debug)
        } else {
            os_log("Fallo al cargar playlists", log: OSLog.default, type: .error)
        }
    }   
}
