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
    private var _pokemonId: Int!
    
    var name: String {
        return _name
    }
    
    var pokemonId: Int {
        return _pokemonId
    }
    
    init (name: String, pokemonId: Int){
         self._name = name
         self._pokemonId = pokemonId
    }
}