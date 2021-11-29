//
//  LoginPageViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 17.10.21.
//

import UIKit

class LoginPageViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var vkLoginButton: UIButton!
    
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.systemGray3.cgColor, UIColor.systemGray6.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.view.bounds
        gradientLayer.zPosition = 0
        self.view.layer.addSublayer(gradientLayer)

        loginTextField.layer.zPosition = 1
        passwordTextField.layer.zPosition = 1
        loginButton.layer.zPosition = 1
        forgotPasswordButton.layer.zPosition = 1
        registerButton.layer.zPosition = 1
        logoImage.layer.zPosition = 1
        vkLoginButton.layer.zPosition = 1
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        addShadow(view: loginTextField)
        addShadow(view: passwordTextField)
        addShadow(view: loginButton)
        
        loginButton.layer.cornerRadius = 5
    }
    
    @objc func tapScreen() {
        self.view.endEditing(true)
    }
    
    @IBAction func pressLoginButtom(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        if login == "admin", password == "admin"{
            performSegue(withIdentifier: "logInSuccessfully", sender: nil)
        } else {
            loginTextField.textColor = UIColor.systemRed
            passwordTextField.textColor = UIColor.systemRed
        }
        
    }
    
    @IBAction func pressVKLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "vkLogin", sender: nil)
    }
    
    @IBAction func pressForgotButton(_ sender: UIButton) {
    }
    
    @IBAction func pressRegisterButton(_ sender: UIButton) {
    }
    
}
