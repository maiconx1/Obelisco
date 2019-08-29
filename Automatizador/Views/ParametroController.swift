//
//  ParametroController.swift
//  Automatizador
//
//  Created by Maicon Castro on 26/07/19.
//  Copyright © 2019 Stefanini. All rights reserved.
//

import Cocoa

class ParametroController: NSViewController {
	var entrada = true
	var carrega = true
	var funcionalidade: Funcionalidade? = nil
	var numTela = 0
	var numParametros = 0
	
	var arrParametrosTipo : [NSTextField?] = []
	var arrParametrosNome : [NSTextField?] = []
	var arrParametrosValor : [NSTextField?] = []
	
	//var strParametrosTipo : [String] = []
	//var strParametrosNome : [String] = []
	
	@IBOutlet weak var txtPagina: NSTextField!
	@IBOutlet weak var parametrosTable: NSTableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var texto = ""
		funcionalidade = Singleton.getInstance()?.funcionalidade
		
		if entrada {
			texto = " (Entrada, "
			if carrega {
				texto += "Carrega)"
				numParametros = funcionalidade?.paginas[numTela].camposEntradaCar.count ?? 0
			} else {
				texto += "Retorna)"
				numParametros = funcionalidade?.paginas[numTela].camposEntradaExe.count ?? 0
			}
		} else {
			texto = " (Saída, "
			if carrega {
				texto += "Carrega)"
				numParametros = funcionalidade?.paginas[numTela].camposSaidaCar.count ?? 0
			} else {
				texto += "Retorna)"
				numParametros = funcionalidade?.paginas[numTela].camposSaidaExe.count ?? 0
			}
		}
		txtPagina.stringValue = "Página: \(funcionalidade?.paginas[numTela].nome ?? "")\(texto)"
		
		parametrosTable.delegate = self
		parametrosTable.dataSource = self
	}
	
	func dialog(_ text: String) {
		let alert = NSAlert()
		alert.messageText = text
		alert.alertStyle = .warning
		alert.addButton(withTitle: "OK")
		alert.runModal()
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func addParam(_ sender: NSButton) {
		numParametros += 1
		if entrada {
			if carrega {
				funcionalidade?.paginas[numTela].camposEntradaCar.append(Tipo("string", ""))
			} else {
				funcionalidade?.paginas[numTela].camposEntradaExe.append(Tipo("string", ""))
			}
		} else {
			if carrega {
				funcionalidade?.paginas[numTela].camposSaidaCar.append(Tipo("string", ""))
			} else {
				funcionalidade?.paginas[numTela].camposSaidaExe.append(Tipo("string", ""))
			}
		}
		parametrosTable.reloadData()
	}
	
	@IBAction func remParam(_ sender: NSButton) {
		let row = parametrosTable.selectedRow
		if row >= 0 {
			arrParametrosTipo.remove(at: row)
			arrParametrosNome.remove(at: row)
			arrParametrosValor.remove(at: row)
			
			if entrada {
				if carrega {
					funcionalidade?.paginas[numTela].camposEntradaCar.remove(at: row)
				} else {
					funcionalidade?.paginas[numTela].camposEntradaExe.remove(at: row)
				}
			} else {
				if carrega {
					funcionalidade?.paginas[numTela].camposSaidaCar.remove(at: row)
				} else {
					funcionalidade?.paginas[numTela].camposSaidaExe.remove(at: row)
				}
			}
			
			numParametros -= 1
			parametrosTable.reloadData()
		} else {
			dialog("Selecione uma linha!")
		}
	}
	
	@IBAction func salvar(_ sender: NSButton) {
		if entrada {
			if carrega {
				funcionalidade?.paginas[numTela].camposEntradaCar.removeAll()
				for i in 0..<numParametros {
					funcionalidade?.paginas[numTela].camposEntradaCar.append(Tipo(arrParametrosTipo[i]?.stringValue ?? "", arrParametrosNome[i]?.stringValue ?? "", arrParametrosValor[i]?.stringValue ?? ""))
				}
			} else {
				funcionalidade?.paginas[numTela].camposEntradaExe.removeAll()
				for i in 0..<numParametros {
					funcionalidade?.paginas[numTela].camposEntradaExe.append(Tipo(arrParametrosTipo[i]?.stringValue ?? "", arrParametrosNome[i]?.stringValue ?? "", arrParametrosValor[i]?.stringValue ?? ""))
				}
			}
		} else {
			if carrega {
				funcionalidade?.paginas[numTela].camposSaidaCar.removeAll()
				for i in 0..<numParametros {
					funcionalidade?.paginas[numTela].camposSaidaCar.append(Tipo(arrParametrosTipo[i]?.stringValue ?? "", arrParametrosNome[i]?.stringValue ?? "", arrParametrosValor[i]?.stringValue ?? ""))
				}
			} else {
				funcionalidade?.paginas[numTela].camposSaidaExe.removeAll()
				for i in 0..<numParametros {
					funcionalidade?.paginas[numTela].camposSaidaExe.append(Tipo(arrParametrosTipo[i]?.stringValue ?? "", arrParametrosNome[i]?.stringValue ?? "", arrParametrosValor[i]?.stringValue ?? ""))
				}
			}
		}
		Singleton.getInstance()?.funcionalidade = funcionalidade
		self.view.window?.close()
	}
}

