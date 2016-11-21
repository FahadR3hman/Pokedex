//
//  ViewController.swift
//  Pokedex
//
//  Created by Fahad Rehman on 11/19/16.
//  Copyright © 2016 Codecture. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBAction func musicbtnpressed(_ sender: UIButton!) {
        
        if player.isPlaying {
            player.pause()
            sender.alpha = 0.5
        }
        else {
            player.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parseTocsv()
        audioinit()
        
    }
    
    func audioinit() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            player = try AVAudioPlayer(contentsOf: URL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            
            player.play()
            
        } catch {
            print (error)
        }
        
        
    }
    
    func parseTocsv() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            print(rows)
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                //print(pokeID , name)
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemon.append(poke)
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            var poke : Pokemon!
            if inSearchMode {
                poke = filteredPokemon [indexPath.row]
                cell.configurecell(poke)
            } else {
                poke = pokemon [indexPath.row]
                cell.configurecell(poke)
            }
            
            return cell
        }
        else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke : Pokemon!
        if inSearchMode {
            poke = filteredPokemon [indexPath.row]
            
        } else {
            poke = pokemon [indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemondetailVC", sender: poke)
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
            
        } else {
            
            return pokemon.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 112)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({($0.name.range(of: lower) != nil) }) //searching
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemondetailVC" {
            
            if let destinationSegue = segue.destination as? PokemondetailVC {
                if let poke = sender as? Pokemon {
                    destinationSegue.pokemon1 = poke
                    
                }
                
            }
        }
    }
    
}

