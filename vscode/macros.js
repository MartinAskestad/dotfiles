const vscode = require("vscode");

/**
 * Macro configuration settings
 * { [name: string]: {              ... Name of the macro
 *    no: number,                   ... Order of the macro
 *    func: ()=> string | undefined ... Name of the body of the macro function
 *  }
 * }
 */
module.exports.macroCommands = {
  AngularSwitchTemplate: {
    no: 0,
    func: angularSwitchTemplate,
  },
  AngularSwitchTypescript: {
    no: 1,
    func: angularSwitchTypescript,
  },
  AngularSwitchStyleSheet: {
    no: 2,
    func: angularSwitchStyleSheet,
  },
};

function getFileNameWithoutExtension(fileName) {
  return fileName.substring(
    fileName.lastIndexOf("/") + 1,
    fileName.lastIndexOf(".")
  );
}

async function angularSwitchTemplate() {
  const { activeTextEditor } = vscode.window;
  if (!activeTextEditor) {
    // Return an error message if necessary.
    return "Editor is not opening.";
  }
  const { fileName } = activeTextEditor.document;
  const fileNameWithoutExtension = getFileNameWithoutExtension(fileName);
  const newFileName = `${fileNameWithoutExtension}.html`;
  const textEditor = vscode.window.visibleTextEditors.find(
    (textDocument) => textDocument.document.fileName === newFileName
  );
  if (textEditor) {
    await vscode.window.showTextDocument(
      textEditor.document,
      textEditor.viewColumn
    );
    return;
  }
  const document = vscode.workspace.openTextDocument(newFileName);
  if (document) {
    await vscode.window.showTextDocument(document);
  }
}

async function angularSwitchTypescript() {
  const { activeTextEditor } = vscode.window;
  if (!activeTextEditor) {
    // Return an error message if necessary.
    return "Editor is not opening.";
  }
  const { fileName } = activeTextEditor.document;
  const fileNameWithoutExtension = getFileNameWithoutExtension(fileName);
  const newFileName = `${fileNameWithoutExtension}.ts`;
  const textEditor = vscode.window.visibleTextEditors.find(
    (textDocument) => textDocument.document.fileName === newFileName
  );
  if (textEditor) {
    await vscode.window.showTextDocument(
      textEditor.document,
      textEditor.viewColumn
    );
    return;
  }
  const document = vscode.workspace.openTextDocument(newFileName);
  if (document) {
    await vscode.window.showTextDocument(document);
  }
}

async function angularSwitchStyleSheet() {
  const { activeTextEditor } = vscode.window;
  if (!activeTextEditor) {
    // Return an error message if necessary.
    return "Editor is not opening.";
  }
  const { fileName } = activeTextEditor.document;
  const fileNameWithoutExtension = getFileNameWithoutExtension(fileName);
  const newFileName = `${fileNameWithoutExtension}.scss`;
  const textEditor = vscode.window.visibleTextEditors.find(
    (textDocument) => textDocument.document.fileName === newFileName
  );
  if (textEditor) {
    await vscode.window.showTextDocument(
      textEditor.document,
      textEditor.viewColumn
    );
    return;
  }
  const document = vscode.workspace.openTextDocument(newFileName);
  if (document) {
    await vscode.window.showTextDocument(document);
  }
}
