//
//  ViewController.swift
//  Semaforos
//
//  Created by Ricardo Champa on 28/07/2018.
//  Copyright © 2018 rchampa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dispatchGroupGLOBAL = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskA(semaphore: semaphore)
        taskB(semaphore: semaphore)
        taskC(semaphore: semaphore)
        taskD(semaphore: semaphore)
    }

    
    func taskA(semaphore: DispatchSemaphore){
        semaphore.wait()
        print("==========Task A==========")
        semaphore.signal()
    }
    
    func taskB(semaphore: DispatchSemaphore){
        semaphore.wait()
        print("==========Task B==========")
        semaphore.signal()
    }
    
    func taskC(semaphore: DispatchSemaphore){
        semaphore.wait()
        print("==========Task C==========")
        
        let dispatchGroupC = DispatchGroup()
        
        for i in 1...100 {
            let job = BackgroundJob(withID: i)
            sendJob(withJob: job, dispatchGroup: dispatchGroupC)
            
        }
        
        dispatchGroupC.notify(qos: DispatchQoS.background,
                             flags: DispatchWorkItemFlags.assignCurrentContext,
                             queue: DispatchQueue.global(qos: .default),
                             execute: {
                                print("==========END Task C=========")
                                self.semaphore.signal()
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
    
    func taskD(semaphore: DispatchSemaphore){
        semaphore.wait()
        print("==========Task D==========")
        semaphore.signal()
    }

}

