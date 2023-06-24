//
//  YouTubeViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//

import UIKit

class YouTubeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    
    var videos = [YItem]()
    
    var isSearch =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkApi().getData { [weak self] l in
            guard let self = self else { return }
            
            self.videos = (l?.items ?? []).shuffled()    // Burada videoların hangi sıra ile listeleneceği belirtiliyor
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
       tableView = UITableView(frame: view.bounds, style: .plain)
    
       view.addSubview(tableView)
        
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")

        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")

        let nib = UINib(nibName: "VideoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "VideoCell")
        tableView.delegate = self
        tableView.dataSource = self
     
    }
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
                 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = VideoCell.init(style: .default, reuseIdentifier: "VideoCell")
        
        let video = videos[indexPath.row]
        cell.configure(with: video)
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seçilen hücreye bağlı olarak detay sayfasını açabilirsiniz.
        let video = videos[indexPath.row]
        showDetailPage(video: video)
    }
    
    // MARK: - Detay Sayfası
    
    func showDetailPage(video: YItem) {
        let detailVC = YouTubeDetailViewController()
        detailVC.video = video
        present(detailVC, animated: true, completion: nil)
    }

}
