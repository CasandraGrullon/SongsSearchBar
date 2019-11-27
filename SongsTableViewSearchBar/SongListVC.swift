//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum CurrentScope{
    case song
    case artist
}

class SongListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songs = [Song](){
        didSet{
            tableView.reloadData()
        }
    }
    var currentScope = CurrentScope.song
    
    var searchQuery = "" {
        didSet{
            switch currentScope{
            case .song :
                songs = Song.loveSongs.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            case .artist :
                songs = Song.loveSongs.filter { $0.artist.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData(){
        songs = Song.loveSongs
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailVC = segue.destination as? SongDetailVC, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("segue wrong")
        }
        songDetailVC.song = songs[indexPath.row]
    }
}
extension SongListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if songs.count == 0 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
            label.textAlignment = .center
            view.addSubview(label)
            label.text = "No Results"
            tableView.backgroundView = label
        }
        
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        return cell
    }
}

extension SongListVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .song
        case 1:
            currentScope = .artist
        default:
            print("not valid")
        }
    }
    
    
}
