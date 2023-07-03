//
//  PersonViewController.swift
//  VideoTube
//
//  Created by Mehmet Tezcan on 27.06.2023.
//
import Foundation
import UIKit
import FirebaseAuth
import Firebase

protocol PersonViewControllerDelegate: AnyObject {
    // Delege için gereken yöntemleri buraya ekleyebilirsiniz
}
class PersonViewController: UIViewController {
    
    //class PersonViewController: UIViewController {
        weak var delegate: PersonViewControllerDelegate?

        // PersonViewController sınıfının diğer özellikleri ve fonksiyonları
    //}
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-Posta"
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifre"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayıt Ol", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func loginButtonTapped() {
        // Giriş yap butonuna tıklandığında yapılacak işlemler
        guard let mail = emailTextField.text, let pass = passwordTextField.text else {
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: mail, password: pass) { data, error in
            if (error != nil){
                error?.localizedDescription
                //alert
                return
            }
            self.dismiss(animated: false)
        }
    }
    
    @objc private func registerButtonTapped() {
        // Kayıt ol butonuna tıklandığında yapılacak işlemler
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // Firebase kayıt işlemlerini burada gerçekleştirin
        // Örneğin:
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            if let error = error {
                print("Kayıt olma hatası: \(error.localizedDescription)")
            } else {
                // Kayıt başarılı, Ana sayfaya dön
                self?.dismiss(animated: false)
            }
        }
    }
}
