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

//VARIABLES
//Array con el nombre de todas las canciones del dispositivo
var songs:[String] = []
//Reproductor de audio, inicializacion
var audioPlayer = AVAudioPlayer()
//Contiene el numero que tiene la cancion en reproduccion en el array de canciones
var thisSong = 0
//True o false dependiendo de si el reproductor esta cargado o no
var audioStuffed = false
//Controla si es la primera que se abre el reproductor o no
var firstOpen = true
//Contiene el nombre de la cancion en reproduccion
var songName = ""

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //VARIABLES
    //Tableview que muestra las canciones
    @IBOutlet weak var myTableView: UITableView!

     //VIEWDIDLOAD
     /*Si el reproductor se abre por primera vez obtiene las canciones que estan disponibles para reproducir.
     Despues prepara el reproductor y guarda la cancion que esta en reproduccion en la var songName.
     Por ultimo carga las playlist que se guardaron en memoria (si las hay).*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if firstOpen{
            gettingSongName()
            firstOpen=false
            do{
                let audioPath = Bundle.main.path(forResource: songs[0], ofType: ".mp3")
                try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            }catch{
                print("error viewdidload firstviewcontroller")
            }
            songName=songs[0]
        }
        
        if loadPlaylist() != nil {
            Playlists = loadPlaylist()!
        }
    }

    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //TABLEVIEW

    //Devuelve el numero de canciones totales en el dispositivo para configurar el tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    //Rellena todas las filas del table view con el nombre de las canciones
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        
        return cell
    }
    
    /*Espera la pulsacion de un elemento del table view.
    Si se selecciona alguna de las canciones, esta se carga en el reproductor y se reproduce.
    Tambien guardamos su nombre y posicion en el array y modificamos la variable que controla si el reproductor esta o no en marcha.*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            songName = songs[indexPath.row]
            audioStuffed = true

            //Debug
            print(thisSong)
            print(songName)
        }catch{
            print ("ERROR")
        }
    }
    
    //LOADPLAYLIST
    //Funcion que carga las playlist desde memoria 
    private func loadPlaylist() -> [Playlist]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Playlist.ArchiveURL.path) as? [Playlist]
    }
    
    //GETTINGSONGNAME
    /*Obtiene todos los nombres de las canciones y los guarda en un array.
    Despues recarga el table view. Es llamada desde la funcion viewDidLoad de esta misma clase.*/
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
    
    //CREAR
    //Crea playlist de prueba (debug)
    func crear(){
        let pl1 = Playlist(name: "Prueba")
        
        pl1?.addSong(song: songs[0])
        Playlists.append(pl1!)
        
        let pl2 = Playlist(name: "Prueba2")
        
        pl2?.addSong(song: songs[1])
        Playlists.append(pl2!)
    }
    

}

