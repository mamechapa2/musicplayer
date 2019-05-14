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

    //VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewPlaylist.delegate = self
        myTableViewPlaylist.dataSource = self
        
        myTableViewPlaylist.reloadData()
    }

    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //TABLEVIEW

    //Devuelve el numero de playlist para generar la table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(Playlists.count)
        //print("hey")
        return Playlists.count
    }
    
    //Devuelve cada una de las celdas, que deben ser creadas con los nombres de las playlist
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hola", for: indexPath)
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    /*Espera la pulsacion de un elemento en el table view.
    Si se pulsa sobre una playlist, la cancion en reproduccion sera añadida a esa playlist.
    Despues se guardaran las playlist en memoria y se realizara el segue.*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Playlists[indexPath.row].songs.append(songName)
        savePlaylistTo()
        performSegue(withIdentifier: "addedSong", sender: self)
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
