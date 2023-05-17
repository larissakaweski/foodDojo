//
//  CamadaRede.swift
//  foodDojo
//
//  Created by Larissa Kaweski Siqueira on 15/05/23.
//

import UIKit

public struct Foods: Codable {
    let id: Int?
    let name: String?
    let image: String?
}

public protocol CamadaRedeProtocol: AnyObject {
    func getConectionApi(entity: [Foods])
}

class CamadaRede {
    
    weak var delegate: CamadaRedeProtocol?
    
    public func makeRequest() {
        let url = URL(string: "https://foods-json-server.lucachaves.repl.co/foods")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let responseData = data else { return }

            do {
                let foods = try JSONDecoder().decode([Foods].self, from: responseData)
                self.delegate?.getConectionApi(entity: foods)
            } catch let error {
                print("error: \(error)")
            }
            
//            if let responseString = String(data: responseData, encoding: .utf8) {
//                print("data: \(String(describing: responseString))")
//            }
        }
        task.resume()
    }
}
