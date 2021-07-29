//
//  ViewController.swift
//  tmsDZlesson12
//
//  Created by Янина on 21.07.21.
//

import UIKit



class RootViewController: UIViewController {
   
    @IBOutlet var buttonsRootVC: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in buttonsRootVC {
            value.layer.cornerRadius = value.frame.size.width / 10
            value.backgroundColor = .orange
            value.addShadow(with: .orange, opacity: 0.5, shadowOffset: CGSize(width: 6, height: 6))
        }
        
        let sizeX = view.bounds.size.width
        let sizeY = view.bounds.size.height
        
        let image1 = UIImageView(frame: CGRect(x: sizeX - 300, y: sizeY - 850, width: 200, height: 200))
        image1.image = UIImage(named: "1")
        image1.contentMode = .scaleAspectFill
        image1.alpha = 0.6
        view.addSubview(image1)
        
        let image2 = UIImageView(frame: CGRect(x: sizeX - 300, y: sizeY - 200, width: 200, height: 200))
        image2.image = UIImage(named: "2")
        image2.contentMode = .scaleAspectFill
        image2.alpha = 0.6
        view.addSubview(image2)
    }
    
    func getViewController (from id: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let currentViewController = storyboard.instantiateViewController(withIdentifier: id)
        currentViewController.modalPresentationStyle = .fullScreen
        currentViewController.modalTransitionStyle = .crossDissolve
        return currentViewController
    }
    
    @IBAction func gameButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(getViewController(from: "GameViewController"), animated: true)
    }
    
    @IBAction func resultsButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(getViewController(from: "ResultsViewController"), animated: true)
    }
    
    @IBAction func settingsButton (_ sender: UIButton) {
       self.navigationController?.pushViewController(getViewController(from: "SettingsViewController"), animated: true)
    }

}
