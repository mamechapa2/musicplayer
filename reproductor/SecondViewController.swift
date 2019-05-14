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

    //VARIABLES
    //Label que muestra nombre de la cancion
    @IBOutlet weak var label: UILabel!
    //Image view
    @IBOutlet weak var myImageView: UIImageView!
    //Slider para controlar la reproduccion
    @IBOutlet weak var moverseCancion: UISlider!
    //Label para mostrar el tiempo de reproduccion actual
    @IBOutlet weak var tiempoActual: UILabel!
    //Boton de play
    @IBOutlet weak var playButton: UIButton!
    
    //VIEWDIDLOAD
    /*Configura las notificaciones, cambia el label a la cancion en reproduccion, el valor maximo del slider a la duraccion de la cancion.
    Tambien activa un timer que actualizara el slider para poder ver donde estamos actualmente en la cancion*/
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        label.text = songName
        moverseCancion.maximumValue = Float(audioPlayer.duration)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1,target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
    }
    
    //VIEWDIDAPPEAR
    /*Cambia el label a la cancion en reproduccion y el valor maximo del slider a la duracion de la cancion.
    Tambien activa el mismo timer que la funcion viewDidLoad()*/
    override func viewDidAppear(_ animated: Bool) {
        label.text = songName
        moverseCancion.maximumValue = Float(audioPlayer.duration)

        let timer = Timer.scheduledTimer(timeInterval: 0.1,target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)   
    }

    //DIDRECEIVEMEMORYWARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //ACTIONS

    //Espera que el slider modifique su valor para movernos a un punto de la cancion concreto
    @IBAction func changeAudioTime(_ sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(moverseCancion.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    /*Controla el boton play de la vista, funcionando tanto para play como para pause
    dependiendo de si la cancion esta en reproduccion o no.
    Tambien muestra una notificacion cada vez que la cancion se reproduce.*/
    @IBAction func play(_ sender: Any) {
        if audioPlayer.isPlaying {
           audioPlayer.pause()
        }else{
            audioPlayer.play()
            notificaction(song: songName)
        }
        
        //Guarda informacion sobre la cancion en reproduccion para usarla en la vista y modifica el nombre mostrado en la vista por el de la cancion en reproduccion
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
    
    /*Controla el boton de volver a la cancion anterior.
    Si se llega a la primera cancion y se pulsa el boton, se reproducira la ultima cancion que haya en el dispositivo.
    Tambien mostrara una notificacion y modificara el label de la vista al nombre de la cancion que se va a reproducir.
    Por ultimo tambien cambia el valor maximo del slider al de la duracion de la cancion y guarda informmacion sobre la cancion en reproduccion.*/
    @IBAction func prev(_ sender: Any) {
        if thisSong == 0 && audioStuffed{
            playThis(thisOne: songs[songs.count-1])
            thisSong=songs.count-1
            label.text = songs[thisSong]
            notificaction(song: songName)
            moverseCancion.maximumValue = Float(audioPlayer.duration)
        }else{
            if audioStuffed {
                playThis(thisOne: songs[songs.count-1])
                thisSong-=1
                songName=songs[thisSong]
                label.text = songs[thisSong]
                notificaction(song: songName)
                moverseCancion.maximumValue = Float(audioPlayer.duration)
            }
        }
    }
    
    /*Controla el boton de ir a la cancion siguiente.
    Si se llega a la ultima cancion y se pulsa el boton, se reproducira la primera cancion que haya en el dispositivo.
    Tambien mostrara una notificacion y modificara el label de la vista al nombre de la cancion que se va a reproducir.
    Por ultimo tambien cambia el valor maximo del slider al de la duracion de la cancion y guarda informmacion sobre la cancion en reproduccion.*/
    @IBAction func next(_ sender: Any) {
        if thisSong < songs.count-1 && audioStuffed{
            playThis(thisOne: songs[thisSong+1])
            thisSong+=1
            songName=songs[thisSong]
            label.text = songs[thisSong]
            notificaction(song: songName)
            moverseCancion.maximumValue = Float(audioPlayer.duration)
        }else{
            if audioStuffed {
                playThis(thisOne: songs[0])
                thisSong=0
                songName=songs[0]
                label.text = songs[thisSong]
                notificaction(song: songName)
                moverseCancion.maximumValue = Float(audioPlayer.duration)
            }
        }
    }
    
    /*COntrola el slider de volumen para poder modificar el volumen de reproduccion*/
    @IBAction func slider(_ sender: UISlider) {
        if audioStuffed{
            audioPlayer.volume = sender.value
        }
    }
    
    //PLAYTHIS
    //Reproduce la cancion que se pase por parametro
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
    
    
    
    //NOTIFICATION
    /*Crea una notificacion cuyo contenido sera obtenido de la cancion en reproduccion.
    La notificacion mostrara un texto "Reproduciendo: " junto con el nombre de la cancion.
    Por ultimo, se lanza la notificacion*/
    func notificaction(song: String){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Reproduciendo"
        content.body = song
        //content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "cancion", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){
            (error) in
            if let error = error {
                print("Error al mandar notificacion")
            }
        }
    }
    
    //UPDATESLIDER
    //Actualiza el slider con el tiempo actual de reproduccion de la cancion que se esta reproduciendo
    @objc func updateSlider(){
        moverseCancion.value = Float(audioPlayer.currentTime)
        tiempoActual.text = String(Int(audioPlayer.currentTime)) + "/" + String(Int(audioPlayer.duration))
        
        //NSLog(String(Float(audioPlayer.currentTime)))
    }
    
    //USERNOTIFICATIONCENTER
    //Funcion para notificaciones
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }


}

