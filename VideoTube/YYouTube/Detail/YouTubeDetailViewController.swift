//
//  YouTubeDetailViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//
 import UIKit
 import WebKit
 import YoutubePlayer
 import Firebase
 
 class YouTubeDetailViewController: UIViewController {
 var video: YItem?
 private var webView: WKWebView!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 self.view.backgroundColor =  .black
 
 let splitArray = video?.guid!.components(separatedBy: ":").last
 let playerView  = YoutubePlayerView.init(frame: self.view.frame)
 
 try! playerView.loadVideo(withId: splitArray!, playerVars: YoutubePlayerOptions.Parameters(playsInline: .true))
 
 // UIView nesnesi oluştur
 playerView.translatesAutoresizingMaskIntoConstraints = false
 
 // UIView'nin yüksekliğini ayarla
 playerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
 
 // UIView'yi view'a ekle
 view.addSubview(playerView)
 
 // UIView için constraintler
 playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
 playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
 playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
 
 let closeButton = UIButton(type: .system)
 closeButton.setTitle("Kapat", for: .normal)
 closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
 closeButton.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(closeButton)
 
 // Kapat düğmesi için constraintler
 NSLayoutConstraint.activate([
 closeButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 30), //burası videonuun altındaki başlığın
 closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)                  //yüksekliğini belirlemek için
 ])                                                                                      // kullanılıyor.
 
 // Yeni bir UILabel oluştur

 let titleLabel = UILabel()
 titleLabel.text = video?.title
 titleLabel.textColor = .white
 titleLabel.font = UIFont.boldSystemFont(ofSize: 19) // Burası detay sayfasındaki video başlığı boyutu
 titleLabel.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(titleLabel)
 
 // titleLabel için constraintler
 NSLayoutConstraint.activate([
 titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: -45),
 titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
 titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
 ])
 }
 
 @objc func closeButtonTapped() {
 dismiss(animated: true, completion: nil)
    }
 }
