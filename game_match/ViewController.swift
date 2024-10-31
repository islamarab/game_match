//
//  ViewController.swift
//  game_match
//
//  Created by iskapc on 29.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var imageName: String = ""
    let infoDict: [Int: String] = [
        1: "arbuz",
        2: "banan",
        3: "kiwi",
        4: "lemon",
        5: "malina",
        6: "pineapple",
        7: "pita",
        8: "vinograd"
    ]
    let allElements = [5, 4, 3, 1,
                       4, 6, 7, 8,
                       3, 5, 8, 1,
                       2, 7, 2, 6]
    var openedElements = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var lastIdx = -1
    var counter = 0
    var lastButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickButton(_ sender: UIButton) {
        counter += 1
        let currentIdx = sender.tag - 1
        imageName = infoDict[allElements[currentIdx]] ?? ""
        sender.setBackgroundImage(UIImage(named: imageName), for: .normal)
        if counter % 2 != 0 {
            lastButton = sender
            lastIdx = currentIdx
        } else {
            if allElements[lastIdx] == allElements[currentIdx] {
                openedElements[currentIdx] = allElements[currentIdx]
                openedElements[lastIdx] = allElements[lastIdx]
            } else {
                self.perform(#selector(self.closeTwoButtons), with: (sender, lastButton), afterDelay: 1.0)
            }
        }
        if !openedElements.contains(0) {
            let alert = UIAlertController(title: "Вы открыли все ячейки", message: "Шаги:\(counter)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Заново", style: .default, handler: { UIAlertAction in
                self.clear()
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    @objc func closeTwoButtons(_ args: Any) {
        if let (curButton, lastButton) = args as? (UIButton, UIButton) {
            curButton.setBackgroundImage(UIImage(named: "znak"), for: .normal)
            lastButton.setBackgroundImage(UIImage(named: "znak"), for: .normal)
        }
    }
    
    func clear() {
        lastIdx = -1
        counter = 0
        lastButton = UIButton()
        for i in 0...allElements.count-1 {
            openedElements[i] = 0
            let button = view.viewWithTag(i+1) as! UIButton
            button.setBackgroundImage(UIImage(named: "znak"), for: .normal)
        }
    }
    
}

