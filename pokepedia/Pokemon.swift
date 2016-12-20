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
    fileprivate var _nextEvoTxt:String!
    fileprivate var _nextEvoId:String!
    fileprivate var _nextEvoLvl:String!
    fileprivate var _pokemonUrl_v1:String!
    fileprivate var _pokemonUrl_v2:String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    
    init (name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        //Different API versions, JSON of v2 currentlt is not perfect
        _pokemonUrl_v2 = "\(URL_BASE)\(URL_POKEMON_V2)\(self.pokedexId)/"
        _pokemonUrl_v1 = "\(URL_BASE)\(URL_POKEMON_V1)\(self.pokedexId)/"
    }
    
    
    
    func downloadPokemonDetails (completed:@escaping DownloadComplete) {
        
        let url = _pokemonUrl_v1!
        Alamofire.request(url, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
           
            //to get JSON return value
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = "\(weight)"
                }
                
                if let height = dict["height"] as? String {
                    self._height = "\(height)"
                }
                
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                //print(self._weight)
                //print(self._height)
                //print(self._attack)
                //print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                        if let name = types[0]["name"] {
                            self._type = name
                        }
                    
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count{
                            if let name = types[x]["name"] {
                                    self._type! += "/\(name)"
                                }
                            }
                            
                        }
                    }
                    print(self._type)
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                        if let url = descArr[0]["resource_uri"]{
                            let url_desc = ("\(URL_BASE)\(url)")
                            
                            Alamofire.request(url_desc).responseJSON { response in
                                if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                    
                                    if let description = descDict["description"] as? String {
                                        
                                        self._description = description
                                        print(self._description)
                                    }
                                }
                                
                                completed()
                            }
                        }
                        
                    } else {
                        self._description = ""
                    }
                    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0 {
                        
                        if let to = evolutions[0]["to"] as? String {
                            
                            //Can't support Mega pokemons right now, but api still had mega data
                            if to.range(of: "mega") == nil {
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    
                                    let num = newStr.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvoId = num
                                    self._nextEvoTxt = to
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        
                                        self._nextEvoLvl = "\(lvl)"
                                    }
                                    
                                    //print(self._nextEvoId)
                                    //print(self._nextEvoTxt)
                                    //print(self._nextEvoLvl)
                                }
                            }
                        }
                        
                }
            }
        }
    }
}
