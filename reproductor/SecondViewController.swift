//
//  SecondViewController.swift
//  reproductor
//
//  Created by mamechapa on 26/03/2019.
//  Copyright © 2019 mamechapa. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class SecondViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func play(_ sender: Any) {
        if audioPlayer.isPlaying {
           audioPlayer.pause()
        }else{
            audioPlayer.play()
            notificaction(song: songName)
        }
        
        if audioStuffed == false {
            playThis(thisOne: songs[0])
            thisSong=0
            songName=songs[thisSong]
            label.text = songs[thisSong]
            notificaction(song: songName)
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        if thisSong == 0 && audioStuffed{
            playThis(thisOne: songs[songs.count-1])
            thisSong=songs.count-1
            label.text = songs[thisSong]
            notificaction(song: songName)
        }else{
            if audioStuffed {
                playThis(thisOne: songs[songs.count-1])
                thisSong-=1
                songName=songs[thisSong]
                label.text = songs[thisSong]
                notificaction(song: songName)
            }
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if thisSong < songs.count-1 && audioStuffed{
            playThis(thisOne: songs[thisSong+1])
            thisSong+=1
            songName=songs[thisSong]
            label.text = songs[thisSong]
            notificaction(song: songName)
        }else{
            if audioStuffed {
                playThis(thisOne: songs[0])
                thisSong=0
                songName=songs[0]
                label.text = songs[thisSong]
                notificaction(song: songName)
            }
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        if audioStuffed{
            audioPlayer.volume = sender.value
        }
    }
    
    func playThis(thisOne:String){
        do{
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            songName=thisOne
            notificaction(song: songName)
        }catch{
            print ("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        label.text = songName
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        label.text = songName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notificaction(song: String){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = song
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "cancion", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){
            (error) in
            if let error = error {
                print("Error al mandar notificacion")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }


}

