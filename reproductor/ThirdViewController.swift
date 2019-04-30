//
//  ThirdViewController.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation


var favorites:[String] = []
var Playlists:[Playlist] = []

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView2: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Playlists.count)
        return Playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        
        crear()
        
        myTableView2.reloadData()
        print(Playlists[1].name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crear(){
        
        let pl1 = Playlist(name: "Prueba")
        
        pl1?.addSong(song: songs[0])
        Playlists.append(pl1!)
        print(Playlists[0].name)
        print(Playlists[0].songs[0])
        
        let pl2 = Playlist(name: "Prueba2")
        
        pl2?.addSong(song: songs[1])
        Playlists.append(pl2!)
        print(Playlists[1].name)
        print(Playlists[1].songs[0])
    }
    
    
}
