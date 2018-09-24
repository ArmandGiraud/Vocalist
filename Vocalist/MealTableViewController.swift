//
//  MealTableViewController.swift
//  Vocalist
//
//  Created by Giraud Armand on 15/09/2018.
//  Copyright © 2018 Giraud Armand. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController, UISearchBarDelegate {
    //MARK: Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    var meals = [Meal]()
    var current_meals = [Meal]()
    var both = ""
    
    override func viewDidLoad() {
        setUpSearchBar()
        super.viewDidLoad()
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
            current_meals = meals
        }else {
            // Load the sample data.
            loadSampleMeals()
            current_meals = meals
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return current_meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let current_meals = self.current_meals[indexPath.row]
        
        cell.french_place.text = current_meals.word
        cell.russian_place.text = current_meals.translation
        cell.example_place.text = current_meals.example
        cell.ratingControl.rating = current_meals.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? FirstViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? FirstViewController,
            let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                current_meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                saveMeals()
            }
            else{

                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                current_meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                // Save the meals.
                saveMeals()
            }


        }
    }
    //MARK: class methods:
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        current_meals = meals
        guard !searchText.isEmpty else {
            current_meals = meals
            tableView.reloadData()
            return
        }
    
        
        current_meals = meals.filter({ meal -> Bool in
            (meal.word.lowercased() + " " + meal.translation.lowercased()).contains(searchText.lowercased())
        
        })
        tableView.reloadData()
    }
    //MARK: Private Methods
    
    private func loadSampleMeals() {
       
        guard let meal1 = Meal(word: "Le Manteau", translation: "пальто" ,example: "Quand j'ai froid, je porte mon manteau", rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(word: "l'aspirateur", translation: "вакуум", example: "J'ai acheté un nouvel aspirateur", rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(word: "l'écran", translation: "экран",example: "Mon écran est tout bleu!!" , rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }
    private func saveMeals() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        // test if saving is successful
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    private func loadMeals() -> [Meal]?  {
        print(Meal.ArchiveURL)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    //MARK: SearchBar delegates
    private func searchBarTextDidEndEditing(_ searcBar: UISearchBar) -> Bool {
        // Hide the keyboard.
        searchBar.resignFirstResponder()
        return true
    }

}
