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
//    func getData(complete:  @escaping (YouTubeDTO) -> Void) {
//
//
//        aaa()
//        return
//         let url =  "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.youtube.com%2Ffeeds%2Fvideos.xml%3Fplaylist_id%3DPLlp2fEPXSOZaRQ13yZ2OhPLeMWKFkjDEO"
//        // JSON verisini indirmek için URL oluştur
//        guard let url = URL(string:url) else {
//            print("Geçersiz URL")
//            return
//        }
//
//        // URL Session oluştur
//        let session = URLSession.shared
//
//        // Veri talebi oluştur
//        let task = session.dataTask(with: url) { (data, response, error) in
//            // Hata kontrolü yap
//            if let error = error {
//                print("Veri indirme hatası: \(error.localizedDescription)")
//                return
//            }
//
//            // Veriyi kontrol et
//            guard let data = data else {
//                print("Veri bulunamadı")
//                return
//            }
//
//            do {
//                // JSON verisini parse et
//              //  let json = try JSONSerialization.jsonObject(with: data, options: [])
//
//                let welcome = try? JSONDecoder().decode(YouTubeDTO.self, from: data)
//                complete(welcome!)
//                // ...
//            } catch {
//                print("JSON parse hatası: \(error.localizedDescription)")
//            }
//        }
//
//        // Veri indirmeyi başlat
//        task.resume()
//    }
    let url1 = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.youtube.com%2Ffeeds%2Fvideos.xml%3Fplaylist_id%3DPLfyPuRCazQPI9B1eoDlw-i9-d3ywJtrbt"
    let url2 = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.youtube.com%2Ffeeds%2Fvideos.xml%3Fplaylist_id%3DPLaKLxbauAT7Fvem9I0yz8Mwp-Zph614xh"
    
    var response :YouTubeDTO?
    
    
    func fecthNetwork(url:String, complete:  @escaping (YouTubeDTO) -> Void){
        // JSON verisinin alınacağı URL
        let url = URL(string:url)!

        // URLSession kullanarak JSON verisini almak ve Swift nesnelerine dönüştürmek
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let feedData = try decoder.decode(YouTubeDTO.self, from: data)
                    complete(feedData)
                } catch {
                    print("Hata: \(error.localizedDescription)")
                }
            }
            
            
        }

        task.resume()
        
    }
    func getData(complete:  @escaping (YouTubeDTO?) -> Void){
        

        self.fecthNetwork(url: url1) { response in
            
            self.response =  response
            
            self.fecthNetwork(url: self.url2) { res2 in
                let l =  res2.items
                
                let h =  self.response?.items
                
                let t =  l! + h!

                self.response?.items =  t
                complete(self.response )
            }
        }

    }
}


