//
//  ScrollViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var textHistoryLabel: UILabel!
    @IBOutlet weak var goodLuckLabel: UILabel!
    
    var currentLanguage: Language = .english
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguage()
    }
    
    func setupLanguage() {
        switch currentLanguage {
        case .english: localized(by: "en")
        case .russian: localized(by: "ru")
        }
    }
    
    func localized(by languageCode: String) {
        guard let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return }
        backButton.setTitle(NSLocalizedString("back_button_text", bundle: languageBundle, value: "", comment: ""), for: .normal)
        historyLabel.text = NSLocalizedString("history_label_text", bundle: languageBundle, value: "", comment: "")
        textHistoryLabel.text = NSLocalizedString("text_history_label_text", bundle: languageBundle, value: "", comment: "")
        goodLuckLabel.text = NSLocalizedString("good_luck_label_text", bundle: languageBundle, value: "", comment: "")
    }
    
    @IBAction func backSettings(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
