//
//  BackgroundJob.swift
//  Semaforos
//
//  Created by Ricardo Champa on 28/07/2018.
//  Copyright © 2018 rchampa. All rights reserved.
//

import UIKit

class BackgroundJob {
    
    var id :Int
    
    init(withID id:Int) {
        self.id = id
    }
    
    public func doTask(){
        print("Working on job: \(id)")
    }
}
