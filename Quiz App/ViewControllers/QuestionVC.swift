//
//  QuestionVC.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class QuestionVC: QuizAppVC {

    @IBOutlet weak var questionLB: UILabel!
    @IBOutlet weak var questionTV: UITableView!
    @IBOutlet weak var countDownBT: UIButton!
    
    var score: Score? = nil
    var questions = Question.getRandom(count: 5)
    
    var currentQuestion: Question? = nil
    var currentQuestionNumber = 0
    var count = 0
    
    var timer: Timer? = nil
    
    var onSuccess : ((Score?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countDownBT.layer.masksToBounds = true
        countDownBT.layer.cornerRadius = countDownBT.frame.size.height / 2
        countDownBT.isUserInteractionEnabled = false
        updateNextQuestion()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func update() {
        if count > 0 {
            count -= 1
            countDownBT.setTitle(String(count), for: .normal)
        } else if count == 0 {
            score?.score -= 10
            currentQuestionNumber += 1
            updateNextQuestion()
        }
    }
    
    func updateNextQuestion() {
    
        if currentQuestionNumber != questions.count {
            count = 10
            questionLB.text = questions[currentQuestionNumber].question
            questionTV.reloadData()
        } else {
            dismiss(animated: false) {
                self.score?.scoredOn = Date()
                self.score?.save()
                self.onSuccess?(self.score)
            }
        }
    }

}

extension QuestionVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionNumber].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as? OptionCell else {
            return UITableViewCell()
        }
        
        cell.setup(option: questions[currentQuestionNumber].options[indexPath.row])
        return cell
    }
}

extension QuestionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if questions[currentQuestionNumber].answer == (indexPath.row + 1) {
            score?.score += 20 + count
        } else {
            score?.score -= 10
        }
        currentQuestionNumber += 1
        updateNextQuestion()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
