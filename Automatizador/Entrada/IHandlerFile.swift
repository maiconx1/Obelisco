//
//  IHandlerFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class IHandlerFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL) {
		super.init()
		let nomeFuncionalidadeCurto = funcionalidade.nomeCurto
		let nomeFuncionalidade = funcionalidade.nome
		
		var assinatura = ""
		for i in 0..<funcionalidade.paginas.count {
			let ass = Constants.substituiTexto(base: assinaturaHandler, funcionalidade: funcionalidade, tela: i)
			assinatura += "\t\t\(ass)\n"
		}
		
		fileName = "I\(nomeFuncionalidade)Handler.cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, assinatura: assinatura)
	}
	
	let Caminho = "/Handlers/Contracts"
	
	let Base =
	"""
using System.Threading.Tasks;
using MB.Fachada.IBK.Estruturas.CopyFuncionalidade;
using Prism.Navigation;

namespace Mercantil.MobileBank.Proxy.Contracts
{
	public interface ICopyFuncionalidade
	{
ASSINATURA
	}
}
"""
	
	let assinaturaHandler = """
		Task LoadCopyPagina(INavigationService navigationService, bool fromMaster = false);
		Task ExeCopyPagina(INavigationService navigationService, bool fromMaster = false);
	"""
}
