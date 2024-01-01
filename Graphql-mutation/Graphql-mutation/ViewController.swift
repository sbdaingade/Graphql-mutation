//
//  ViewController.swift
//  Graphql-mutation
//
//  Created by Sachin Daingade on 31/12/23.
//

import UIKit
import SpaceXAPI
class ViewController: UIViewController {

    @IBOutlet weak var rocketTable: UITableView!
    
    private var rockets: [RocketsQuaryQuery.Data.Rocket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchRocketData()
    }

    private func fetchRocketData() {
        let query = RocketsQuaryQuery()
        NetworkService.shared.apollo.fetch(query: query) {[weak self] result in
            switch result {
            case .success(let values):
                self?.rockets = values.data?.rockets?.compactMap {$0} ?? []
                self?.rocketTable.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rocketCell", for: indexPath)
        let rocket = rockets[indexPath.row]
        cell.textLabel?.text = rocket.name
        cell.detailTextLabel?.text = "\(rocket.height?.meters ?? .zero) meters / \(rocket.mass?.kg ?? .zero) kg"

//        var contentConfiguration = UIListContentConfiguration.subtitleCell()
//        contentConfiguration.text = rocket.name
//        contentConfiguration.secondaryText = "\(rocket.height?.meters ?? .zero) meters / \(rocket.mass?.kg ?? .zero) kg"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LauchesSegue", sender: rockets[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LauchesSegue" , let vc = segue.destination as? LauchesViewController, let rocket = sender as? RocketsQuaryQuery.Data.Rocket else { return }
        
        vc.rocket = rocket
    }
    
}
