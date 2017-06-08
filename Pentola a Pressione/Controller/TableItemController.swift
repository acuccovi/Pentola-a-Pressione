//
//  TableItemController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 29/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class TableItemController: NSObject {
    //original data holding all the categories/products available
    private var originalData = [String : [TableItem]]()
    //filtered data containing: all data or the result of the user search
    private var filteredData = [String : [TableItem]]()

    //singleton, we need only one instance of TableItemController
    static let shared: TableItemController = {
        return TableItemController()
    }()

    private override init() {
        originalData["Arrosti vari"] = [
            TableItem(withTitle: "Agnello", minTime: 18, maxTime: 22),
            TableItem(withTitle: "Anatra", minTime: 20, maxTime: 25),
            TableItem(withTitle: "Capretto", minTime: 18, maxTime: 22),
            TableItem(withTitle: "Coniglio", minTime: 15, maxTime: 18),
            TableItem(withTitle: "Fagiano", minTime: 20, maxTime: 25),
            TableItem(withTitle: "Faraona", minTime: 28, maxTime: 30),
            TableItem(withTitle: "Maiale", minTime: 18, maxTime: 22),
            TableItem(withTitle: "Manzo", minTime: 30, maxTime: 35),
            TableItem(withTitle: "Pollo novello", minTime: 12, maxTime: 15),
            TableItem(withTitle: "Pollo", minTime: 18),
            TableItem(withTitle: "Vitello", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Roastbeef al sangue", minTime: 6, maxTime: 8),
            TableItem(withTitle: "Roastbeef medio", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Roastbeef ben cotto", minTime: 10, maxTime: 12),
        ]

        originalData["Bollito"] = [
            TableItem(withTitle: "Cotechino", minTime: 20, maxTime: 25),
            TableItem(withTitle: "Gallina", minTime: 20, maxTime: 25),
            TableItem(withTitle: "Maile costina", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Maiale piedino", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Maiale testina", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Manzo lingua", minTime: 60),
            TableItem(withTitle: "Manzo polpa", minTime: 45, maxTime: 50),
            TableItem(withTitle: "Pollo", minTime: 18, maxTime: 20),
            TableItem(withTitle: "Vitello lingua", minTime: 30, maxTime: 35),
            TableItem(withTitle: "Vitello polpa", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Vitello testina", minTime: 30),
            TableItem(withTitle: "Zampone", minTime: 25, maxTime: 30),
        ]

        originalData["Carne umida, brasato e stufati"] = [
            TableItem(withTitle: "Agnello", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Capretto", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Coniglio", minTime: 15, maxTime: 20),
            TableItem(withTitle: "Lepre", minTime: 30),
            TableItem(withTitle: "Maiale", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Manzo", minTime: 50),
            TableItem(withTitle: "Oca", minTime: 45),
            TableItem(withTitle: "Ossi buchi di vitello", minTime: 12, maxTime: 15),
            TableItem(withTitle: "Ossi buchi di manzo", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Pollame", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Vitello", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Trippa (già cotta)", minTime: 15, maxTime: 20),
        ]

        originalData["Pesce"] = [
            TableItem(withTitle: "Anguilla", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Aragosta", minTime: 8, maxTime: 12),
            TableItem(withTitle: "Carpa", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Cozze, vongole", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Gamberetti", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Merluzzo", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Persico", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Polpi", minTime: 15, maxTime: 20),
            TableItem(withTitle: "Scampi", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Seppie", minTime: 2, maxTime: 4),
            TableItem(withTitle: "Trotelle", minTime: 8, maxTime: 12),
            TableItem(withTitle: "Zuppa di pesce", minTime: 6, maxTime: 8),
        ]

        originalData["Legumi secchi"] = [
            TableItem(withTitle: "Ceci", minTime: 20, maxTime: 30),
            TableItem(withTitle: "Fagioli", minTime: 30, maxTime: 40),
            TableItem(withTitle: "Fave", minTime: 30, maxTime: 40),
            TableItem(withTitle: "Lenticchie", minTime: 12, maxTime: 15),
            TableItem(withTitle: "Piselli", minTime: 18, maxTime: 25),
        ]

        originalData["Legumi freschi"] = [
            TableItem(withTitle: "Ceci", minTime: 15, maxTime: 20),
            TableItem(withTitle: "Fagioli", minTime: 25, maxTime: 30),
            TableItem(withTitle: "Fave", minTime: 10, maxTime: 15),
            TableItem(withTitle: "Lenticchie", minTime: 10, maxTime: 12),
            TableItem(withTitle: "Piselli", minTime: 15, maxTime: 20),
        ]

        originalData["Riso"] = [
            TableItem(withTitle: "Riso", minTime: 5, maxTime: 7),
        ]

        originalData["Frutta secca"] = [
            TableItem(withTitle: "Albicocche", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Castagne", minTime: 30, maxTime: 40),
            TableItem(withTitle: "Fichi", minTime: 12, maxTime: 12),
            TableItem(withTitle: "Mele", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Pesche", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Prugne", minTime: 8, maxTime: 10),
        ]

        originalData["Frutta fresca"] = [
            TableItem(withTitle: "Albicocche", minTime: 2),
            TableItem(withTitle: "Ciliegie", minTime: 2),
            TableItem(withTitle: "Pesche", minTime: 2),
            TableItem(withTitle: "Mele", minTime: 5),
            TableItem(withTitle: "Pere", minTime: 3),
        ]

        originalData["Verdura fresca"] = [
            TableItem(withTitle: "Asparagi", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Barbabietole intere", minTime: 8, maxTime: 12),
            TableItem(withTitle: "Barbabietole tagliate", minTime: 15, maxTime: 18),
            TableItem(withTitle: "Bietole", minTime: 4, maxTime: 5),
            TableItem(withTitle: "Broccole", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Carciofi a pezzi o novelli", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Carciofi interi", minTime: 10, maxTime: 12),
            TableItem(withTitle: "Cardi", minTime: 12),
            TableItem(withTitle: "Carote a pezzi", minTime: 3, maxTime: 4),
            TableItem(withTitle: "Carote intere", minTime: 5, maxTime: 6),
            TableItem(withTitle: "Cavolfiori a mazzetti", minTime: 4, maxTime: 5),
            TableItem(withTitle: "Cavolfiori interi", minTime: 8, maxTime: 12),
            TableItem(withTitle: "Cavolini di Bruxelles", minTime: 4, maxTime: 5),
            TableItem(withTitle: "Cavolo", minTime: 6, maxTime: 8),
            TableItem(withTitle: "Cipolline", minTime: 5, maxTime: 6),
            TableItem(withTitle: "Cipolle", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Coste", minTime: 6, maxTime: 8),
            TableItem(withTitle: "Fagioli freschi", minTime: 15, maxTime: 18),
            TableItem(withTitle: "Fagiolini verdi", minTime: 4, maxTime: 5),
            TableItem(withTitle: "Melanzane a pezzi", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Patate a pezzi", minTime: 5, maxTime: 6),
            TableItem(withTitle: "Patate intere", minTime: 10, maxTime:15 ),
            TableItem(withTitle: "Patate novelle", minTime: 6, maxTime: 8),
            TableItem(withTitle: "Peperoni a fette", minTime: 15),
            TableItem(withTitle: "Piselli", minTime: 2, maxTime: 5),
            TableItem(withTitle: "Pomodiri a pezzi", minTime: 3, maxTime: 5),
            TableItem(withTitle: "Porri", minTime: 4, maxTime: 6),
            TableItem(withTitle: "Rape a pezzi", minTime: 8, maxTime: 10),
            TableItem(withTitle: "Rape intere", minTime: 10, maxTime: 15),
            TableItem(withTitle: "Sedano a pezzi", minTime: 6, maxTime: 8),
            TableItem(withTitle: "Spinaci", minTime: 3, maxTime: 4),
            TableItem(withTitle: "Verza a pezzi", minTime: 5, maxTime: 8),
            TableItem(withTitle: "Zucca a pezzi", minTime: 4, maxTime: 5),
            TableItem(withTitle: "Zucchini", minTime: 2, maxTime: 3),
        ]

        //filtered data starts with all data
        filteredData = originalData
    }

    //returns the available categories, no matter if user has already serached for something or not
    public func getSections() -> [String] {
        return filteredData.keys.sorted()
    }

    //returns the data, we do matter if the user is searching for something or not
    public func getData(_ searchString: String) -> [String : [TableItem]] {
        //if no query issued return all the data
        if(searchString == "") {
            filteredData = originalData
        } else {
            //clear the filtered data
            filteredData.removeAll()

            //for each category
            for key in originalData.keys {
                if let values = originalData[key] {
                    //search the product that contains the searched string in the name field
                    let vals = values.filter({ $0.title.lowercased().contains(searchString.lowercased()) })
                    //if something is found it's added to the filteredData dictionary
                    if vals.count > 0 {
                        filteredData[key] = vals
                    }
                }
            }
        }
        return filteredData
    }
    
}
