//
//  ViewController.swift
//  LocalTimeNotification
//
//  Created by Julio Collado on 12/1/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var notificationText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushLocalNotification(_ sender: UIButton) {
        let notifications = NotificationManager()
        
        guard let notificationMessage = notificationText.text, !notificationMessage.isEmpty  else {
            return
        }
        
        let alert = UIAlertController(title: "",
                                      message: "After 3 seconds a notification will appear",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            notifications.scheduleNotification(notificationTitle: notificationMessage)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}

