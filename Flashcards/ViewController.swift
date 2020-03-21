//
//  ViewController.swift
//  Flashcards
//
//  Created by Korali KOUADIO on 2/15/20.
//  Copyright © 2020 Korali K. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Array to hold flashcards
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
    
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
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's my name?", answer: "Korali", extraAnswer1: "Koko", extraAnswer2: "Koraly", isExisting: true)
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    
        if (segue.identifier == "EditSegue") {
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
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
    
    func deleteCurrentFlashcard () {
        //Delete current
        flashcards.remove (at: currentIndex)
        
        //Special case: check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        //Update buttons
        updateNextPrevButtons()
        
        //Update labels
        updateLabels()
        
        //Save flashcards
        saveAllFlashcardsToDisk()
    }
  
    func updateFlashcard (question: String, answer: String, extraAnswer1: String?, extraAnswer2: String?, isExisting: Bool){
        
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        if isExisting {
            //Replace existing flashcard
            flashcards [currentIndex] = flashcard
        }
        
        else {
        //Adding flashcards in the Flashcard array
        flashcards.append(flashcard)
        
        //Logging to the console
        print("😎 Added new flashcard")
        print("😎 We now have \(flashcards.count) flashcard(s)")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("😎 Our current index \(currentIndex)")
        }
        
        //Update buttons
        updateNextPrevButtons()
        //Update labels
        updateLabels()
        
        btnOptionOne.setTitle(extraAnswer1, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswer2, for: .normal)
        
        //Save flashcards
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk() {
        //From Flashcard array to dictionary array
        let dictionaryArray = flashcards.map {(card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        //Save array on Disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        //Log it
        print("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards () {
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            
            //In here we know for sure there's a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard (question: dictionary ["question"]!, answer: dictionary ["answer"]!)
        }
            //Put all flashcards in flashcards array
            flashcards.append(contentsOf: savedCards)
    }
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
    
    func updateNextPrevButtons() {
        //Disable next button if at the end
        if (currentIndex == flashcards.count - 1){
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if (currentIndex == 0){
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //Decrease current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        //Show confirmation
        let alert =  UIAlertController (title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction (title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        }
    
    
}
