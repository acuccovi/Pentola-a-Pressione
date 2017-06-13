//
//  ProductTableItemController.swift
//  Pentola a Pressione
//
//  Created by Alessio Cuccovillo on 29/05/17.
//  Copyright © 2017 Alessio Cuccovillo. All rights reserved.
//

import UIKit

class ProductTableItemController: NSObject {
    //original data holding all the categories/products available
    private var originalData = [String : [ProductTableItem]]()
    //filtered data containing: all data or the result of the user search
    private var filteredData = [String : [ProductTableItem]]()

    //singleton, we need only one instance of ProductTableItemController
    static let shared: ProductTableItemController = {
        return ProductTableItemController()
    }()

    private override init() {
        originalData["Arrosti vari"] = [
           ProductTableItem(withTitle: "Agnello", minTime: 18, maxTime: 22),
           ProductTableItem(withTitle: "Anatra", minTime: 20, maxTime: 25),
           ProductTableItem(withTitle: "Capretto", minTime: 18, maxTime: 22),
           ProductTableItem(withTitle: "Coniglio", minTime: 15, maxTime: 18),
           ProductTableItem(withTitle: "Fagiano", minTime: 20, maxTime: 25),
           ProductTableItem(withTitle: "Faraona", minTime: 28, maxTime: 30),
           ProductTableItem(withTitle: "Maiale", minTime: 18, maxTime: 22),
           ProductTableItem(withTitle: "Manzo", minTime: 30, maxTime: 35),
           ProductTableItem(withTitle: "Pollo novello", minTime: 12, maxTime: 15),
           ProductTableItem(withTitle: "Pollo", minTime: 18),
           ProductTableItem(withTitle: "Vitello", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Roastbeef al sangue", minTime: 6, maxTime: 8),
           ProductTableItem(withTitle: "Roastbeef medio", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Roastbeef ben cotto", minTime: 10, maxTime: 12),
        ]

        originalData["Bollito"] = [
           ProductTableItem(withTitle: "Cotechino", minTime: 20, maxTime: 25),
           ProductTableItem(withTitle: "Gallina", minTime: 20, maxTime: 25),
           ProductTableItem(withTitle: "Maile costina", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Maiale piedino", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Maiale testina", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Manzo lingua", minTime: 60),
           ProductTableItem(withTitle: "Manzo polpa", minTime: 45, maxTime: 50),
           ProductTableItem(withTitle: "Pollo", minTime: 18, maxTime: 20),
           ProductTableItem(withTitle: "Vitello lingua", minTime: 30, maxTime: 35),
           ProductTableItem(withTitle: "Vitello polpa", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Vitello testina", minTime: 30),
           ProductTableItem(withTitle: "Zampone", minTime: 25, maxTime: 30),
        ]

        originalData["Carne umida, brasato e stufati"] = [
           ProductTableItem(withTitle: "Agnello", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Capretto", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Coniglio", minTime: 15, maxTime: 20),
           ProductTableItem(withTitle: "Lepre", minTime: 30),
           ProductTableItem(withTitle: "Maiale", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Manzo", minTime: 50),
           ProductTableItem(withTitle: "Oca", minTime: 45),
           ProductTableItem(withTitle: "Ossi buchi di vitello", minTime: 12, maxTime: 15),
           ProductTableItem(withTitle: "Ossi buchi di manzo", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Pollame", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Vitello", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Trippa (già cotta)", minTime: 15, maxTime: 20),
        ]

        originalData["Pesce"] = [
           ProductTableItem(withTitle: "Anguilla", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Aragosta", minTime: 8, maxTime: 12),
           ProductTableItem(withTitle: "Carpa", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Cozze, vongole", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Gamberetti", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Merluzzo", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Persico", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Polpi", minTime: 15, maxTime: 20),
           ProductTableItem(withTitle: "Scampi", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Seppie", minTime: 2, maxTime: 4),
           ProductTableItem(withTitle: "Trotelle", minTime: 8, maxTime: 12),
           ProductTableItem(withTitle: "Zuppa di pesce", minTime: 6, maxTime: 8),
        ]

        originalData["Legumi secchi"] = [
           ProductTableItem(withTitle: "Ceci", minTime: 20, maxTime: 30),
           ProductTableItem(withTitle: "Fagioli", minTime: 30, maxTime: 40),
           ProductTableItem(withTitle: "Fave", minTime: 30, maxTime: 40),
           ProductTableItem(withTitle: "Lenticchie", minTime: 12, maxTime: 15),
           ProductTableItem(withTitle: "Piselli", minTime: 18, maxTime: 25),
        ]

        originalData["Legumi freschi"] = [
           ProductTableItem(withTitle: "Ceci", minTime: 15, maxTime: 20),
           ProductTableItem(withTitle: "Fagioli", minTime: 25, maxTime: 30),
           ProductTableItem(withTitle: "Fave", minTime: 10, maxTime: 15),
           ProductTableItem(withTitle: "Lenticchie", minTime: 10, maxTime: 12),
           ProductTableItem(withTitle: "Piselli", minTime: 15, maxTime: 20),
        ]

        originalData["Riso"] = [
           ProductTableItem(withTitle: "Riso", minTime: 5, maxTime: 7),
        ]

        originalData["Frutta secca"] = [
           ProductTableItem(withTitle: "Albicocche", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Castagne", minTime: 30, maxTime: 40),
           ProductTableItem(withTitle: "Fichi", minTime: 12, maxTime: 12),
           ProductTableItem(withTitle: "Mele", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Pesche", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Prugne", minTime: 8, maxTime: 10),
        ]

        originalData["Frutta fresca"] = [
           ProductTableItem(withTitle: "Albicocche", minTime: 2),
           ProductTableItem(withTitle: "Ciliegie", minTime: 2),
           ProductTableItem(withTitle: "Pesche", minTime: 2),
           ProductTableItem(withTitle: "Mele", minTime: 5),
           ProductTableItem(withTitle: "Pere", minTime: 3),
        ]

        originalData["Verdura fresca"] = [
           ProductTableItem(withTitle: "Asparagi", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Barbabietole intere", minTime: 8, maxTime: 12),
           ProductTableItem(withTitle: "Barbabietole tagliate", minTime: 15, maxTime: 18),
           ProductTableItem(withTitle: "Bietole", minTime: 4, maxTime: 5),
           ProductTableItem(withTitle: "Broccole", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Carciofi a pezzi o novelli", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Carciofi interi", minTime: 10, maxTime: 12),
           ProductTableItem(withTitle: "Cardi", minTime: 12),
           ProductTableItem(withTitle: "Carote a pezzi", minTime: 3, maxTime: 4),
           ProductTableItem(withTitle: "Carote intere", minTime: 5, maxTime: 6),
           ProductTableItem(withTitle: "Cavolfiori a mazzetti", minTime: 4, maxTime: 5),
           ProductTableItem(withTitle: "Cavolfiori interi", minTime: 8, maxTime: 12),
           ProductTableItem(withTitle: "Cavolini di Bruxelles", minTime: 4, maxTime: 5),
           ProductTableItem(withTitle: "Cavolo", minTime: 6, maxTime: 8),
           ProductTableItem(withTitle: "Cipolline", minTime: 5, maxTime: 6),
           ProductTableItem(withTitle: "Cipolle", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Coste", minTime: 6, maxTime: 8),
           ProductTableItem(withTitle: "Fagioli freschi", minTime: 15, maxTime: 18),
           ProductTableItem(withTitle: "Fagiolini verdi", minTime: 4, maxTime: 5),
           ProductTableItem(withTitle: "Melanzane a pezzi", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Patate a pezzi", minTime: 5, maxTime: 6),
           ProductTableItem(withTitle: "Patate intere", minTime: 10, maxTime:15 ),
           ProductTableItem(withTitle: "Patate novelle", minTime: 6, maxTime: 8),
           ProductTableItem(withTitle: "Peperoni a fette", minTime: 15),
           ProductTableItem(withTitle: "Piselli", minTime: 2, maxTime: 5),
           ProductTableItem(withTitle: "Pomodiri a pezzi", minTime: 3, maxTime: 5),
           ProductTableItem(withTitle: "Porri", minTime: 4, maxTime: 6),
           ProductTableItem(withTitle: "Rape a pezzi", minTime: 8, maxTime: 10),
           ProductTableItem(withTitle: "Rape intere", minTime: 10, maxTime: 15),
           ProductTableItem(withTitle: "Sedano a pezzi", minTime: 6, maxTime: 8),
           ProductTableItem(withTitle: "Spinaci", minTime: 3, maxTime: 4),
           ProductTableItem(withTitle: "Verza a pezzi", minTime: 5, maxTime: 8),
           ProductTableItem(withTitle: "Zucca a pezzi", minTime: 4, maxTime: 5),
           ProductTableItem(withTitle: "Zucchini", minTime: 2, maxTime: 3),
        ]

        //filtered data starts with all data
        filteredData = originalData
    }

    //returns the available categories, no matter if user has already serached for something or not
    public func getSections() -> [String] {
        return filteredData.keys.sorted()
    }

    //returns the data, we do matter if the user is searching for something or not
    public func getData(_ searchString: String) -> [String : [ProductTableItem]] {
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
