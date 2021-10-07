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
    
    let black = ["black", "6"]
    let white = ["white", "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension StyleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.image1.image = UIImage(named: white[indexPath.item])
        cell.image2.image = UIImage(named: black[indexPath.item])
//        switch indexPath.item {
//        case 0 :
//            cell.selectLabel.text = "Selected"
//        case 1 :
//            cell.selectLabel.text = cell.selectLabel.text == "Selected" ? "Select" : "Selected"
//        default:
//            break
//        }
        return cell
        }
}


extension StyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 180)
    }
    
}


