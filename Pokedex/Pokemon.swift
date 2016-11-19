//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import Foundation
class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    
    var name :String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    init(name: String , pokedexId: Int) {
    
        _name = name
        _pokedexId = pokedexId
        
    }
    
    
}
