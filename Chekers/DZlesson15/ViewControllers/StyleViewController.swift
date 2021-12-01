//
//  StyleViewController.swift
//  DZlesson15
//
//  Created by Янина on 20.09.21.
//

import UIKit

class StyleViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var customBackButton: CustomButton!
    
    var currentLanguage: Language = .english
    var dataSource: [StyleChecker] = [StyleChecker(whiteChecker: "white", blackChecker: "black", stateSwitch: true),                                                  StyleChecker(whiteChecker: "7", blackChecker: "6", stateSwitch: false)] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSavedStyleOfChekers()
        setupLanguage()
        setupCollectionView()
        customBackButton.delegate = self
    }
    
    func setupSavedStyleOfChekers() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent(KeysUserDefaults.checkers.rawValue)
        if FileManager().fileExists(atPath: fileURL.path) {
            dataSource.removeAll()
            dataSource = SaveGame.getStyleChecker()
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
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
        titleLabel.text = NSLocalizedString("titleLabel_style_vc", bundle: languageBundle, value: "", comment: "")
    }
}

extension StyleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setData(with: dataSource[indexPath.item])
        cell.checkerSwitch.tag = indexPath.item
        cell.delegate = self
        return cell
        }
}

extension StyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 180)
    }
}
extension StyleViewController: CustomBattonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension StyleViewController: CollectionViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        for i in 0..<dataSource.count {
            dataSource[i].stateSwitch = i == sender.tag
        }
        collectionView.reloadData()
        SaveGame.saveStyleChecker(dataSource)
    }
}
