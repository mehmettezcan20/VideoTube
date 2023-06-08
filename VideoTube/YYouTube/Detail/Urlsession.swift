//
//  Urlsession.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//

import Foundation
import UIKit

class NetworkApi
{
    func getData(complete:  @escaping (YouTubeDTO) -> Void) {
        
         
         let url =  "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.youtube.com%2Ffeeds%2Fvideos.xml%3Fplaylist_id%3DPLlp2fEPXSOZaRQ13yZ2OhPLeMWKFkjDEO"
        // JSON verisini indirmek için URL oluştur
        guard let url = URL(string:url) else {
            print("Geçersiz URL")
            return
        }
        
        // URL Session oluştur
        let session = URLSession.shared
        
        // Veri talebi oluştur
        let task = session.dataTask(with: url) { (data, response, error) in
            // Hata kontrolü yap
            if let error = error {
                print("Veri indirme hatası: \(error.localizedDescription)")
                return
            }
            
            // Veriyi kontrol et
            guard let data = data else {
                print("Veri bulunamadı")
                return
            }
            
            do {
                // JSON verisini parse et
              //  let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                let welcome = try? JSONDecoder().decode(YouTubeDTO.self, from: data)
                complete(welcome!)
                // ...
            } catch {
                print("JSON parse hatası: \(error.localizedDescription)")
            }
        }
        
        // Veri indirmeyi başlat
        task.resume()
    }
}
