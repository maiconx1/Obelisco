//
//  JsonFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa
import Foundation

class JsonFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL) {
		super.init()
		let nomeFuncionalidade = funcionalidade.nome
		
		fileName = "\(nomeFuncionalidade).atm"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)\(nomeFuncionalidade)")
		
		let encoder = JSONEncoder()
		do {
			let stream = try encoder.encode(funcionalidade)
			
			if let t = String(bytes: stream, encoding: .utf8) {
				text = t
				print("STREAM = \(text)")
			} else {
				dir = nil
			}
		} catch let error {
			print(error)
			dir = nil
		}
	}
	
	let Caminho = "/Export/"
}
