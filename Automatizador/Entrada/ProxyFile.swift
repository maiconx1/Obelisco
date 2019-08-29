//
//  ProxyFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class ProxyFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL) {
		super.init()
		let nomeFuncionalidadeCurto = funcionalidade.nomeCurto
		
		var metodo = ""
		for i in 0..<funcionalidade.paginas.count {
			let assCar = Constants.substituiTexto(base: assinaturaCar, funcionalidade: funcionalidade, tela: i)
			let assExe = Constants.substituiTexto(base: assinaturaExe, funcionalidade: funcionalidade, tela: i)
			metodo +=
			"""
			public async \(assCar)
			{
			return await \(Constants.substituiTexto(base: postCar, funcionalidade: funcionalidade, tela: i));
			}\n
			"""
			metodo +=
			"""
			public async \(assExe)
			{
			return await \(Constants.substituiTexto(base: postExe, funcionalidade: funcionalidade, tela: i));
			}\n
			"""
		}
		
		fileName = "\(nomeFuncionalidadeCurto).cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, metodo: metodo)
	}
	
	let Caminho = "/Proxy"
	
	let Base =
	"""
using System.Threading.Tasks;
using MB.Fachada.IBK.Estruturas.CopyFuncionalidade;
using Mercantil.MobileBank.Proxy.Contracts;
using Mercantil.MobileBank.Services;
using Prism.Events;

namespace Mercantil.MobileBank.Proxy
{
	public class CopyFuncionalidadeCurto: MBProxyBase, ICopyFuncionalidadeCurto
	{
		public CopyFuncionalidadeCurto(IEventAggregator eventAggregator,
			IInstanceParameters instanceparameter) : base("CopyFuncionalidadeCurto/", eventAggregator, instanceparameter)
		{
		}

METODO
	}
}
"""
	
	let assinaturaCar = "Task<RetCarCopyPaginaCurto> CarCopyPaginaCurto(EntCarCopyPaginaCurto entrada)"
	let assinaturaExe = "Task<RetExeCopyPaginaCurto> ExeCopyPaginaCurto(EntExeCopyPaginaCurto entrada)"
	
	let postCar = "Post<RetCarCopyPaginaCurto, EntCarCopyPaginaCurto>(\"CarCopyPaginaCurto\", entrada)"
	let postExe = "Post<RetExeCopyPaginaCurto, EntExeCopyPaginaCurto>(\"ExeCopyPaginaCurto\", entrada)"
}
