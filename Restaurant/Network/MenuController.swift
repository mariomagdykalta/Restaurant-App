//
//  MenuController.swift
//  Restaurant
//
//  Created by mario on 05/09/2024.
//
import UIKit

class MenuController {
    
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://localhost:8080/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        // fetchCategories task closure
        let task = URLSession.shared.dataTask(with: categoryURL)
        { (data, response, error) in
            if let data = data,
                let jsonDictionary = try?
                    JSONSerialization.jsonObject(with: data) as?
                        [String:Any],
               let categories = jsonDictionary["categories"] as?
                    [String] {
                completion(categories)
            } else {
                completion(nil)
            } // end if-let-else
        } // end closure
        task.resume()
    } // end fetchCategories
    
    
    func fetchMenuItems(forCategory categoryName: String,
                        completion: @escaping ([MenuItem]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: categoryURL,
                                       resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category",
                                              value: categoryName)]
        let menuURL = components.url!
        // fetchMenuItems
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
            let menuItems = try? jsonDecoder.decode(MenuItems.self,
            from: data) {
            completion(menuItems.items)
            } else {
            completion(nil)
            } // end if-let-else
        } // end task closure
        task.resume()
    } // end fetchMenuItems
    
    
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            } // end if-else
        } // end dataTask
        task.resume()
    } // end submitOrder
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            } // end if-else
        } // end dataTask
        
        task.resume()
    } // end fetchImage()
    
} // end class MenuController