extension ParametroController : NSTableViewDataSource {
	func numberOfRows(in tableView: NSTableView) -> Int {
		return numParametros
	}
}

extension ParametroController: NSTableViewDelegate {
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
		let column = tableView.tableColumns.firstIndex(of: tableColumn!)!
		switch column {
		case 0:
			if row < arrParametrosTipo.count {
				if let value = arrParametrosTipo[row]?.stringValue {
					cell?.textField?.stringValue = "\(value)"
				}
			}
			else {
				if entrada {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposEntradaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaCar[row].tipo ?? "string"
						} else {
							cell?.textField?.stringValue = "string"
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposEntradaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaExe[row].tipo ?? "string"
						} else {
							cell?.textField?.stringValue = "string"
						}
					}
				} else {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposSaidaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaCar[row].tipo ?? "string"
						} else {
							cell?.textField?.stringValue = "string"
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposSaidaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaExe[row].tipo ?? "string"
						} else {
							cell?.textField?.stringValue = "string"
						}
					}
				}
				arrParametrosTipo.append(cell?.textField ?? nil)
			}
		case 1:
			if(row < arrParametrosNome.count) {
				if let value = arrParametrosNome[row]?.stringValue {
					cell?.textField?.stringValue = "\(value)"
				}
			}
			else {
				if entrada {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposEntradaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaCar[row].nome ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposEntradaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaExe[row].nome ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					}
				} else {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposSaidaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaCar[row].nome ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposSaidaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaExe[row].nome ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					}
				}
				arrParametrosNome.append(cell?.textField ?? nil)
			}
		case 2:
			if(row < arrParametrosValor.count) {
				if let value = arrParametrosValor[row]?.stringValue {
					cell?.textField?.stringValue = "\(value)"
				}
			}
			else {
				if entrada {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposEntradaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaCar[row].mensagem ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposEntradaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposEntradaExe[row].mensagem ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					}
				} else {
					if carrega {
						if row < funcionalidade?.paginas[numTela].camposSaidaCar.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaCar[row].mensagem ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					} else {
						if row < funcionalidade?.paginas[numTela].camposSaidaExe.count ?? 0 {
							cell?.textField?.stringValue = funcionalidade?.paginas[numTela].camposSaidaExe[row].mensagem ?? ""
						} else {
							cell?.textField?.stringValue = ""
						}
					}
				}
				arrParametrosValor.append(cell?.textField ?? nil)
			}
		default:
			break
		}
		return cell
	}
}
