//
//  StartScreen.swift
//  LoginScreen
//
//  Created by Anastasia G on 31.01.2022.
//

import UIKit

final class StartScreen: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
        let modalVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(modalVC, animated: true, completion: nil)
    }
}
