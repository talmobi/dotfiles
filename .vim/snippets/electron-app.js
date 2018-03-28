const _electron = require( 'electron' )
const _ipcMain = _electron.ipcMain

const _fs = require( 'fs' )
const _path = require( 'path' )
const _url = require( 'url' )

const _ipcMain = _electron.ipcMain

_ipcMain.on( 'ready', function ( evt, data ) {
  console.log( 'app is ready!', data )
} )

// Module to control application life
const app = electron.app

// Module to create native browser window
const BrowserWindow = electron.BrowserWindow

function createWindow ()
{
  // Create the browser window
  let mainWindow = new BrowserWindow( {
    show: true,
    width: 800,
    height: 600
  } )

  const session = mainWindow.webContents.session

  session.webRequest.onBeforeRequest(
    [ '*://*./*' ], // all
    function ( details, callback ) {
      var url = details.url
      const shouldBlock =  false
      callback( { cancel: shouldBlock } )
    }
  )

  // mainWindow.webContents.executeJavaScript( 'alert("hello!")')
  // mainWindow.webContents.executeJavaScript( execFunc( 'playVideo' ) )

  mainWindow.on( 'ready-to-show', function () {
    mainWindow.webContents.executeJavaScript(`
      const ipcRenderer = require( 'electron' ).ipcRenderer
      console.log( 'ready!' )
      ipcRenderer.send( 'ready', {
        width: window.innerWidth,
        height: window.innerHeight
      } )
    `)
  } )

  // and load the index.html of the app
  mainWindow.loadURL(
    _url.format( {
      pathname: path.join( __dirname, 'index.html' ),
      protocol: 'file:',
      slashes: true
    } )
  )

  // Open the DevTools
  // mainWindow.webContents.openDevTools()

  // Emitted when the window is closed
  mainWindow.on( 'close', function () {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element
    mainWindow = null
  } )
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs
app.on( 'ready', function () {
  createWindow()
} )

// Quit when all windows are closed.
app.on( 'window-all-closed', function () {
  app.quit()
} )

app.on( 'activate', function () {
} )
