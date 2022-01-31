//
//  ViewController.swift
//  LoginScreen
//
//  Created by Anastasia G on 28.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let navBarLabel = UILabel()
    let navBarButton = CustomButton()
    let subtitleLabel = UILabel()
    let codeTextField = CustomTextField()
    let enterButton = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createLoginUI()
        
        notifications()

    }
    
    // MARK: - Creating UI
    
    func createNavBar() {
        navBarLabel.frame = CGRect(x: 0, y: 40, width: 274, height: 30)
        navBarLabel.center.x = view.frame.midX
        navBarLabel.font = UIFont.systemFont(ofSize: 17)
        navBarLabel.text = "Вход по коду ссылки"
        navBarLabel.textAlignment = .center
        view.addSubview(navBarLabel)

        navBarButton.frame = CGRect(x: view.frame.width - 40, y: 40, width: 35, height: 35)
        navBarButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        navBarButton.addTarget(self, action: #selector(navBarButtonPressed), for: .touchUpInside)
        view.addSubview(navBarButton)
    }
    
    func createLoginUI() {
        subtitleLabel.frame = CGRect(x: 0, y: Int(view.frame.height) / 5, width: 290, height: 44)
        subtitleLabel.center.x = view.frame.midX
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.text = "Код скидки можно посмотреть в вашем личном кабинете на сайте"
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)

        codeTextField.frame = CGRect(x: 13, y: subtitleLabel.frame.maxY + 20, width: view.frame.width, height: 70)
        codeTextField.delegate = self
        codeTextField.font = UIFont.systemFont(ofSize: 17)
        codeTextField.textAlignment = .left
        codeTextField.contentVerticalAlignment = .bottom
        codeTextField.placeholder = "Ваш код скидки"
        view.addSubview(codeTextField)
        
        enterButton.frame = CGRect(x: 0, y: codeTextField.frame.maxY + 40, width: 290, height: 36)
        enterButton.center.x = view.frame.midX
        enterButton.layer.cornerRadius = 5
        enterButton.setBackgroundColor(.ButtonColor.enabledColor, for: .enabled)
        enterButton.setBackgroundColor(.ButtonColor.disabledColor, for: .disabled)
        enterButton.isEnabled = false
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        enterButton.tintColor = .white
        enterButton.setTitle("Войти", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        view.addSubview(enterButton)
    }
    
    // Buttons' methods
    @objc func enterButtonPressed() {
    }
    
    @objc func navBarButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Moving view up for keyboard
    func notifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            
            self.view.frame.origin.y = -200
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            
            self.view.frame.origin.y = 0.0
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Disabling button when the field is empty
        let text = (codeTextField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
         enterButton.isEnabled = false
        } else {
         enterButton.isEnabled = true
        }
        
        //Making sure all the letters are uppercase
        let firstLowercaseCharRange = string.rangeOfCharacter(from: NSCharacterSet.lowercaseLetters)
        if let _ = firstLowercaseCharRange {
            if let text = textField.text, text.isEmpty {
                textField.text = string.uppercased()
            }
            else {
                let beginning = textField.beginningOfDocument
                if let start = textField.position(from: beginning, offset: range.location),
                    let end = textField.position(from: start, offset: range.length),
                    let replaceRange = textField.textRange(from: start, to: end) {
                    textField.replace(replaceRange, withText: string.uppercased())
                }
            }
            return false
        }
        return true
    }
    
    //Hiding keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        codeTextField.resignFirstResponder()
        return true
    }
}

extension UIColor {
    struct ButtonColor {
        static var enabledColor = UIColor(red: 6.0/255.0, green: 80.0/255.0, blue: 194.0/255.0, alpha: CGFloat(1.0))
        static var disabledColor = UIColor(red: 6.0/255.0, green: 80.0/255.0, blue: 194.0/255.0, alpha: CGFloat(0.5))
    }
}

