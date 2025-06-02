import subprocess
from fastapi import FastAPI, HTTPException, status

app = FastAPI(
    title="API de Gerenciamento de Servidor",
    description="Rotas para reiniciar e atualizar o servidor via comandos do sistema",
    version="1.0.0"
)

def executar_comando(cmd: list[str]) -> str:
    """
    Executa um comando no shell e retorna a saída padrão.
    Em caso de erro, levanta uma exceção HTTP 500.
    """
    try:
        resultado = subprocess.run(
            cmd,
            check=True,           # levanta CalledProcessError se sair com código != 0
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True             # retorna strings em vez de bytes
        )
        return resultado.stdout.strip()
    except subprocess.CalledProcessError as e:
        # Se o comando falhar, disparar erro HTTP 500 com detalhes
        detalhes = e.stderr.strip() or e.stdout.strip()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Falha ao executar '{' '.join(cmd)}': {detalhes}"
        )

# @app.post("/reboot", summary="Reinicia o servidor")
# def reboot_servidor():
#     """
#     Rota que reinicia o servidor.
#     Retorna a saída padrão ou mensagem de confirmação.
#     """
#     saida = executar_comando(["sudo", "systemctl", "reboot"])
#     return {"mensagem": "Comando de reboot enviado.", "output": saida}

@app.post("/update", summary="Atualiza o servidor")
def atualizar_servidor():
    """
    Rota que executa o seu script de atualização (por exemplo: scripts/atualizar_servidor.sh).
    Retorna a saída padrão do script.
    """
    caminho_script = "update.sh"
    saida = executar_comando([caminho_script])
    return {"mensagem": "Script de atualização executado.", "output": saida}

@app.get("/status", summary="Checa se a API está online")
def status_api():
    """
    Rota simples para verificar se a API está rodando.
    """
    return {"status": "API de gerenciamento ativa"}
