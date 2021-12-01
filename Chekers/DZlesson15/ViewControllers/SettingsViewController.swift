//
//  SettingsViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var customBackButton: CustomButton!

    var currentLanguage: Language = .english
    var settingsTitles = ["Choose checkers style", "Сhoose the background", "About the game"]
    let nameNextScreen = ["Style", "Background", "Scroll"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customBackButton.delegate = self
        
        setupLanguage()
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        settingsTableView.tableFooterView = UIView()
    }
    
    func chooseBackground() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let media = UIAlertAction(title: "Media", style: .default) { _ in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
        
            #if targetEnvironment(simulator)
            print("error")
            #else
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            #endif
        }
        alert.addAction(cancel)
        alert.addAction(media)
        alert.addAction(camera)
        present(alert, animated: true, completion: nil)
    }
    
    func setupLanguage() {
        switch currentLanguage {
        case .english: localized(by: "en")
        case .russian: localized(by: "ru")
        }
    }
    
    func localized(by languageCode: String) {
        guard let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return }
        customBackButton.text = NSLocalizedString("back_button_text", bundle: languageBundle, value: "", comment: "")
        settingsLabel.text = NSLocalizedString("settings_button_text", bundle: languageBundle, value: "", comment: "")
        settingsTitles = [NSLocalizedString("choose_checkers_style", bundle: languageBundle, value: "", comment: ""),
                          NSLocalizedString("choose_the_background", bundle: languageBundle, value: "", comment: ""),
                          NSLocalizedString("about_the_game", bundle: languageBundle, value: "", comment: "")]
    }

}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell else { return UITableViewCell() }
        cell.labelSettings.text = settingsTitles[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            guard let vc = getViewController(from: nameNextScreen[0]) as? StyleViewController else { return }
            vc.currentLanguage = currentLanguage
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            chooseBackground()
        case 2:
            guard let vc = getViewController(from: nameNextScreen[2]) as? ScrollViewController else { return }
            vc.currentLanguage = currentLanguage
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage,
              let vc = getViewController(from: "Game") as? GameViewController else { return }
        vc.image = image
        picker.dismiss(animated: true) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: CustomBattonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
