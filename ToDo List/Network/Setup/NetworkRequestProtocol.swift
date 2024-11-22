//
//  NetworkRequestProtocol.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

protocol NetworkRequestProtocol {
    
}

extension NetworkRequestProtocol {
    func pushData<T>(api: Api, params: [String: Any]? = nil, headers: [String: String]! = [:], body: Data? = nil,type: T.Type, isMain: Bool = true, completion: @escaping (Results<T>) -> ()) where T : Decodable {
        getRequest(api: api,params: params, headers: headers, body: body, type: type, completion: { result in
            if isMain {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
              completion(result)
            }
        })
    }
    
    func getRequest<T>(api: Api, params: [String: Any]? = nil, headers: [String: String]! = [:], body: Data? = nil,type: T.Type, completion: @escaping (Results<T>) -> ()) where T : Decodable {
        
        //params
        var urlComponents = URLComponents(string: api.path)
        urlComponents?.queryItems = params?.compactMap({ key, value in
            return .init(name: key, value: "\(value)")
        })
        
       //URL
        guard let url = urlComponents?.url else {
            completion(.failure(.notURL))
            return
        }
        var request = URLRequest(url: url,timeoutInterval: 10)
        
        //Method
        request.httpMethod = api.method
        
        
        //Headers
        for (key,value) in api.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        for (key,value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        //Body
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                
                if let error = error {
                    completion(.failure(.error(error)))
                    return
                }
                return completion(.failure(.message(999, "Не удалось обработать данные с сервера")))
            }
            
            let code = response.statusCode
            
            guard let value = try? JSONDecoder().decode(type.self, from: data) else {
                
                completion(.failure(.message(code, "Не удалось преобразовать модель данных")))
                return
            }
            
            completion(.success(value))
        }
        
        task.resume()
    }
}
