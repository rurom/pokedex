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
    fileprivate var _defence:String!
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
        Alamofire.request(url).response { response in // method defaults to `.get`
            debugPrint(response)
        }
        
        
            //{ (request: NSURLRequest?, response: HTTPURLResponse?, result: Result<AnyObject>) -> Void in
            
            //print(result.value.debugDescription)
        //}
    }
}
