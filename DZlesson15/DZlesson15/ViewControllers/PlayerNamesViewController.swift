//
//  PlayerNamesViewController.swift
//  DZlesson15
//
//  Created by Янина on 21.09.21.
//

import UIKit

class PlayerNamesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerName1: UITextField!
    @IBOutlet weak var playerName2: UITextField!
    @IBOutlet weak var playButton: UIButton!
    
    weak var delegate: ViewControllerDelegate?
    
    var currentLanguage: Language = .english
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguage()
        playerName1.delegate = self
        playerName2.delegate = self
    }
    func setupLanguage() {
        switch currentLanguage {
        case .english: localized(by: "en")
        case .russian: localized(by: "ru")
        }
    }
    
    func localized(by languageCode: String) {
        guard let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return }
        titleLabel.text = NSLocalizedString("title_label_text", bundle: languageBundle, value: "", comment: "")
        playButton.setTitle(NSLocalizedString("play_button_text", bundle: languageBundle, value: "", comment: ""), for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == playerName1 {
            playerName2.becomeFirstResponder()
        } else {
            playerName2.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func goGameButton(_ sender: UIButton) {
        guard let textField1 = playerName1.text, let textField2 = playerName2.text, !textField1.isEmpty, !textField2.isEmpty else { return }
        let vc = getViewController(from: "Game")
        delegate?.delegateFunc(namePlayer1: textField1, namePlayer2: textField2)
        dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
