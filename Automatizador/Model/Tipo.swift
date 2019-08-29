//
//  Tipo.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

class Tipo : Encodable {
	var tipo: String = "string"
	var nome: String = ""
	var mensagem: String = ""
	
	init(_ tipo: String, _ nome: String, _ mensagem: String = "") {
		self.tipo = tipo
		self.nome = nome
		self.mensagem = mensagem
	}
	
	enum CodingKeys: String, CodingKey {
		case nome
		case tipo
		case mensagem
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.nome, forKey: .nome)
		try container.encode(self.tipo, forKey: .tipo)
		try container.encode(self.mensagem, forKey: .mensagem)
	}
}
