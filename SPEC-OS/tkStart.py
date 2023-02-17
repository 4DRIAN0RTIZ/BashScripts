#!/usr/bin/env python3

import tkinter
import subprocess
import os
import getpass
import PIL

# Password entry
def get_password():
    password = entry.get()
    if password == "password":
        # Start the program with the function
        return menu_start()
    else:
        print("Contraseña incorrecta")
        return password

def menu_start():
    passwin.destroy()
    # Create the menu
    menu = tkinter.Tk()
    menu.title("Spec-OS")
    menu.geometry("200x500")
    menu.resizable(0, 0)
    # Create the widgets
    label = tkinter.Label(menu, text="Menú", font=("Arial", 20), fg="#ffffff", bg="#000000")
    label.pack(side="top", fill="x")
    # Modern button
    btn = tkinter.Button(menu, text="Iniciar", font=("Arial", 20), fg="#ffffff", bg="#000000", command=menu_start)
    btn.pack(side="bottom" , fill="x")
    menu.mainloop()

# Create the passwin
passwin = tkinter.Tk()
toolbar = tkinter.Frame(passwin)
toolbar.pack(side="top", fill="x")
passwin.title("Spec-OS")
passwin.geometry("400x200")
passwin.resizable(0, 0)
passwin.configure(background="#000000")

# PhotoImage


# Send the image to the background
photo = tkinter.PhotoImage(file="./.data/.img/bg.gif")
label = tkinter.Label(passwin, image=photo)
label.place(x=0, y=0, relwidth=1, relheight=1)





# Create the widgets
label = tkinter.Label(passwin, text="Escribe la contraseña", font=("Arial", 20), fg="#ffffff", bg="#000000")
label.pack(side="top", fill="x")
entry = tkinter.Entry(passwin, font=("Arial", 20), fg="#ffffff", bg="#000000", show="*")
entry.pack(side="top", fill="x")

# Modern button
btn = tkinter.Button(passwin, text="Iniciar", font=("Arial", 20), fg="#ffffff", bg="#000000", command=get_password)
btn.pack(side="bottom" , fill="x")

passwin.mainloop()





