//
//  PokemonDetailVC.swift
//  pokepedia
//
//  Created by Roman on 25.11.16.
//  Copyright © 2016 Roman.Rudavskiy. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var grayBg: UIView!
    @IBOutlet weak var loadingTxt: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
                pokemon.downloadPokemonDetails {() -> () in
                //this will be called after download is done
               self.updateUI()
                
               self.activityIndicatorView.stopAnimating()
               self.grayBg.isHidden = true
               self.loadingTxt.isHidden = true
            }

        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        
    }
    
    func updateUI() {
        
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var str = "Next Evolution: \(pokemon.nextEvoTxt)"
            
            if pokemon.nextEvoLvl != "" {
                
                str += " - LVL: \(pokemon.nextEvoLvl)"
                
            }
            evoLbl.text = str
        }
    }
    
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}

