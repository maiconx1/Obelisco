//
//  Constants.swift
//  Automatizador
//
//  Created by User on 29/07/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

class Constants {
	static let XAML = 0, XAML_CS = 1, VIEW_MODEL = 2, ENTRADA_CAR = 3, ENTRADA_EXE = 4, RETORNO_CAR = 5, RETORNO_EXE = 6, INTERFACE_PROXY = 7, PROXY = 8, INTERFACE_HANDLER = 9, HANDLER = 10
	
	static let assinaturaCar = "Task<RetCarCopy> CarCopy(EntCarCopy entrada)"
	static let assinaturaExe = "Task<RetExeCopy> ExeCopy(EntExeCopy entrada)"
	static let postCar = "Post<RetCarCopy, EntCarCopy>(\"CarCopy\", entrada)"
	static let postExe = "Post<RetExeCopy, EntExeCopy>(\"ExeCopy\", entrada)"
	
	static let caseHandler = """
	case ViewNames.COPY:
		await LoadCopyPage(navigationService, isRoot);
		break;
	"""
	
	static let assinaturaHandler = """
	\t\tTask LoadCopyPage(INavigationService navigationService, bool fromMaster = false);
	\t\tTask ExeCopyPage(INavigationService navigationService, bool fromMaster = false);
	"""
	
	static let metodosHandler = """
	public async Task LoadCopyLongoPage(INavigationService navigationService, bool fromMaster = false)
	{
		string returnErrorPath = Device.Idiom == TargetIdiom.Phone ? string.Empty : ViewNames.DASHBOARD_DETAIL;
		RetCarCopyCurto retornoFachada = new RetCarCopyCurto();

		await ExecuteFunctionSafelyAsync(async () =>
		{
			var entrada = new EntCarCopyCurto
			{
				CodigoOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodOpcao),
				CodigoSubOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodSubOpcao),
				DescricaoOpcaoIBK = instanceParameters.SelectdMenuOption.Descricao,
			};

			retornoFachada = await _CopyNomeCurto.CarCopyCurto(entrada);
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

	public async Task ExeCopyLongoPage(INavigationService navigationService, bool fromMaster = false)
	{
		await ExecuteFunctionSafelyAsync(async () =>
		{
			var entradaProduto = new EntExeCopyCurto
			{
				CodigoOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodOpcao),
				CodigoSubOpcaoIBK = Convert.ToInt32(instanceParameters.SelectdMenuOption.CodSubOpcao),
				DescricaoOpcaoIBK = instanceParameters.SelectdMenuOption.Descricao,
			};

			var retornoFachada = await _CopyNomeCurto.ExeCopyCurto(entradaProduto);
			await ExecutarRespostaServicoAsync(retornoFachada, async () =>
			{
				await LoadStep(retornoFachada.ProximoPasso, navigationService);
			}, navigationService, fromMaster: fromMaster);
		}, navigationService, fromMaster: fromMaster);
	}
"""
	
	static let ICopy = """
	using System.Threading.Tasks;
	using MB.Fachada.IBK.Estruturas.Copy;
	
	namespace Mercantil.MobileBank.Proxy.Contracts
	{
		public interface ICopyCurto
		{
			ASSINATURAS
		}
	}
	"""
	static let Copy = """
	using System.Threading.Tasks;
	using MB.Fachada.IBK.Estruturas.Copy;
	using Mercantil.MobileBank.Proxy.Contracts;
	using Mercantil.MobileBank.Services;
	using Prism.Events;

	namespace Mercantil.MobileBank.Proxy
	{
		public class CopyCurto: MBProxyBase, ICopyCurto
		{
			public CopyCurto(IEventAggregator eventAggregator,
				IInstanceParameters instanceparameter) : base("CopyCurto/", eventAggregator, instanceparameter)
			{
			}
			METODOS

		}
	}
"""
	static let ICopyHandler = """
	using System;
	using System.Threading.Tasks;
	using MB.Fachada.IBK.Estruturas.Copy;
	using Mercantil.MobileBank.ViewModels.MBEstructureExtension;
	using Prism.Navigation;

	namespace Mercantil.MobileBank.Handlers.Contracts
	{
		public interface ICopyHandler
		{
			ASSINATURAS
		}
	}
"""
	static let CopyHandler = """
	using System;
	using System.Threading.Tasks;
	using MB.Fachada.IBK.Estruturas.Copy;
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
		public class CopyHandler : BaseHandler, ICopyHandler
		{
			private readonly ICopyCurto _CopyCurto;

			public CopyHandler(IInstanceParameters instanceParameters, IEventAggregator eventAggregator,
				IPermissionService permissionService, ICopyCurto CopyCurto) : base(instanceParameters, eventAggregator, permissionService)
			{
				_CopyCurto = CopyCurto;
			}

			METODOS


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
	static let CopyPageXaml = """
	<?xml version="1.0" encoding="UTF-8"?>
	<page:BaseContentPage xmlns="http://xamarin.com/schemas/2014/forms"
						  xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
						  xmlns:xfg="clr-namespace:XFGloss;assembly=XFGloss"
						  xmlns:page="clr-namespace:Mercantil.MobileBank.Views.BaseContents"
						  xmlns:converter="clr-namespace:Mercantil.MobileBank.Views.Converters"
						  xmlns:componentBase="clr-namespace:Mercantil.MobileBank.Components.Base"
						  xmlns:comp="clr-namespace:Mercantil.MobileBank.Components"
						  x:Class="Mercantil.MobileBank.Views.CopyPage"
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
	static let CopyPageXamlCs = """
	using Mercantil.MobileBank.Views.BaseContents;
	using Prism.Events;
	using Xamarin.Forms;

	namespace Mercantil.MobileBank.Views
	{
		public partial class CopyPage : BaseContentPage
		{
			public CopyPage(IEventAggregator eventAggregator) : base(eventAggregator)
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
	static let CopyPageViewModel = """
	using MB.Fachada.IBK.Estruturas.CopyNome;
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
		public class CopyPageViewModel : ViewModelBase
		{
			private ICopyNomeHandler _iCopyNomeHandler;

