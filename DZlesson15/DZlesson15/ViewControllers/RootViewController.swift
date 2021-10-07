//
//  RootViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

enum Language: Int {
    case english = 0
    case russian = 1
}
class RootViewController: UIViewController {
   
    @IBOutlet var buttonsRootVC: [UIButton]!
    
    var currentLanguage: Language = .english
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localized(by: "en")

        for value in buttonsRootVC {
            value.layer.cornerRadius = value.frame.size.width / 14
            value.backgroundColor = .black
            value.addShadow(with: .white, opacity: 0.9, shadowOffset: CGSize(width: 6, height: 6))
        }
        
        let image1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 420, height: 840))
        image1.image = UIImage(named: "0")
        image1.contentMode = .scaleAspectFill
        image1.alpha = 0.4
        image1.clipsToBounds = true
        view.addSubview(image1)
        
    }
    
    func localized(by languageCode: String) {
        guard let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return }
        buttonsRootVC[0].setTitle(NSLocalizedString("go_button_text", bundle: languageBundle, value: "", comment: ""), for: .normal)
        buttonsRootVC[1].setTitle(NSLocalizedString("results_button_text", bundle: languageBundle, value: "", comment: ""), for: .normal)
        buttonsRootVC[2].setTitle(NSLocalizedString("settings_button_text", bundle: languageBundle, value: "", comment: ""), for: .normal)
    }
    
    @IBAction func selectLanguage(_ sender: UISegmentedControl) {
        guard let sectectedLanguage = Language(rawValue: sender.selectedSegmentIndex), sectectedLanguage != currentLanguage else { return }
        switch sectectedLanguage {
        case .english: localized(by: "en")
        case .russian: localized(by: "ru")
        }
    }
    
    @IBAction func gameButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(getViewController(from: "Game"), animated: true)
    }
    
    @IBAction   func resultsButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(getViewController(from: "Results"), animated: true)
    }
    
    @IBAction func settingsButton (_ sender: UIButton) {
        self.navigationController?.pushViewController(getViewController(from: "Settings"), animated: true)
    }

}

