//
//  CustomButton.swift
//  LoginScreen
//
//  Created by Anastasia G on 31.01.2022.
//

import UIKit

class CustomButton: UIButton {
    enum ButtonState {
        case enabled
        case disabled
    }
    
    private var disabledColor: UIColor?
    private var enabledColor: UIColor? {
        didSet {
            backgroundColor = enabledColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = enabledColor {
                    self.backgroundColor = color
                }
            } else {
                if let color = disabledColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .enabled:
            enabledColor = color
        case .disabled:
            disabledColor = color
        }
    }
    
    
}
