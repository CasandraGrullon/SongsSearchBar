//
//  SongDetailVC.swift
//  SongsTableViewSearchBar
//
//  Created by casandra grullon on 11/27/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailVC: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var song : Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePage()
    }
    
    func updatePage(){
        guard let songInfo = song else {
            fatalError("song is empty")
        }
        songTitleLabel.text = songInfo.name
        artistNameLabel.text = songInfo.artist
        artistImage.image = #imageLiteral(resourceName: "loveSongs")
        
    }


}
