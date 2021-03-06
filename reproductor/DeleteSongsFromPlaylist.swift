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
    
    //VARIABLES
    //Tableview que muestra las canciones de la playlist seleccionada
    @IBOutlet weak var myTableViewDelete: UITableView!
    
    //VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewDelete.delegate = self
        myTableViewDelete.dataSource = self
        
        myTableViewDelete.reloadData()
    }
    
    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TABLEVIEW

    //Devuelve el numero de canciones que tiene la playlist seleccionada
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Playlists[selecPlaylist].songs.count
    }
    
    //Devuelve cada una de las celdas, que deben ser creadas con los nombres de las canciones de la playlist seleccionada
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
        
        cell.textLabel?.text = Playlists[selecPlaylist].songs[indexPath.row]
        
        return cell
    }
    
    /*Espera la pulsacion de un elemento en el table view.
    Si se pulsa sobre una cancion, esta sera eliminada de la playlist.
    Despues se guardaran las playlist en memoria y se realizara el segue.*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Playlists[selecPlaylist].songs.remove(at: indexPath.row)
        savePlaylistTo()
        performSegue(withIdentifier: "deletedSong", sender: self)
    }
    
    //SAVEPLAYLISTTO

    //Guarda las playlist en memoria cada vez que se modifican o crean nuevas.
    func savePlaylistTo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Playlists, toFile: Playlist.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Playlist guardadas", log: OSLog.default, type: .debug)
        } else {
            os_log("Fallo al cargar playlists", log: OSLog.default, type: .error)
        }
    } 
}
