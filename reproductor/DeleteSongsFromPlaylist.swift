//
//  DeleteSongsFromPlaylist.swift
//  reproductor
//
//  Created by Macosx on 8/5/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log


class DeleteSongsFromPlaylist:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableViewDelete: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewDelete.delegate = self
        myTableViewDelete.dataSource = self
        
        myTableViewDelete.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Table view, funciones para configurarlo
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Playlists[selecPlaylist].songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
        
        cell.textLabel?.text = Playlists[selecPlaylist].songs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Playlists[selecPlaylist].songs.remove(at: indexPath.row)
        savePlaylistTo()
        performSegue(withIdentifier: "deletedSong", sender: self)
    }
    
    //Guarda las playlist en memoria si se modifican con persist data
    func savePlaylistTo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Playlists, toFile: Playlist.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Playlist guardadas", log: OSLog.default, type: .debug)
        } else {
            os_log("Fallo al cargar playlists", log: OSLog.default, type: .error)
        }
    } 
}
