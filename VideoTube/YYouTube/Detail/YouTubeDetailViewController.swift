//
//  YouTubeDetailViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//

import UIKit
import WebKit
import YoutubePlayer

class YouTubeDetailViewController: UIViewController {
    var video: YItem?
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
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
          
        // Örnek olarak bir "Kapat" düğmesi ekle
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Kapat", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        // Kapat düğmesi için constraintler
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 16),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func rightHandAction() {
        dismiss(animated: true, completion: nil)
    }
}
