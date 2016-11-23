//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon {
    
    fileprivate var _name : String!
    fileprivate var _pokedexId : Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvo:String!
    private var _pokemon_url : String!
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLvl:String!
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvo: String {
        if _nextEvo == nil {
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight:String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var defense:String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var type:String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height:String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var description:String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    
    var name :String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    init(name: String , pokedexId: Int) {
        
        _name = name
        _pokedexId = pokedexId
        _pokemon_url = "\(Base_url)\(poke_url)\(pokedexId)/"
    }
    
    func DownloadPokemonDetail(Download: @escaping downloadCompleted)   {
        
        Alamofire.request(_pokemon_url).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String , AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = "\(weight)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let height = dict["height"] as? String {
                    self._height = "\(height)"
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
            
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 { //if more than one types
                        for x in 1..<types.count {
                            let name = types[x]["name"]
                            self._type! += "/\(name!.capitalized)"
                        }
                    }
                }
                    
                    
                    
                else {
                    self._type = ""
                }
                
               
                
                if let desArr = dict["descriptions"] as? [Dictionary<String, String>] , desArr.count > 0 {
                    if let url = desArr[0]["resource_uri"] {
                        
                        let descURL = "\(Base_url)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let dict2 = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = dict2["description"] as? String {
                                    self._description = description
                                    print(description)
                                }
                            }
                            Download()
                        })
                    }
                }
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoID = nextEvoId
                                
                                
                                if let lvlExist = evolutions[0]["level"] as? Int {
                                    
                                   
                                        
                                        self._nextEvoLvl = "\(lvlExist)"
                                    
                                
                                } else {
                                    self._nextEvoLvl = ""
                                }
                            
                        
                        
                    }
                    
                    print(self._nextEvoLvl)
                    print(self._nextEvoName)
                    print(self._nextEvoID)
                }
                
                
            }
            Download()
        }
        
    }
    
    
    
    }
}
































