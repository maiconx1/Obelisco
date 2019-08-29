//
//  ViewModelFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class ViewModelFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL, tela: Int) {
		super.init()
		let nomePagina = funcionalidade.paginas[tela].nome
		
		fileName = "\(nomePagina)ViewModel.cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		
		var campos = ""
		var atribuicoes = ""
		for campo in funcionalidade.paginas[tela].camposSaidaCar {
			campos += "\(Campo.replacingOccurrences(of: "NOMEMAIUSCULO", with: campo.nome.capitalizingFirstLetter()).replacingOccurrences(of: "NOME", with: campo.nome.lowerFirstLetter()).replacingOccurrences(of: "TIPO", with: campo.tipo))\n"
			atribuicoes += "\(Atribuicao.replacingOccurrences(of: "NOMEMAIUSCULO", with: campo.nome.capitalizingFirstLetter()))\n"
		}
		
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, tela: tela, campoCar: campos, campoExe: atribuicoes)
	}
	
	let Caminho = "/ViewModels"
	
	let Campo =
	"""
		private TIPO _NOME;
		public TIPO NOMEMAIUSCULO
		{
			get { return _NOME; }
			set { SetProperty(ref _NOME, value); }
		}
"""
	
	let Atribuicao =
	"""
			NOMEMAIUSCULO = retorno.NOMEMAIUSCULO;
"""
	
	let Base =
"""
using MB.Fachada.IBK.Estruturas.CopyFuncionalidade;
using Mercantil.MobileBank.Constants;
using Mercantil.MobileBank.ExtensionMethods;
using Mercantil.MobileBank.Handlers.Contracts;
using Mercantil.MobileBank.Services;
using Mercantil.MobileBank.ViewModels.Base;
using Prism.Commands;
using Prism.Events;
using Prism.Navigation;

namespace Mercantil.MobileBank.ViewModels
{
	public class CopyPaginaViewModel : ViewModelBase
	{
		private ICopyFuncionalidadeHandler _iCopyFuncionalidadeHandler;

CAMPOCAR

		public DelegateCommand ContinueCommand { get; private set; }

		public CopyPaginaViewModel(INavigationService navigationService,
			IEventAggregator eventAggregator,
			IInstanceParameters instanceParameters,
			ICopyFuncionalidadeHandler iCopyFuncionalidadeHandler) : base(navigationService, eventAggregator, instanceParameters)
		{
			_iCopyFuncionalidadeHandler = iCopyFuncionalidadeHandler;
			ContinueCommand = new DelegateCommand(ContinueTapped);
		}

		public async override void OnNavigatingTo(INavigationParameters parameters)
		{
			if (parameters.ContainsKeyAndNotNull(ViewNames.COPY))
			{
				var retorno = (RetCarCopyPaginaCurto)parameters[ViewNames.COPY];
CAMPOEXE
			}
		}

		private async void ContinueTapped()
		{
			await ExecuteFunctionSafelyWithLoading(async () =>
			{
				await _iCopyFuncionalidadeHandler.ExeCopyPagina(navigationService, false);
			});
		}
	}
}
"""
}

extension String {
	func lowerFirstLetter() -> String {
		return prefix(1).lowercased() + self.dropFirst()
	}
	
	mutating func lowerFirstLetter() {
		self = self.lowerFirstLetter()
	}
	
	func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + self.dropFirst()
	}
	
	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
