//
//  PlayerInfoVC.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class PlayerInfoVC: QuizAppVC {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var genderSC: UISegmentedControl!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var startBT: UIButton!
    
    let score = Score()
    
    var onSuccess : ((Score?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBT.layer.masksToBounds = true
        startBT.layer.cornerRadius = startBT.frame.size.height / 2

    }

    @IBAction func startTapped(_ sender: UIButton) {
        guard let name = nameTF.text, !name.isEmpty else {
            view.makeToast("Name can't be empty")
            return
        }
        guard let age = ageTF.text, !age.isEmpty else {
            view.makeToast("Age can't be empty")
            return
        }
        
        score.name = name
        score.age = age
        if genderSC.selectedSegmentIndex == 0 {
            score.gender = "Male"
        }else if genderSC.selectedSegmentIndex == 0 {
            score.gender = "Female"
        }
        
        performSegue(withIdentifier: "questionSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "questionSegue":
            let vc = segue.destination as? QuestionVC
            vc?.score = score
            vc?.onSuccess = { score in
                self.navigationController?.popViewController(animated: false)
                self.onSuccess?(score)
            }
        default:
            break
        }
    }
}
