import Firebase
import Foundation

// MARK: - Welcome
struct YouTubeDTO: Codable {
    let status: String?
    let feed: Feed?
    var items: [YItem]?
}

// MARK: - Feed
struct Feed: Codable {
    let url: String?
    let title, link: String?
    let author: String?
    let description, image: String?
}

// MARK: - Item
struct YItem: Codable {
    let title, pubDate: String?
    let link: String?
    let guid: String?
    let author: String?
    let thumbnail: String?
    let description, content: String?
}
