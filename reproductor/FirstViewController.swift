//
//  FirstViewController.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation
import os.log
import UserNotifications

var songs:[String] = []
var audioPlayer = AVAudioPlayer()
var thisSong = 0
var audioStuffed = false
var firstOpen = true
var songName = ""
var filteredSongs = [String]()



class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var myTableView: UITableView!
    
    var searchController : UISearchController!
    
    var resultsController = UITableViewController()
    
    func createSearchBar(){
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        
        self.myTableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self as UISearchResultsUpdating
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredSongs = songs.filter { (song: String) -> Bool in
            if song.lowercased().contains(self.searchController.searchBar.text!.lowercased()){
                return true
            }else{
                return false
            }
        }
        
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.myTableView{
            return songs.count
        }else{
            return filteredSongs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.myTableView{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = songs[indexPath.row]
            
            return cell
        }else{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = filteredSongs[indexPath.row]
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            songName = songs[indexPath.row]
            audioStuffed = true
            print(thisSong)
        }catch{
            print ("ERROR")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if firstOpen{
            gettingSongName()
            firstOpen=false
            songName=songs[0]
        }
        
        if loadPlaylist() != nil {
            Playlists = loadPlaylist()!
        }
        
        createSearchBar()
        tableSettings()
        
    }
    
    func tableSettings(){
        self.myTableView.dataSource = self
        
        self.myTableView.delegate = self
    }
    
    private func loadPlaylist() -> [Playlist]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Playlist.ArchiveURL.path) as? [Playlist]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gettingSongName(){
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do{
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath{
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3"){
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    print(mySong)
                    songs.append(mySong)
                }
            }
            myTableView.reloadData()
        }catch{
            print ("ERROR")
        }
    }
    
    func crear(){
        let pl1 = Playlist(name: "Prueba")
        
        pl1?.addSong(song: songs[0])
        Playlists.append(pl1!)
        
        let pl2 = Playlist(name: "Prueba2")
        
        pl2?.addSong(song: songs[1])
        Playlists.append(pl2!)
    }
    

}

