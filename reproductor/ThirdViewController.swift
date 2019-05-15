//
//  ThirdViewController.swift
//  reproductor
//
//  Created by Macosx on 24/4/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation

//VARIABLES
//Array en el cual son almacenadas todas las playlist
var Playlists:[Playlist] = []
//Variable usada para almacenar que playlist se ha seleccionado para mostrar sus canciones
var selecPlaylist = 0
//Variable que se usa para saber si es la primera vez que se abre el reproductor o no
var firstOpen2 = true

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //VARIABLES
    //Tableview para mostrar las playlist
    @IBOutlet weak var myTableView2: UITableView!
    
    //VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView2.delegate = self
        myTableView2.dataSource = self
        
        myTableView2.reloadData()
    }
    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TABLEVIEW
    
    //COnfigura el table view con un numero total de filas igual al numero de playlist en el dispositivo
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(Playlists.count)
        return Playlists.count
    }
    
    //Rellena cada una de las filas con los nombres de todas las playlist
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Playlists[indexPath.row].name
        
        return cell
    }
    
    //Si se toca una playlist, se guarda la seleccion en una variable y se realiza el segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecPlaylist = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
}
