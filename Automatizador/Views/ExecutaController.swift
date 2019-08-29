//
//  ExecutaController.swift
//  Automatizador
//
//  Created by Maicon Castro on 26/07/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa
import ApplicationServices
import Foundation

class ExecutaController: NSViewController {
	
	var numTelas = 0
	var primeiro = true
	var diretorio: URL? = nil
	
	
	@IBOutlet weak var txtNome: NSTextField!
	@IBOutlet weak var txtCurto: NSTextField!
	@IBOutlet weak var txtUrl: NSTextField!
	@IBOutlet weak var txtPortugues: NSTextField!
	
	
	var arrNome : [NSTextField?] = []
	var arrCurto : [NSTextField?] = []
	var assinaturaInterface : [String] = []
	@IBOutlet weak var paginasTable: NSTableView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		paginasTable.delegate = self
		paginasTable.dataSource = self
		
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func addPagina(_ sender: Any) {
		if txtNome.stringValue == "" {
			dialog("Insira o nome da funcionalidade!")
			return
		}
		numTelas += 1
		paginasTable.reloadData()
	}
	
	@IBAction func remPagina(_ sender: NSButton) {
		let row = paginasTable.selectedRow
		if row >= 0 {
			arrNome.remove(at: row)
			arrCurto.remove(at: row)
			numTelas -= 1
			paginasTable.reloadData()
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	func dialog(_ text: String) {
		let alert = NSAlert()
		alert.messageText = text
		alert.alertStyle = .warning
		alert.addButton(withTitle: "OK")
		alert.runModal()
	}
	
	@IBAction func editParams(_ sender: Any) {
		let row = paginasTable.selectedRow
		if row >= 0 {
			if Singleton.getInstance()?.funcionalidade == nil {
				criaFuncionalidade()
			} else {
				for i in (Singleton.getInstance()?.funcionalidade?.paginas.count ?? 0)..<numTelas {
					Singleton.getInstance()?.funcionalidade?.paginas.append(Pagina(nome: arrNome[i]?.stringValue ?? "", nomeCurto: arrCurto[i]?.stringValue ?? "", camposEntradaCar: [], camposSaidaCar: [], camposEntradaExe: [], camposSaidaExe: []))
				}
			}
			performSegue(withIdentifier: "showParametro", sender: Parametro(true, true))
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	@IBAction func editParamsSaida(_ sender: NSButton) {
		let row = paginasTable.selectedRow
		if row >= 0 {
			if Singleton.getInstance()?.funcionalidade == nil {
				criaFuncionalidade()
			} else {
				for i in (Singleton.getInstance()?.funcionalidade?.paginas.count ?? 0)..<numTelas {
					Singleton.getInstance()?.funcionalidade?.paginas.append(Pagina(nome: arrNome[i]?.stringValue ?? "", nomeCurto: arrCurto[i]?.stringValue ?? "", camposEntradaCar: [], camposSaidaCar: [], camposEntradaExe: [], camposSaidaExe: []))
				}
			}
			performSegue(withIdentifier: "showParametro", sender: Parametro(false, true))
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	@IBAction func editParamsExe(_ sender: Any) {
		let row = paginasTable.selectedRow
		if row >= 0 {
			if Singleton.getInstance()?.funcionalidade == nil {
				criaFuncionalidade()
			} else {
				for i in (Singleton.getInstance()?.funcionalidade?.paginas.count ?? 0)..<numTelas {
					Singleton.getInstance()?.funcionalidade?.paginas.append(Pagina(nome: arrNome[i]?.stringValue ?? "", nomeCurto: arrCurto[i]?.stringValue ?? "", camposEntradaCar: [], camposSaidaCar: [], camposEntradaExe: [], camposSaidaExe: []))
				}
			}
			performSegue(withIdentifier: "showParametro", sender: Parametro(true, false))
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	@IBAction func editParamsSaidaExe(_ sender: NSButton) {
		let row = paginasTable.selectedRow
		if row >= 0 {
			if Singleton.getInstance()?.funcionalidade == nil {
				criaFuncionalidade()
			} else {
				for i in (Singleton.getInstance()?.funcionalidade?.paginas.count ?? 0)..<numTelas {
					Singleton.getInstance()?.funcionalidade?.paginas.append(Pagina(nome: arrNome[i]?.stringValue ?? "", nomeCurto: arrCurto[i]?.stringValue ?? "", camposEntradaCar: [], camposSaidaCar: [], camposEntradaExe: [], camposSaidaExe: []))
				}
			}
			performSegue(withIdentifier: "showParametro", sender: Parametro(false, false))
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
		if let vc = segue.destinationController as? ParametroController, let param = sender as? Parametro {
			vc.entrada = param.entrada
			vc.carrega = param.carrega
			vc.numTela = paginasTable.selectedRow
		}
	}
	
	func criaFuncionalidade() {
		var paginas = [Pagina]()
		for i in 0..<numTelas {
			paginas.append(Pagina(nome: arrNome[i]?.stringValue ?? "", nomeCurto: arrCurto[i]?.stringValue ?? "", camposEntradaCar: [], camposSaidaCar: [], camposEntradaExe: [], camposSaidaExe: []))
		}
		let funcionalidade = Funcionalidade(nome: txtNome.stringValue, nomeCurto: txtCurto.stringValue, nomePortugues: txtPortugues.stringValue, paginas: paginas)
		Singleton.getInstance()?.funcionalidade = funcionalidade
	}
	
	@IBAction func automatizaTapped(_ sender: NSButton) {
		if Singleton.getInstance()?.funcionalidade == nil {
			criaFuncionalidade()
		} else {
			Singleton.getInstance()?.funcionalidade?.nome = txtNome.stringValue
			Singleton.getInstance()?.funcionalidade?.nomeCurto = txtCurto.stringValue
			
			for i in 0..<numTelas {
				Singleton.getInstance()?.funcionalidade?.paginas[i].nome = arrNome[i]?.stringValue ?? ""
				Singleton.getInstance()?.funcionalidade?.paginas[i].nomeCurto = arrCurto[i]?.stringValue ?? ""
			}
		}
		if let funcionalidade = Singleton.getInstance()?.funcionalidade {
		
			if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
				do {
					var viewModel: [ViewModelFile] = []
					var xaml: [XamlFile] = []
					var xamlCs: [XamlCsFile] = []
					var entradaCar: [EntradaCarFile] = []
					var entradaExe: [EntradaExeFile] = []
					var retornoCar: [RetornoCarFile] = []
					var retornoExe: [RetornoExeFile] = []
					var mensagens = ""
					
					for i in 0..<numTelas {
						viewModel.append(ViewModelFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						xaml.append(XamlFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						xamlCs.append(XamlCsFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						entradaCar.append(EntradaCarFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						entradaExe.append(EntradaExeFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						retornoCar.append(RetornoCarFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						retornoExe.append(RetornoExeFile(funcionalidade: funcionalidade, diretorio: dir, tela: i))
						mensagens += pegaMensagens(funcionalidade: funcionalidade, tela: i)
					}
					
					let iProxy = IProxyFile(funcionalidade: funcionalidade, diretorio: dir)
					let proxy = ProxyFile(funcionalidade: funcionalidade, diretorio: dir)
					let iHandler = IHandlerFile(funcionalidade: funcionalidade, diretorio: dir)
					let handler = HandlerFile(funcionalidade: funcionalidade, diretorio: dir)
					let json = JsonFile(funcionalidade: funcionalidade, diretorio: dir)
					let mensagem = MensagemFile(funcionalidade: funcionalidade, diretorio: dir, mensagens: mensagens)
					
					var arquivos: [FileBase] = []
					arquivos.append(contentsOf: viewModel)
					arquivos.append(contentsOf: xaml)
					arquivos.append(contentsOf: xamlCs)
					arquivos.append(contentsOf: entradaCar)
					arquivos.append(contentsOf: entradaExe)
					arquivos.append(contentsOf: retornoCar)
					arquivos.append(contentsOf: retornoExe)
					arquivos.append(mensagem)
					arquivos.append(iProxy)
					arquivos.append(proxy)
					arquivos.append(iHandler)
					arquivos.append(handler)
					arquivos.append(json)
					
					salvaArquivos(arquivos: arquivos)
					
					diretorio = dir.appendingPathComponent("Automatizador/Saida/\(txtNome.stringValue)")
					
					if txtUrl.stringValue == "" {
						txtUrl.stringValue = "\(dir)"
					} else {
						if let d = diretorio {
							SendEmail.send(nome: txtNome.stringValue, diretorio: d)
						}
					}
					
					dialog("Automatização concluída com sucesso!\nPróximos passos: Adicionar páginas no App.xaml.cs, Adicionar PassoAcesso")
				}
				catch let error as NSError {
					print("\(error)")
					dialog("ERRO AO AUTOMATIZAR: \(error)")
				}
				catch {
					dialog("ERRO AO AUTOMATIZAR")
				}
			}
		}
	}
	
	func salvaArquivos(arquivos: [FileBase]) {
		
		do {
			for arquivo in arquivos {
				if let d = arquivo.dir {
					try FileManager.default.createDirectory(at: d, withIntermediateDirectories: true)
					let fileUrl = (d.appendingPathComponent(arquivo.fileName))
					secureWrite(fileUrl, arquivo.text)
				}
			}
		} catch let error {
			print(error)
		}
	}
	
	func pegaMensagens(funcionalidade: Funcionalidade, tela: Int) -> String {
		var mensagens = ""
		for campo in funcionalidade.paginas[tela].camposSaidaCar {
			mensagens += "\"\(campo.mensagem)\"\n"
		}
		for campo in funcionalidade.paginas[tela].camposEntradaCar {
			mensagens += "\"\(campo.mensagem)\"\n"
		}
		for campo in funcionalidade.paginas[tela].camposSaidaExe {
			mensagens += "\"\(campo.mensagem)\"\n"
		}
		for campo in funcionalidade.paginas[tela].camposEntradaExe {
			mensagens += "\"\(campo.mensagem)\"\n"
		}
		return mensagens
	}
	
	func secureWrite(_ to: URL, _ text: String) -> Bool {
		do {
			if FileManager.default.fileExists(atPath: to.path) {
				try FileManager.default.removeItem(at: to)
			}
			try text.write(to: to, atomically: false, encoding: .utf8)
		} catch let error {
			print("Cannot write item at \(to): \(error)")
			return false
		}
		return true
	}
	
	func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
		do {
			if FileManager.default.fileExists(atPath: dstURL.path) {
				try FileManager.default.removeItem(at: dstURL)
			}
			try FileManager.default.copyItem(at: srcURL, to: dstURL)
		} catch (let error) {
			print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
			return false
		}
		return true
	}
}

extension ExecutaController : NSTableViewDataSource {
	func numberOfRows(in tableView: NSTableView) -> Int {
		return numTelas
	}
}

extension ExecutaController: NSTableViewDelegate {
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
		let column = tableView.tableColumns.firstIndex(of: tableColumn!)!
		var texto = "\(txtNome?.stringValue ?? "")[NOME_PAGINA]Page"
		switch column {
		case 0:
			if(row < arrNome.count) {
				cell?.textField?.stringValue = "\(arrNome[row]?.stringValue ?? "")"
			}
			else {
				arrNome.append(cell?.textField ?? nil)
				cell?.textField?.stringValue = "\(txtNome?.stringValue ?? "")[NOME_PAGINA]Page"
			}
		case 1:
			if(row < arrCurto.count) {
				cell?.textField?.stringValue = "\(arrCurto[row]?.stringValue ?? "")"
			} else {
				arrCurto.append(cell?.textField ?? nil)
				cell?.textField?.stringValue = ""
			}
		default:
			break
		}
		return cell
	}
}

class Parametro {
	var entrada = true
	var carrega = true
	
	init(_ entrada: Bool = true,_  carrega: Bool = true) {
		self.entrada = entrada
		self.carrega = carrega
	}
}

class SendEmail: NSObject {
	static func send(nome: String, diretorio: URL) {
		let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
		service.recipients = ["mdcastro@stefanini.com"]
		service.subject = "Automatizador - \(nome)"
		
		service.perform(withItems: ["O Código gerado automaticamente está em anexo.\n\nPróximos passos: Adicionar páginas no App.xaml.cs, Adicionar PassoAcesso", diretorio])
	}
}
