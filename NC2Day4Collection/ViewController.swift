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
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefault(withMusicInIndex: 0)
    }
    @IBAction func swipeRandom(_ sender: UISwipeGestureRecognizer) {
        switch sender {
        case leftSwipe, rightSwipe:
            networkData(command: "random")
        default:
            break
        }
    }
    
    @IBAction func playerButton(_ sender: UIButton) {
        switch sender{
        case shuffleButton:
            networkData(command: "random")
        case libraryButton:
            performSegue(withIdentifier: "detailSegue", sender: self)
        default:
            break
        }
    }
    
    func randomMusic(musicLists: [ListModel.List]?) {
        if let music = musicLists?.randomElement() {
            DispatchQueue.main.async {
                self.musicCover.downloaded(from: music.coverURL)
                self.titleMusic.text = music.title
                self.playListMusic.text = "Total Listen : \(music.stats.totalListen) persons"
                self.durationMusic = music.stats.totalListen
            }
        }
//        let (cover, duration) = getCover(music: music!)
//        musicCover.image = cover
//        titleMusic.text = music
//        playListMusic.text = "Music Duration : \(duration) minute"
//        durationMusic = duration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "detailSegue":
            if let dest = segue.destination as? DetailViewController {
               dest.sendImage = musicCover.image
               dest.titleMusic = titleMusic.text!
               dest.durationMusic = durationMusic
           }
        case "searchSegue":
            if let dest = segue.destination as? SearchViewController {
                dest.sendImage = musicCover.image
                dest.titleMusic = titleMusic.text!
                dest.durationMusic = durationMusic
            }
        default:
            break
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
    
    func networkData(command: String){
        guard let url = URL(string: "https://www.smule.com/bnrmusic/performances/json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(ListModel.self, from: data!)
                switch command {
                case "random":
                    self.randomMusic(musicLists: response.list)
                default:
                    break
                }
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    
}

struct ListModel: Codable{
    struct List: Codable {
        struct Stats: Codable {
            let totalListen: Int
            enum CodingKeys: String, CodingKey {
                case totalListen = "total_listens"
            }
        }
        let stats: Stats
        let title: String
        let coverURL: String
        enum CodingKeys: String, CodingKey {
            case title
            case stats
            case coverURL = "cover_url"
        }
    }
    let list: [List]
    let nextOffset: Int
    enum CodingKeys: String, CodingKey {
        case list
        case nextOffset = "next_offset"
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

