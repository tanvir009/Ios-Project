//
//  apiViewController.swift
//  FoodKart3
//
//  Created by Asfia Moon on 30/11/22.
//

import UIKit

class apiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let url = "https://mocki.io/v1/dab885d0-3dba-4852-bd6d-f1a6ad83e6ed";
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?f=b"
        getData(from: url)
    }
    

    private func getData(from url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            //var result: Response?
            var result: A?
            do {
                //result = try JSONDecoder().decode(Response.self , from: data)
                result = try JSONDecoder().decode(A.self, from: data)
                
               // let result1:A?=result
                
              
                
                for i in result?.meals ?? [] {
                    debugPrint(i.idMeal,i.strMeal)
                }
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
           // print(json.meals)
            //print(json.id)
            //print(json.name)
        })
        task.resume()
    }
}

struct Response: Codable{
    let id: Int
    let name: String
}

struct MyResult: Codable{
    let id: Int
    let name: String
}

struct A: Decodable{
    let meals: [B]
}

struct B: Decodable{
    let idMeal, strMeal: String
}
