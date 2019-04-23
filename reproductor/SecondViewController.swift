//
//  SecondViewController.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func play(_ sender: Any) {
        if audioPlayer.isPlaying == false{
            audioPlayer.play()
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        if thisSong == 1{
            playThis(thisOne: songs[thisSong-1])
            thisSong-=1
            label.text = songs[thisSong]
        }else{
            /*playThis(thisOne: songs[songs.count-1])
            label.text = songs[thisSong]*/
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if thisSong < songs.count-1{
            playThis(thisOne: songs[thisSong+1])
            thisSong+=1
            label.text = songs[thisSong]
        }else{
            /*playThis(thisOne: songs[0])
            label.text = songs[thisSong]*/
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        audioPlayer.volume = sender.value
    }
    
    func playThis(thisOne:String){
        do{
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }catch{
            print ("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = songs[thisSong]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

