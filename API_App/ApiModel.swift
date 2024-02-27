//
//  ApiModel.swift
//  Api_App
//
//  Created by Daniel Gonzalez on 20/02/24.
//

import Foundation
// la api utilizada es https://dog.ceo/api/breeds/list/all
// se puede importar la estructura de datos de una herramienta (https://app.quicktype.io/?l=swift#), se copia el json y te devuelve el modelo.

// MARK: - Welcome
struct Welcome: Codable {
    let message: [String]
}

typealias listOfDogs = [Welcome] //Es una forma de renombrar un elemento
