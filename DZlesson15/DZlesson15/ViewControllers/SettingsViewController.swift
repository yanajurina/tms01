//
//  SettingsViewController.swift
//  DZlesson15
//
//  Created by Янина on 1.08.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    let settingsTitles = ["Choose checkers style", "Сhoose the background", "About the game"]
    let nameNextScreen = ["Style", "Background", "Scroll"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard indexPath.row != 1 else {
            chooseBackground()
            return
        }
        navigationController?.pushViewController(getViewController(from: nameNextScreen[indexPath.row]),                                          animated: true)
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
