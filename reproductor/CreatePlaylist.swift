//
//  CreatePlaylist.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import os.log

class CreatePlaylist: UIViewController {

    //VARIABLES
    //Campo de texto
    @IBOutlet weak var textField: UITextField!
    
    //VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //SAVEPLAYLIST
    /*Espera la pulsacion del boton de guardar.
    Una vez pulsado creara una playlist nueva con el nombre introducido en el campo de texto.
    Por ultimo guardara las playlist en memoria y realizara el segue.*/
    @IBAction func savePlaylist(_ sender: UIButton) {
        if (textField.text != " "){
            let pl1 = Playlist(name: textField.text!)
            
            Playlists.append(pl1!)
            
            savePlaylistTo()
            performSegue(withIdentifier: "saveSegue", sender: self)
        }
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
