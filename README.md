# Downloader
### Projeto para gerenciador de download
Sistema desenvolvido usando padrões Factory, Singleton, Observer e boas práticas de OO, SOLID e Clean Code, além de programação orientada à interface, aumentando a abstração, diminuindo o acoplamento e melhorando a manutenção.

![Tela Principal](https://github.com/RodrigoVelez/ProjetoDownloader/blob/main/imagens/TelaPrincipal.png)

>**Informações de uso**

- No campo "Link para download o usuário digita o link para fazer o download
- Botões:
  - Iniciar download: Onde efetivamente inicia o processo de download
  - Histórico de downloads: Onde mostra uma tela com todos os downloads realizados, independente de estar concluído ou não.
  - Info: Onde mostra uma tela com a informação do download que esta selecionado na tela principal, independente de estar concluído ou não.
  - Parar: Onde faz com que o download em andamento seja parado.

>**Fechamento do sistema**

Ao sair fechar o sistema, é verificado se existe algum download em andamento e sajo exista, o usuário é questionado se ele realmente deseja sair do sistema.

## Dados técnicos
- Na pasta config existe um arquivo onde deve ter as configurações de conexão com o banco de dados. Ele deve ser atualizado de acordo com o caminho do arquivo *.db para evitar problemas de conexão com o banco de dados.
- A pasta downloads não pode ser modificada, pois é nela onde o usuário vai visualizar os arquivos baixados.

## Nota para o desenvolvedor
- Para cada requisição de qownload, uma nova Task é instanceada com os dados para requisição.
- Quando uma Task é finalizada ela sinaliza ao controlador, usando o padrão observer, o controlador, que, por sua vez, também usando o padrão observer, sinaliza para a interfase (camada view) para mostrar ao usuário do andamento do download.

## Próximos passos
- Quando o usuário clica no botão de parar download, a Task é cancelada, mas em alguns momentos foi verificado que mesmo cancelada, o download ainda estava em execução e atualizando a interface. Para corrigir deve ser implementado o mesmo padrão observer mas sempre que o controlador for sinalizado que necessita cancelar o download, fazer a mesma sinalização para a Task, notificando-a para que o IdHTTP seja desconectado.
