//
//  ViewController.swift
//  Flashcards
//
//  Created by Korali KOUADIO on 2/15/20.
//  Copyright © 2020 Korali K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backLabel.isHidden = true
        
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    
        if (segue.identifier == "EditSegue") {
        creationController.initalQuestion = frontLabel.text
        creationController.intialAnswer = backLabel.text
        }
    }
   

    @IBAction func didTapOnFlashcard(_ sender: Any) {

               if (backLabel.isHidden) {
                   frontLabel.isHidden = true
                   backLabel.isHidden = false
                  }
               else if (frontLabel.isHidden) {
                   backLabel.isHidden = true
                   frontLabel.isHidden = false
               }
           
    }
    func updateFlashcard (question: String, answer: String, extraAnswer1: String?, extraAnswer2: String?){
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extraAnswer1, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswer2, for: .normal)
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if backLabel.isHidden {
            frontLabel.isHidden = true
            backLabel.isHidden = false
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
}
