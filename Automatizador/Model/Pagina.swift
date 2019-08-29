//
//  Pagina.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

class Pagina : Encodable {
	var nome: String = ""
	var nomeCurto: String = ""
	var camposEntradaCar: [Tipo] = []
	var camposSaidaCar: [Tipo] = []
	var camposEntradaExe: [Tipo] = []
	var camposSaidaExe: [Tipo] = []
	
	init(nome: String, nomeCurto: String, camposEntradaCar: [Tipo] = [], camposSaidaCar: [Tipo] = [], camposEntradaExe: [Tipo] = [], camposSaidaExe: [Tipo] = []) {
		self.nome = nome
		self.nomeCurto = nomeCurto
		self.camposEntradaCar = camposEntradaCar
		self.camposSaidaCar = camposSaidaCar
		self.camposEntradaExe = camposEntradaExe
		self.camposSaidaExe = camposSaidaExe
	}
	
	enum CodingKeys: String, CodingKey {
		case nome
		case nomeCurto
		case camposEntradaCar
		case camposSaidaCar
		case camposEntradaExe
		case camposSaidaExe
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.nome, forKey: .nome)
		try container.encode(self.nomeCurto, forKey: .nomeCurto)
		try container.encode(self.camposEntradaCar, forKey: .camposEntradaCar)
		try container.encode(self.camposSaidaCar, forKey: .camposSaidaCar)
		try container.encode(self.camposEntradaExe, forKey: .camposEntradaExe)
		try container.encode(self.camposSaidaExe, forKey: .camposSaidaExe)
	}
}
