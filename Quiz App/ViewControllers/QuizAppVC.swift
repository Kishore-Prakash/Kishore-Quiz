//
//  QuizAppVC.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import UIKit

class QuizAppVC: UIViewController {

    private var _isNavBarHidden = false
    private var _isBackHidden = false
    var isNavBarHidden: Bool {
        set {
            _isNavBarHidden = newValue
            navigationController?.setNavigationBarHidden(newValue, animated: true)
        }
        get{
            return _isNavBarHidden
        }
    }
    
    var isBackHidden: Bool {
        set {
            guard let _ = navigationController else {
                return
            }
            _isBackHidden = newValue
            navigationItem.setHidesBackButton(newValue, animated: true)
        }
        get{
            return _isBackHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavBarHidden = false
        isBackHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
