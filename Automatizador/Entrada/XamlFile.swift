//
//  XamlFile.swift
//  Automatizador
//
//  Created by Maicon Castro on 01/08/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class XamlFile : FileBase {
	
	init(funcionalidade: Funcionalidade, diretorio: URL, tela: Int) {
		super.init()
		let nomeFuncionalidade = funcionalidade.nome
		let nomePagina = funcionalidade.paginas[tela].nome
		
		fileName = "\(nomePagina).xaml"
		dir = diretorio.appendingPathComponent("\(Constants.urlBase(nomeFuncionalidade: funcionalidade.nome))\(Caminho)\(nomeFuncionalidade)")
		
		text = Constants.substituiTexto(base: Base, funcionalidade: funcionalidade, tela: tela)
	}
	
	let Caminho = "/Views/"
	
	let Base =
	"""
<?xml version="1.0" encoding="UTF-8"?>
<page:BaseContentPage xmlns="http://xamarin.com/schemas/2014/forms"
					  xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
					  xmlns:xfg="clr-namespace:XFGloss;assembly=XFGloss"
					  xmlns:page="clr-namespace:Mercantil.MobileBank.Views.BaseContents"
					  xmlns:converter="clr-namespace:Mercantil.MobileBank.Views.Converters"
					  xmlns:componentBase="clr-namespace:Mercantil.MobileBank.Components.Base"
					  xmlns:comp="clr-namespace:Mercantil.MobileBank.Components"
					  x:Class="Mercantil.MobileBank.Views.CopyPagina"
					  xmlns:prism="clr-namespace:Prism.Mvvm;assembly=Prism.Forms"
					  prism:ViewModelLocator.AutowireViewModel="True"
					  ControlTemplate="{StaticResource ActivityIndicatorTemplate}"
					  Title="{Binding TituloTela}">
	<xfg:ContentPageGloss.BackgroundGradient>
		<xfg:Gradient Rotation="180">
			<xfg:GradientStep StepColor="#022E7B" StepPercentage="0" />
			<xfg:GradientStep StepColor="#2FB49F" StepPercentage="1" />
		</xfg:Gradient>
	</xfg:ContentPageGloss.BackgroundGradient>
	<page:BaseContentPage.Resources>
		<ResourceDictionary>
			<converter:HtmlStringToFormattedString x:Key="HtmlToFormattedString" />
		</ResourceDictionary>
	</page:BaseContentPage.Resources>
	<ScrollView>
		<StackLayout BackgroundColor="Transparent" Padding="10" Spacing="10">
			<Button Margin="0, 0, 0, 10" HorizontalOptions="FillAndExpand" HeightRequest="48" BackgroundColor="#A8C62A" TextColor="White" Text="{Binding TituloBotaoContinuar}" Command="{Binding ContinueCommand}">
				<Button.FontFamily>
					<OnPlatform x:TypeArguments="x:String" iOS="Roboto-Medium" Android="Roboto-Medium.ttf#Roboto-Medium" />
				</Button.FontFamily>
			</Button>
		</StackLayout>
	</ScrollView>
</page:BaseContentPage>
"""
}