			private string _tituloTela;
			public string TituloTela
			{
				get { return _tituloTela; }
				set { SetProperty(ref _tituloTela, value); }
			}

			private string _tituloBotaoContinuar;
			public string TituloBotaoContinuar
			{
				get { return _tituloBotaoContinuar; }
				set { SetProperty(ref _tituloBotaoContinuar, value); }
			}

			public DelegateCommand ContinueCommand { get; private set; }

			public CopyPageViewModel(INavigationService navigationService,
				IEventAggregator eventAggregator,
				IInstanceParameters instanceParameters,
				ICopyNomeHandler iCopyNomeHandler) : base(navigationService, eventAggregator, instanceParameters)
			{
				_iCopyNomeHandler = iCopyNomeHandler;
				ContinueCommand = new DelegateCommand(ContinueTapped);
			}

			public async override void OnNavigatingTo(INavigationParameters parameters)
			{
				if (parameters.ContainsKeyAndNotNull(ViewNames.COPY))
				{
					var retorno = (RetCarCopyCurto)parameters[ViewNames.COPY];
					//TituloTela = retorno.TituloTela;
					TituloTela = "Copy"; //TODO
				}
			}

			private async void ContinueTapped()
			{
				await ExecuteFunctionSafelyWithLoading(async () =>
				{
					await _iCopyNomeHandler.ExeCopyPage(navigationService, false);
				});
			}
		}
	}

"""
	static let EntCarCopy = """
	namespace MB.Fachada.IBK.Estruturas.Copy
	{
		public class EntCarCopyCurto: EstruturaEntradaOpcaoIBK
		{
		}
	}
"""
	static let EntExeCopy = """
	namespace MB.Fachada.IBK.Estruturas.Copy
	{
		public class EntExeCopyCurto: EstruturaEntradaOpcaoIBK
		{
			//public string Parametro { get; set; }
		}
	}
"""
	static let RetCarCopy = """
	namespace MB.Fachada.IBK.Estruturas.Copy
	{
		public class RetCarCopyCurto: EstruturaErro
		{
			public string TituloTela { get; set; }
		}
	}
"""
	static let RetExeCopy = """
	namespace MB.Fachada.IBK.Estruturas.Copy
	{
		public class RetExeCopyCurto: EstruturaErro
		{
		}
	}
"""
	static func substituiTexto(base: String, funcionalidade: Funcionalidade, tela: Int = -1, campoCar: String = "", campoExe: String = "", assinatura: String = "", metodo: String = "", cases: String = "") -> String {
		let nomeFuncionalidadeCurto = funcionalidade.nomeCurto
		let nomeFuncionalidade = funcionalidade.nome
		let nomeFuncionalidadePortugues = funcionalidade.nomePortugues
		var nomePagina = ""
		var nomePaginaCurto = ""
		if tela >= 0 {
			nomePagina = funcionalidade.paginas[tela].nome
			nomePaginaCurto = funcionalidade.paginas[tela].nomeCurto
		}
		return base.replacingOccurrences(of: "CopyPaginaCurto", with: nomePaginaCurto).replacingOccurrences(of: "CopyFuncionalidadeCurto", with: nomeFuncionalidadeCurto).replacingOccurrences(of: "CopyFuncionalidadePortugues", with: nomeFuncionalidadePortugues).replacingOccurrences(of: "CopyFuncionalidade", with: nomeFuncionalidade).replacingOccurrences(of: "CopyPagina", with: nomePagina).replacingOccurrences(of: "COPY", with: Constants.formataMaiusculos(nomePagina)).replacingOccurrences(of: "CAMPOCAR", with: campoCar).replacingOccurrences(of: "CAMPOEXE", with: campoExe).replacingOccurrences(of: "ASSINATURA", with: assinatura).replacingOccurrences(of: "METODO", with: metodo).replacingOccurrences(of: "CASE", with: cases)
	}
	
	static func urlBase(nomeFuncionalidade: String) -> String {
		return "Automatizador/Saida/\(nomeFuncionalidade)"
	}
	
	static func formataMaiusculos(_ texto: String) -> String {
		var retorno = ""
		var maiusculo = true
		for c in texto {
			if c.isUppercase {
				if !maiusculo {
					retorno += "_"
				}
				maiusculo = true
			}
			else {
				maiusculo = false
			}
			retorno += "\(c.uppercased())"
		}
		return retorno
	}
}
