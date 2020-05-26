//
//  AppDelegate.swift
//  GoogleKeepMenu
//
//  Created by Brecht Machiels on 30/04/2018.
//  Copyright © 2018 MOS6581. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let menu = NSMenu()
    let popover = NSPopover()
    var alwaysOnTop = false
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menu.delegate = self
        menu.addItem(NSMenuItem(title: "Quit GoogleKeepMenu", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menu.addItem(NSMenuItem(title: "Toggle Always On Top", action: #selector(toggleOnTopClicked), keyEquivalent: "a"))

        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("IconTemplate"))
            button.action = #selector(menuItemClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        popover.animates = false
        popover.contentViewController = GoogleKeepViewController.freshController()

        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown && !strongSelf.alwaysOnTop {
                strongSelf.closePopover(sender: event)
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func toggleOnTopClicked() {
        self.alwaysOnTop = !self.alwaysOnTop
    }

    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }

    @objc func menuItemClicked(_ sender: Any?) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp {
            openMenu(sender)
        } else {
            togglePopover(sender)
        }
    }
    
    func openMenu(_ sender: Any?) {
        self.statusItem.popUpMenu(menu)
    }
    
    func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}

