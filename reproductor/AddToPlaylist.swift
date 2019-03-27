//
//  AddToPlaylist.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit

class AddToPlaylist: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableViewPlaylist: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hola", for: indexPath)
        
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Playlists[indexPath.row].songs.append(songName)
        performSegue(withIdentifier: "addedSong", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewPlaylist.delegate = self
        myTableViewPlaylist.dataSource = self
        
        myTableViewPlaylist.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    
}
