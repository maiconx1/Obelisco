//
//  Singleton.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

class Singleton {
	private static var instance: Singleton? = nil
	var funcionalidade: Funcionalidade? = nil
	
	private init() {
		//funcionalidade = Funcionalidade(nome: "", nomeCurto: "", paginas: [])
	}
	
	static func getInstance() -> Singleton? {
		if instance == nil {
			instance = Singleton()
		}
		return instance
	}
}
