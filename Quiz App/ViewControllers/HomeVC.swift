//
//  ViewController.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeVC: QuizAppVC {

    @IBOutlet weak var startQuizBT: UIButton!
    @IBOutlet weak var leaderboardBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startQuizBT.layer.masksToBounds = true
        startQuizBT.layer.cornerRadius = startQuizBT.frame.size.height / 2
        
        leaderboardBT.layer.masksToBounds = true
        leaderboardBT.layer.cornerRadius = leaderboardBT.frame.size.height / 2
        
        if Question.getAll().count == 0 {
            WebServices.shared.get(with: "https://storage.googleapis.com/sodimac-8590a.appspot.com/App%20Test%20Assignment/app_test_assignment_quiz.json") { (response) in
                DispatchQueue.main.async {
                    if response.status == .success {
                        do {
                            let jsonArray = try JSON(data: response.data!)
                            for (_, item) in jsonArray  {
                                let question = Question(json: item)
                                question.save()
                            }
                        } catch let error {
                            print(error)
                            self.view.makeToast(error.localizedDescription)
                        }
                    } else {
                        self.view.makeToast("Please check your internet")
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "playerInfoSegue":
            let vc = segue.destination as? PlayerInfoVC
            vc?.onSuccess = { score in
                if let score = score {
                    let alert = UIAlertController(title: "Your Score", message: "\(score.name) you have scored \(String(score.score))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        default:
            break
        }
    }

}

