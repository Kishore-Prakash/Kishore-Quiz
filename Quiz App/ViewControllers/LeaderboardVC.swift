//
//  LeaderboardVC.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class LeaderboardVC: QuizAppVC {

    @IBOutlet weak var leaderboardTV: UITableView!
    
    var scores = Score.getAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTV.tableFooterView = UIView()
    }

}

extension LeaderboardVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as? LeaderboardCell else {
            return UITableViewCell()
        }
        
        cell.setup(score: scores[indexPath.row])
        
        return cell
    }
}
