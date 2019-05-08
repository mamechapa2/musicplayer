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
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    func savePlaylistTo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Playlists, toFile: Playlist.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Playlist guardadas", log: OSLog.default, type: .debug)
        } else {
            os_log("Fallo al cargar playlists", log: OSLog.default, type: .error)
        }
    } 
}
