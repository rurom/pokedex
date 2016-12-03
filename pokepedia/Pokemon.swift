//
//  Pokemon.swift
//  pokepedia
//
//  Created by Roman on 30.06.16.
//  Copyright © 2016 Roman.Rudavskiy. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description:String!
    fileprivate var _type:String!
    fileprivate var _defense:String!
    fileprivate var _height:String!
    fileprivate var _weight:String!
    fileprivate var _attack:String!
    fileprivate var _nexEvoTxt:String!
    fileprivate var _pokemonUrl:String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    
    func downloadPokemonDetails (completed:DownloadComplete) {
        
        let url = _pokemonUrl!
        Alamofire.request(url, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                
                if let height = dict["height"] as? Int {
                    self._height = "\(height)"
                }
                
                guard let statsNode = dict["stats"] as? [[String:Any]] else { return }
                
                for (number, statNode) in statsNode.enumerated() {
                    
                    guard let statValue = statNode["base_stat"] as? Int else { continue }
                    
                    switch number {
                    case 3:
                        self._defense = "\(statValue)"
                    case 4:
                        self._attack = "\(statValue)"
                    default:
                        break
                    }
                    
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    if let type = types[0]["type"] as? Dictionary<String, String>{
                        if let name = type["name"] {
                            self._type = name
                        }
                        
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count{
                            if let type = types[x]["type"] {
                                if let name = type["name"]! {
                                    self._type! += "/\(name)"
                                }
                            }
                            
                        }
                    }
                    print(self._type)
                }
            }
        }
    }
}
