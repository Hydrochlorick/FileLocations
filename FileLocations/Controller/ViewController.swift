//
//  ViewController.swift
//  FileLocations
//
//  Created by Rick Jacobson on 4/18/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var films: [FilmEntry] = []
    
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
            print(url)
            
            let contents = try? Data(contentsOf: url)
            do {
              if let data = contents,
              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                for film in jsonResult{
//                    let firstActor = film["actor_1"] as? String ?? ""
//                    let locations = film["locations"] as? String  ?? ""
//                    let releaseYear = film["release_year"] as? String  ?? ""
//                    let title = film["title"] as? String  ?? ""
//                    let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                    
                    // This doesn't work. TODO: Figure out why.
                    guard let movie = FilmEntry(json: film) else { return }
                    films.append(movie)
                }
              }
            } catch {
              print("Error deserializing JSON: \(error)")
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
        cell.textLabel?.text = films[indexPath.row].title
        return cell
    }

}

