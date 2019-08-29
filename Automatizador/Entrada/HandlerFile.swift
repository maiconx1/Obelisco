//
//  HandlerFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class HandlerFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL) {
		super.init()
		let nomeFuncionalidadeCurto = funcionalidade.nomeCurto
		let nomeFuncionalidade = funcionalidade.nome
		
		var metodos = ""
		var cases = ""
		for i in 0..<funcionalidade.paginas.count {
			let met = Constants.substituiTexto(base: metodosHandler, funcionalidade: funcionalidade, tela: i)
			metodos += "\(met)\n"
			let cas = Constants.substituiTexto(base: caseHandler, funcionalidade: funcionalidade, tela: i)
			cases += "\(cas)\n"
		}
		
		fileName = "\(nomeFuncionalidade)Handler.cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)")
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, metodo: metodos, cases: cases)
	}
	
	let Caminho = "/Handlers"
	
	let Base =
	"""
using System;
using System.Threading.Tasks;
using MB.Fachada.IBK.Estruturas.CopyFuncionalidade;
using Mercantil.MobileBank.Constants;
using Mercantil.MobileBank.ExtensionMethods;
using Mercantil.MobileBank.Handlers.Contracts;
using Mercantil.MobileBank.Proxy.Contracts;
using Mercantil.MobileBank.Services;
using Mercantil.MobileBank.Services.Interface;
using Mercantil.MobileBank.ViewModels.MBEstructureExtension;
using Prism.Events;
using Prism.Navigation;
using Xamarin.Forms;
using static Mercantil.MobileBank.Proxy.Constantes.Constantes;

namespace Mercantil.MobileBank.Handlers
{
	public class CopyFuncionalidadeHandler : BaseHandler, ICopyFuncionalidadeHandler
	{
		private readonly ICopyFuncionalidadeCurto _CopyFuncionalidadeCurto;

		public CopyFuncionalidadeHandler(IInstanceParameters instanceParameters, IEventAggregator eventAggregator,
			IPermissionService permissionService, ICopyFuncionalidadeCurto CopyFuncionalidadeCurto) : base(instanceParameters, eventAggregator, permissionService)
		{
			_CopyFuncionalidadeCurto = CopyFuncionalidadeCurto;
		}

METODO

		public override async Task LoadStep(PassoAcesso step, INavigationService navigationService, object parameter = null, bool isRoot = false, string path = null)
		{
			switch (step.GetPageName())
			{
CASE
			}
		}
	}
}
"""
	
	let metodosHandler = """
		public async Task LoadCopyPagina(INavigationService navigationService, bool fromMaster = false)
		{
			string returnErrorPath = Device.Idiom == TargetIdiom.Phone ? string.Empty : ViewNames.DASHBOARD_DETAIL;
			RetCarCopyPaginaCurto retornoFachada = new RetCarCopyPaginaCurto();

			await ExecuteFunctionSafelyAsync(async () =>
			{
				var entrada = new EntCarCopyPaginaCurto
				{
					CodigoOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodOpcao),
					CodigoSubOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodSubOpcao),
					DescricaoOpcaoIBK = instanceParameters.SelectdMenuOption.Descricao,
				};

				retornoFachada = await _CopyFuncionalidadeCurto.CarCopyPaginaCurto(entrada);
				await ExecutarRespostaServicoAsync(retornoFachada, async () =>
				{
					NavigationParameters p = new NavigationParameters
					{
						{ ViewNames.COPY, retornoFachada }
					};
					await NavigateToPage(navigationService, ViewNames.COPY, fromMaster, p);
				}, navigationService, returnErrorPath, fromMaster);
			}, navigationService, returnErrorPath, fromMaster);
		}

		public async Task ExeCopyPagina(INavigationService navigationService, bool fromMaster = false)
		{
			await ExecuteFunctionSafelyAsync(async () =>
			{
				var entradaProduto = new EntExeCopyPaginaCurto
				{
					CodigoOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodOpcao),
					CodigoSubOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodSubOpcao),
					DescricaoOpcaoIBK = instanceParameters.SelectdMenuOption.Descricao,
				};

				var retornoFachada = await _CopyFuncionalidadeCurto.ExeCopyPaginaCurto(entradaProduto);
				await ExecutarRespostaServicoAsync(retornoFachada, async () =>
				{
					await LoadStep(retornoFachada.ProximoPasso, navigationService);
				}, navigationService, fromMaster: fromMaster);
			}, navigationService, fromMaster: fromMaster);
		}
"""
	
	let caseHandler = """
				case ViewNames.COPY:
					await LoadCopyPagina(navigationService, isRoot);
					break;
	"""
}
