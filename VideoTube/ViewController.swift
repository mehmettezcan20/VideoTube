//
//  ViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var videos = [YItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        navigateYouTubeViewController()
       
        self.navigateYouTubeViewController()
//            // Örnek kullanım
//            let searchQuery = "moruto" // Arama yapılacak kelime veya ifade
//            let searchResults = searchVideos(query: searchQuery)
//
//            print("")
//            // searchResults, arama sonucunda bulunan videoların listesini içerecektir

        }
    
    func navigateYouTubeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YouTubeViewController")
        let nav = UINavigationController(rootViewController: vc)
        
     /* let button = UIBarButtonItem(title: "Right",
                                     style: .done,
                                     target: self,
                                     action: #selector(rightHandAction))
        
        let button2 = UIBarButtonItem(title: "Left",
                                      style: .plain,
                                      target: self,
                                      action: #selector(leftHandAction))    */
          
        nav.navigationBar.backgroundColor = .red
     //   nav.navigationBar.topItem?.rightBarButtonItem = button
        nav.navigationBar.topItem?.title = "VideoTube"
   //     nav.navigationBar.topItem?.leftBarButtonItem = button2
        
        let titleView = UILabel()
        titleView.text = "VideoTube"
        titleView.textColor = .white
        nav.navigationBar.topItem?.titleView = titleView
        
        self.present(nav, animated: false)
    }


    @objc func rightHandAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func leftHandAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func searchVideos(query: String) -> [YItem] {
        let lowercaseQuery = query.lowercased()
        
        let filteredVideos = videos.filter { video in
            if let title = video.title?.lowercased(), title.contains(lowercaseQuery) {
                return true
            }
            
            if let content = video.content?.lowercased(), content.contains(lowercaseQuery) {
                return true
            }
            
                return false
        }
        return filteredVideos
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Arama butonuna tıklandığında yapılacak işlemler
        if let searchText = searchBar.text {
            // Arama metnini kullanarak veri kaynağını filtreleme veya arama işlemleri yapma
            
            let filtreresVideos = self.searchVideos(query: searchText)
            let views = navigationController?.viewControllers
            let v = navigationController?.viewControllers.first as? YouTubeViewController
            v?.isSearch =  true
            v?.videos =  filtreresVideos
            v?.tableView.reloadData()
            
            print("")
            
        }
        searchBar.resignFirstResponder() 
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // İptal butonuna tıklandığında yapılacak işlemler
        searchBar.text = "" // Arama metnini sıfırlama
        searchBar.resignFirstResponder() // Klavyeyi kapatma
    }
}
