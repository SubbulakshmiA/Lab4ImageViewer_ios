//
//  Service.swift
//  Lab4ImageViewer_Oct10
//
//  Created by user243757 on 10/10/23.
//

import Foundation

class Service{
   
    private init(){}
    static var shared = Service()
    
    func getData(urlStr: String, completion: @escaping (Data?)->()){
        guard  let url = URL(string: urlStr) else {return }
        let myQ = DispatchQueue(label: "myQ")
        myQ.async {
            Thread.sleep(forTimeInterval: 2)
            let data = try? Data(contentsOf: url)
            completion(data)
        }
        
    }
    
    
    
}


