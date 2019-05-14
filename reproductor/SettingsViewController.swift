//
//  SettingsViewController.swift
//  reproductor
//
//  Created by Macosx on 14/5/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit

var volumenAnterior = audioPlayer.volume

class SettingsViewController: UIViewController {
    
    //VARIABLES
    //Slider para controlar el volumen
    @IBOutlet weak var volumen: UISlider!
    
    //VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        volumen.value = Float(volumenAnterior)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        volumen.value = Float(volumenAnterior)
    }
    
    //CAMBIARVOLUMEN
    //Modifica el volumen de la reproduccion en funcion del valor del slider
    @IBAction func cambiarVolumen(_ sender: UISlider) {
        if audioStuffed{
            audioPlayer.volume = sender.value
            volumenAnterior = sender.value
        }
    }
}
