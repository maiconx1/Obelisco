//
//  EntradaExeFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class EntradaExeFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL, tela: Int) {
		super.init()
		let nomePaginaCurto = funcionalidade.paginas[tela].nomeCurto
		fileName = "EntExe\(nomePaginaCurto).cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		
		var campoSub = ""
		for campo in funcionalidade.paginas[tela].camposEntradaExe {
			campoSub += "\t\tpublic \(campo.tipo) \(campo.nome) { get; set; }\n"
		}
		
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, tela: tela, campoExe: campoSub)
	}
	
	let Caminho = "/Proxy/Estruturas/CopyFuncionalidadePortugues"
	
	let Base =
	"""
namespace MB.Fachada.IBK.Estruturas.CopyFuncionalidadePortugues
{
	public class EntExeCopyPaginaCurto: EstruturaEntradaOpcaoIBK
	{
CAMPOEXE
	}
}
"""
}
