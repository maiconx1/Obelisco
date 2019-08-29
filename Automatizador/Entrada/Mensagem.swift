//
//  Mensagem.swift
//  Automatizador
//
//  Created by Maicon Castro on 14/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class MensagemFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL, mensagens: String) {
		super.init()
		let nomeFuncionalidade = funcionalidade.nomePortugues
		fileName = "Mensagens_\(nomeFuncionalidade).txt"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: nomeFuncionalidade))\(Caminho)")
		
		text = mensagens
	}
	
	let Caminho = ""
}
