//
//  ApiManager.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case error(String)
}

class ApiManager {
    var lineupCache: LineupCache
    
    let decoder: JSONDecoder = JSONDecoder()
    
    let scheme = "https"
    let host = "blitz-app-api.herokuapp.com"
    
    init?() {
        if let lineupCache = LineupCache.getTodaysLineup() {
            self.lineupCache = lineupCache
            return
        }
        
        return nil
    }
    
    private func makeRequest(path: String, queryItems: [URLQueryItem]?, completion: @escaping ((Result<Data>) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        //urlComponents.port = port
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.error("Could not create URL"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion(.error(error.localizedDescription))
                }
                else if let data = responseData {
                    completion(.success(data))
                }
                else {
                    completion(.error("Data could not be retrieved from request"))
                }
            }
        }
        
        task.resume()
    }
    
    func getLineup(completion: @escaping ((Result<Lineup>) -> Void)) {
        var queryItems: [URLQueryItem] = []
        if let qb = lineupCache.qb {
            queryItems.append(URLQueryItem(name: "QB", value: qb))
        }
        if let rb1 = lineupCache.rb1 {
            queryItems.append(URLQueryItem(name: "RB1", value: rb1))
        }
        if let rb2 = lineupCache.rb2 {
            queryItems.append(URLQueryItem(name: "RB2", value: rb2))
        }
        if let wr1 = lineupCache.wr1 {
            queryItems.append(URLQueryItem(name: "WR1", value: wr1))
        }
        if let wr2 = lineupCache.wr2 {
            queryItems.append(URLQueryItem(name: "WR2", value: wr2))
        }
        if let wr3 = lineupCache.wr3 {
            queryItems.append(URLQueryItem(name: "WR3", value: wr3))
        }
        if let te = lineupCache.te {
            queryItems.append(URLQueryItem(name: "TE", value: te))
        }
        if let k = lineupCache.f {
            queryItems.append(URLQueryItem(name: "F", value: k))
        }
        if let d = lineupCache.d {
            queryItems.append(URLQueryItem(name: "D", value: d))
        }
        
        makeRequest(path: "/lineup", queryItems: queryItems, completion: { (result) in
            switch(result) {
            case .success(let data):
                do {
                    let lineup = try self.decoder.decode(Lineup.self, from: data)
                    completion(.success(lineup))
                } catch let error {
                    completion(.error("Could not decode response. Error: " + error.localizedDescription))
                }
            case .error(let error):
                completion(.error(error))
            }
        })
    }
    
    func getDfsEntries(position: Position, completion: @escaping ((Result<[DfsEntry]>) -> Void)) {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "position", value: position.rawValue))
        
        makeRequest(path: "/dfs", queryItems: queryItems, completion: { (result) in
            switch(result) {
            case .success(let data):
                do {
                    let dfsEntries = try self.decoder.decode([DfsEntry].self, from: data)
                    completion(.success(dfsEntries))
                } catch let error {
                    completion(.error("Could not decode response. Error: " + error.localizedDescription))
                }
            case .error(let error):
                completion(.error(error))
            }
        })
    }
    
    func getStats(dfsEntry: DfsEntry, completion: @escaping ((Result<Stats>) -> Void)) {
        var path: String?
        var id: Int?
        if(dfsEntry.position == .D) {
            path = "/teamStats"
            id = dfsEntry.team?.id
        }
        else {
            path = "/playerStats"
            id = dfsEntry.player?.id
        }
        
        if let path = path, let id = id {
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "id", value: String(id)))
            
            makeRequest(path: path, queryItems: queryItems, completion: { (result) in
                switch(result) {
                case .success(let data):
                    do {
                        let stats = try self.decoder.decode(Stats.self, from: data)
                        completion(.success(stats))
                    } catch let error {
                        completion(.error("Could not decode response. Error: " + error.localizedDescription))
                    }
                case .error(let error):
                    completion(.error(error))
                }
            })
        }
        else {
            completion(.error("Could not obtain id"))
        }
    }
    
    func setLineupPosition(lineupPosition: Int?, playerId: String?) throws {
        switch lineupPosition {
        case 0:
            lineupCache.qb = playerId
        case 1:
            lineupCache.rb1 = playerId
        case 2:
            lineupCache.rb2 = playerId
        case 3:
            lineupCache.wr1 = playerId
        case 4:
            lineupCache.wr2 = playerId
        case 5:
            lineupCache.wr3 = playerId
        case 6:
            lineupCache.te = playerId
        case 7:
            lineupCache.f = playerId
        case 8:
            lineupCache.d = playerId
        default:
            break
        }
        
        let managedContext = lineupCache.managedObjectContext
        try managedContext?.save()
    }
}
