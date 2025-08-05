import os
import sys
import subprocess
import time
import webbrowser
from pathlib import Path
import threading
import tempfile
import shutil

def create_base_dados_folder():
    """Cria a pasta base_dados no diretório do executável"""
    if getattr(sys, 'frozen', False):
        # Se estiver rodando como executável
        exe_dir = os.path.dirname(sys.executable)
    else:
        # Se estiver rodando como script Python
        exe_dir = os.path.dirname(os.path.abspath(__file__))
    
    base_dados_path = os.path.join(exe_dir, 'base_dados')
    
    if not os.path.exists(base_dados_path):
        os.makedirs(base_dados_path)
        print(f"Pasta 'base_dados' criada em: {base_dados_path}")
    else:
        print(f"Pasta 'base_dados' já existe em: {base_dados_path}")
    
    return base_dados_path

def start_server():
    """Inicia o servidor Flask"""
    try:
        # Configura o diretório base
        if getattr(sys, 'frozen', False):
            # Se estiver rodando como executável
            base_dir = os.path.dirname(sys.executable)
            # Extrai arquivos estáticos para o diretório do executável
            static_source = os.path.join(sys._MEIPASS, 'static')
            static_dest = os.path.join(base_dir, 'static')
            if os.path.exists(static_source) and not os.path.exists(static_dest):
                shutil.copytree(static_source, static_dest)
            
            # Copia main.py para o diretório do executável
            main_source = os.path.join(sys._MEIPASS, 'main.py')
            main_dest = os.path.join(base_dir, 'main.py')
            if os.path.exists(main_source) and not os.path.exists(main_dest):
                shutil.copy2(main_source, main_dest)
            
            # Muda para o diretório do executável
            os.chdir(base_dir)
        else:
            # Se estiver rodando como script Python
            base_dir = os.path.dirname(os.path.abspath(__file__))
            os.chdir(base_dir)
        
        # Importa e executa o main.py
        import main
        import uvicorn
        uvicorn.run(main.app, host='localhost', port=8000)
    except Exception as e:
        print(f"Erro ao iniciar servidor: {e}")
        print(f"Diretório atual: {os.getcwd()}")
        print(f"Arquivos no diretório: {os.listdir('.')}")
        input("Pressione Enter para sair...")

def open_browser():
    """Abre o navegador Chrome no dashboard"""
    time.sleep(3)  # Aguarda o servidor inicializar
    
    url = "http://localhost:8000"
    
    # Tenta abrir no Chrome especificamente
    chrome_paths = [
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
        r"C:\Users\{}\AppData\Local\Google\Chrome\Application\chrome.exe".format(os.getenv('USERNAME'))
    ]
    
    chrome_found = False
    for chrome_path in chrome_paths:
        if os.path.exists(chrome_path):
            try:
                subprocess.Popen([chrome_path, url])
                chrome_found = True
                print(f"Dashboard aberto no Chrome: {url}")
                break
            except Exception as e:
                print(f"Erro ao abrir Chrome em {chrome_path}: {e}")
    
    if not chrome_found:
        # Se não encontrar o Chrome, usa o navegador padrão
        try:
            webbrowser.open(url)
            print(f"Dashboard aberto no navegador padrão: {url}")
        except Exception as e:
            print(f"Erro ao abrir navegador: {e}")

def main():
    """Função principal do launcher"""
    print("=== Dashboard Holy Foods - Inadimplência ===")
    print("Iniciando aplicação...")
    
    # Cria a pasta base_dados
    create_base_dados_folder()
    
    # Inicia o navegador em uma thread separada
    browser_thread = threading.Thread(target=open_browser)
    browser_thread.daemon = True
    browser_thread.start()
    
    # Inicia o servidor (bloqueia a execução)
    print("Iniciando servidor...")
    start_server()

if __name__ == "__main__":
    main()