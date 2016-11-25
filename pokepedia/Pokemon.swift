//
//  Pokemon.swift
//  pokepedia
//
//  Created by Roman on 30.06.16.
//  Copyright © 2016 Roman.Rudavskiy. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int){
         self._name = name
         self._pokedexId = pokedexId
    }
}