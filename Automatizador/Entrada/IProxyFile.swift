//
//  IProxyFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class IProxyFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL) {
		super.init()
		let nomeFuncionalidadeCurto = funcionalidade.nomeCurto
		
		var assinatura = ""
		for i in 0..<funcionalidade.paginas.count {
			let assCar = Constants.substituiTexto(base: assinaturaCar, funcionalidade: funcionalidade, tela: i)
			let assExe = Constants.substituiTexto(base: assinaturaExe, funcionalidade: funcionalidade, tela: i)
			assinatura += "\t\t\(assCar);\n"
			assinatura += "\t\t\(assExe);\n"
		}
		
		fileName = "I\(nomeFuncionalidadeCurto).cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, assinatura: assinatura)
	}
	
	let Caminho = "/Proxy/Contracts"
	
	let Base =
	"""
using System.Threading.Tasks;
using MB.Fachada.IBK.Estruturas.CopyFuncionalidade;

namespace Mercantil.MobileBank.Proxy.Contracts
{
	public interface ICopyFuncionalidadeCurto
	{
ASSINATURA
	}
}
"""
	
	let assinaturaCar = "Task<RetCarCopyPaginaCurto> CarCopyPaginaCurto(EntCarCopyPaginaCurto entrada)"
	let assinaturaExe = "Task<RetExeCopyPaginaCurto> ExeCopyPaginaCurto(EntExeCopyPaginaCurto entrada)"
}
