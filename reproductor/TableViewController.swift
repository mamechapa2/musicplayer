//
//  TableViewController.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView3: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView3.delegate = self
        myTableView3.dataSource = self
        
        myTableView3.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Playlists[selecPlaylist].songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)

        cell.textLabel?.text = Playlists[selecPlaylist].songs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            let audioPath = Bundle.main.path(forResource: Playlists[selecPlaylist].songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            songName = Playlists[selecPlaylist].songs[indexPath.row]
            audioStuffed = true
            print(thisSong)
        }catch{
            print ("ERROR")
        }
    }
}
