//
//  SegmentTableViewController.swift
//  MusicPlayer
//
//  Created by tantsunsin on 2020/9/16.
//  Copyright © 2020 tantsunsin. All rights reserved.
//

import UIKit

class SegmentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ContentShowed : [music] = MusicInLocal
    var ContentDownloaded : [music]?
    
    let SegmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items:  ["Local", "Online Preview"])
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let TableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        downloadMusic()
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        view.backgroundColor = .white
        navigationItem.title = "本機檔案or線上音樂"
        view.addSubview(SegmentControl)
        
        let stackView = UIStackView(arrangedSubviews: [
            SegmentControl, TableView
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
        
        // 設定stackView的Auto Layout
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContentShowed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! SongsTableViewCell
        let CellContent = ContentShowed[indexPath.row]
        cell.NameLabel.text = CellContent.trackName
        cell.IndexLabel.text = "\(indexPath.row + 1)."
        
        return cell
    }
    
    @objc func segmentChanged(){
        if SegmentControl.selectedSegmentIndex == 0{
            ContentShowed = MusicInLocal
            TableView.reloadData()
        }else{
            guard let ContentDownloaded = ContentDownloaded else { return }
            ContentShowed = ContentDownloaded
            TableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPlayer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayer"{
            if let MusicPlayerVC = segue.destination as? MusicPlayerViewController,
               let row = TableView.indexPathForSelectedRow?.row{
                MusicPlayerVC.SongPlaying = ContentShowed[row]
                MusicPlayerVC.Songs = ContentShowed
            }
        }
    }

  
    func downloadMusic(){
        if let urlstr = "https://itunes.apple.com/search?term=伍佰&media=music&country=TW".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstr){
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let musicResults = try? decoder.decode(MusicDownload.self, from: data){

                    self.ContentDownloaded = musicResults.results                    
                }
            }
            task.resume()
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
