//
//  ViewController.swift
//  NC2Day4Collection
//
//  Created by Jazilul Athoya on 10/03/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var musicCover: UIImageView!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var playListMusic: UILabel!
    @IBOutlet weak var titleMusic: UILabel!
    let coverArr: [UIImage] = [#imageLiteral(resourceName: "img_room"), #imageLiteral(resourceName: "img_coffee"), #imageLiteral(resourceName: "img_building")]
    let musicArr: [String] = ["Room Music", "Coffee Baby", "Building Music"]
    let durationArr: [Int] = [5, 3, 4]
    
    var durationMusic = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefault(withMusicInIndex: 0)
    }
    
    @IBAction func playerButton(_ sender: UIButton) {
        switch sender{
        case shuffleButton:
            let music = musicArr.randomElement()
            let (cover, duration) = getCover(music: music!)
            musicCover.image = cover
            titleMusic.text = music
            playListMusic.text = "Music Duration : \(duration) minute"
            durationMusic = duration
        case libraryButton:
            performSegue(withIdentifier: "detailSegue", sender: self)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let dest = segue.destination as? DetailViewController {
                dest.sendImage = musicCover.image
                dest.titleMusic = titleMusic.text!
                dest.durationMusic = durationMusic
            }
        }
    }
    
    func setDefault(withMusicInIndex: Int) {
        musicCover.image = coverArr[withMusicInIndex]
        titleMusic.text = musicArr[withMusicInIndex]
        playListMusic.text = "Music Duration : \(durationArr[withMusicInIndex]) minute"
    }
    
    func getCover(music: String) -> (UIImage, Int) {
        switch music{
        case "Room Music":
            return (coverArr[0], durationArr[0])
        case "Coffee Baby":
            return (coverArr[1], durationArr[1])
        case "Building Music":
            return (coverArr[2], durationArr[2])
        default:
            return (coverArr[0], durationArr[0])
        }
    }
    
}

