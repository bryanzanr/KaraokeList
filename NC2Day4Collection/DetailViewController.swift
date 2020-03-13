//
//  DetailViewController.swift
//  NC2Day4Collection
//
//  Created by zein rezky chandra on 11/03/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    
    var sendImage: UIImage?
    var titleMusic = ""
    var durationMusic = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptVariable()
    }
    
    func acceptVariable() {
        if let temp = sendImage {
            coverImage.image = temp
        }
        musicLabel.text = "\(titleMusic) \n Music Duration : \(durationMusic) minute"
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender{
        case swipeDown:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    

}
