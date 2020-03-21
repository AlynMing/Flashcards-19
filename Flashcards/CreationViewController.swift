//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Korali KOUADIO on 2/29/20.
//  Copyright © 2020 Korali K. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    var initialQuestion : String?
    var initialAnswer : String?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswer_1: UITextField!
    @IBOutlet weak var extraAnswer_2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let extraAnswer1Text = extraAnswer_1.text
        let extraAnswer2Text = extraAnswer_2.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle:.alert)
            present (alert, animated: true)
            let okAction = UIAlertAction (title: "OK", style: .default)
            alert.addAction(okAction)
        }

        else {
            // See if card "is existing"
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            flashcardsController.updateFlashcard (question: questionText!, answer: answerText!, extraAnswer1: extraAnswer1Text!, extraAnswer2: extraAnswer2Text!, isExisting: isExisting)
        dismiss(animated: true)
        }
    }
}
