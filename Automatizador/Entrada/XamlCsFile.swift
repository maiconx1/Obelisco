//
//  XamlCsFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class XamlCsFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL, tela: Int) {
		super.init()
		let nomeFuncionalidade = funcionalidade.nome
		let nomePagina = funcionalidade.paginas[tela].nome
		
		fileName = "\(nomePagina).xaml.cs"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)\(nomeFuncionalidade)")
		
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, tela: tela)
	}
	
	let Caminho = "/Views/"
	
	let Base =
	"""
using Mercantil.MobileBank.Views.BaseContents;
using Prism.Events;
using Xamarin.Forms;

namespace Mercantil.MobileBank.Views
{
	public partial class CopyPagina : BaseContentPage
	{
		public CopyPagina(IEventAggregator eventAggregator) : base(eventAggregator)
		{
			InitializeComponent();
		}

		protected override void OnParentSet()
		{
			base.OnParentSet();
			this.Parent?.SetValue(NavigationPage.BarBackgroundColorProperty, Color.FromRgb(2, 46, 123));
			this.Parent?.SetValue(NavigationPage.BarTextColorProperty, Color.White);
		}
	}
}
"""
}
