//
//  Funcionalidade.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

class Funcionalidade : Encodable {
	
	init(nome: String, nomeCurto: String, nomePortugues: String, paginas: [Pagina]) {
		self.nome = nome
		self.nomeCurto = nomeCurto
		self.nomePortugues = nomePortugues
		self.paginas = paginas
	}
	
	var nome: String
	var nomeCurto: String
	var nomePortugues: String
	var paginas: [Pagina]
	
	enum CodingKeys: String, CodingKey {
		case nome
		case nomeCurto
		case nomePortugues
		case paginas
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.nome, forKey: .nome)
		try container.encode(self.nomeCurto, forKey: .nomeCurto)
		try container.encode(self.nomePortugues, forKey: .nomePortugues)
		try container.encode(self.paginas, forKey: .paginas)
	}
}
