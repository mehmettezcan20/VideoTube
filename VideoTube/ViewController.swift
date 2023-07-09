//
//  ViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 6.06.2023.
//
import UIKit
import Firebase

class ViewController: UIViewController , PersonViewControllerDelegate{
    
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    
    var videos = [YItem]()
    
    @objc private func registerButtonTapped() {
        // Kayıt ol butonuna tıklandığında yapılacak işlemler
    }
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayıt Ol", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("")
        
        if ( FirebaseAuth.Auth.auth().currentUser ==  nil) {
            personButtonTapped()
        } else {
            navigateYouTubeViewController()
        }
    }
    
    func navigateYouTubeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YouTubeViewController")
        let nav = UINavigationController(rootViewController: vc)
        let personImage = UIImage(systemName: "person") // Kişi simgesi oluşturma
        let personButton = UIBarButtonItem(image: personImage, style: .plain, target: self, action: #selector(personButtonTapped))
        personButton.tintColor = .white // Düğme rengini beyaz olarak ayarlama
        nav.navigationBar.topItem?.rightBarButtonItem = personButton
        
        nav.navigationBar.backgroundColor = .red
        nav.navigationBar.topItem?.title = "VideoTube"
        let titleView = UILabel()
        titleView.text = "VideoTube"
        titleView.textColor = .white
        nav.navigationBar.topItem?.titleView = titleView
        nav.modalPresentationStyle = .fullScreen
        
        let logOtButton = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(logOyButtonTapped))
        logOtButton.tintColor = .white // Düğme rengini beyaz olarak ayarlama
        nav.navigationBar.topItem?.leftBarButtonItem = logOtButton
        
        self.present(nav, animated: false)
    }
    
    @objc func personButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let personVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        personVC.delegate = self
        personVC.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false)
        
        let nav = UINavigationController(rootViewController: personVC)
        nav.navigationBar.backgroundColor = .black
        nav.navigationBar.topItem?.title = "Giriş Yap"
       
        let titleView = UILabel()
        titleView.text = "Giriş Yap"
        titleView.textColor = .white
        nav.navigationBar.topItem?.titleView = titleView
        nav.modalPresentationStyle = .fullScreen
        
        let personButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(backButtonTapped))
        personButton.tintColor = .white // Düğme rengini beyaz olarak ayarlama
        nav.navigationBar.topItem?.leftBarButtonItem = personButton
        self.present(nav, animated: false)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc private func logOyButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}
