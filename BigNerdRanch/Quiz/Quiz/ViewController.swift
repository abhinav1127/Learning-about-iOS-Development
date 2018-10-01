//
//  ViewController.swift
//  Quiz
//
//  Created by Abhinav Tirath on 2/22/18.
//  Copyright © 2018 LearningSwift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!

    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if (currentQuestionIndex == questions.count) {
            currentQuestionIndex = 0
        }
        nextQuestionLabel.text = questions[currentQuestionIndex]
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }

    @IBAction func showAnswer(_ sender: UIButton) {
        answerLabel.text = answers[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    let questions: [String] = [
        "What is 7 + 7?",
        "What is the capital of the Vermont?",
        "What is cognac made from?"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    
    func animateLabelTransitions() {
        
        //Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //Animate the alpha
        //and the CenterX constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: {
                            self.currentQuestionLabel.alpha = 0
                            self.nextQuestionLabel.alpha = 1
                        
                            self.view.layoutIfNeeded()
                        },
                       completion: { _ in
                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint,
                             &self.nextQuestionLabelCenterXConstraint)
                        
                        self.updateOffScreenLabel()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
}

