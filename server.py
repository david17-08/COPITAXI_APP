import flet as ft

def main(page: ft.Page):
    page.title = "COPITAXI - Server"
    page.add(ft.Text("Servidor en tiempo real activo"))
    page.update()

ft.app(target=main)
