//
//  SettingsViewController.swift
//  reproductor
//
//  Created by Macosx on 14/5/19.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var volumen: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cambiarVolumen(_ sender: UISlider) {
        if audioStuffed{
            audioPlayer.volume = sender.value
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
