import flet as ft

def main(page: ft.Page):
    page.title = "COPITAXI - Server"
    page.add(ft.Text("Servidor en tiempo real activo"))
    page.update()

if __name__ == "__main__":
    ft.app(target=main)
