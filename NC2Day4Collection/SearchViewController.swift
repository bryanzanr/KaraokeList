//
//  SearchViewController.swift
//  NC2Day4Collection
//
//  Created by zein rezky chandra on 10/03/20.
//  Copyright © 2020 Jazilul Athoya. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchImage: UIImageView!
    var sendImage: UIImage?
    var titleMusic = ""
    var durationMusic = 0
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var searchAuthor: UIImageView!
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchDuration: UILabel!
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptVariable()
    }
    
    func acceptVariable() {
        if let temp = sendImage {
            searchImage.image = temp
        }
        searchTitle.text = titleMusic
        searchDuration.text = "Total Listen : \(durationMusic) persons"
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let temp = (searchBar.text as NSString?)?.replacingCharacters(in: range, with: text)
        if temp == "" {
            playButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }else {
            playButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
        return true
    }
    
}
