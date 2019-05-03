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
var selecPlaylist = 0
var firstOpen2 = true

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView2: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(Playlists.count)
        return Playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecPlaylist = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView2.delegate = self
        myTableView2.dataSource = self
        
        myTableView2.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
