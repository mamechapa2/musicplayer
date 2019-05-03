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
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePlaylist(_ sender: UIButton) {
        if (textField.text != " "){
            let pl1 = Playlist(name: textField.text!)
            
            Playlists.append(pl1!)
            
            savePlaylistTo()
            performSegue(withIdentifier: "saveSegue", sender: self)
        }
    }
    
    func savePlaylistTo(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Playlists, toFile: Playlist.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Playlist guardadas", log: OSLog.default, type: .debug)
        } else {
            os_log("Fallo al cargar playlists", log: OSLog.default, type: .error)
        }
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
