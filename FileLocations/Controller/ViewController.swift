//
//  ViewController.swift
//  FileLocations
//
//  Created by Rick Jacobson on 4/18/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var films: [FilmEntryCodable] = []
    
    let filmsTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromFile("locations")
        
        filmsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filmsTable.dataSource = self
        filmsTable.delegate = self
        
        setupTableView()
        
    }

    func getDataFromFile(_ fileName:String) {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let contents = try? Data(contentsOf: url)
            if let data = contents {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let filmsFromJSON = try decoder.decode([FilmEntryCodable].self, from: data)
                    films = filmsFromJSON
                    filmsTable.reloadData()
                } catch {
                    print("He's dead, Jim")
                }
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(filmsTable)
        
        filmsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filmsTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(films[indexPath.row].title) \(films[indexPath.row].releaseYear.value)"
        return cell
    }

}

