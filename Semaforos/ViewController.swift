//
//  ViewController.swift
//  Semaforos
//
//  Created by Ricardo Champa on 28/07/2018.
//  Copyright © 2018 rchampa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dispatchGroup = DispatchGroup()
        
        for i in 1...100 {
            let job = BackgroundJob(withID: i)
            sendJob(withJob: job, dispatchGroup: dispatchGroup)
            
        }

        dispatchGroup.notify(qos: DispatchQoS.background,
                             flags: DispatchWorkItemFlags.assignCurrentContext,
                             queue: DispatchQueue.global(qos: .default),
                             execute: {
                                
                                print("END OF EVERYTHING")
        })

    }

    func sendJob(withJob job: BackgroundJob, dispatchGroup: DispatchGroup) {
        
        dispatchGroup.enter()
        
        DispatchQueue.global(qos: .background).async {
            
            //do my stuff
            job.doTask()
            dispatchGroup.leave()
        }
    }

}

