# AstroDay
É um aplicativo "APOD"(Imagem Astronômica do Dia) fornecida pela NASA. O aplicativo busca os dados da API APOD da NASA, exibi a imagem ou vídeo do dia, juntamente com informações relevantes como título, descrição e data. APOD pode apresentar tanto imagens quanto vídeos, o aplicativo lida com ambos os tipos de mídia de forma eficaz.

## Instruções para executar o projeto:
1. Faça o clone deste repositório;
2. Após efetuar o clone, abra o arquivo AstroDay.xcodeproj na pasta AstroDay;
3. Aguarde o projeto ser buildado;
4. Selecione o Schema AstroDay e rode o projeto;

## Observações: 
Para alterar a URL e APIKey:

Acesse a pasta AstroDay > Environment > Develop > environment.plist;
- apodBaseUrl -> Consta a URLBase;
- apodAPIKey -> Consta a APIKey;

Essa chave de API pode ser usada para explorar APIs inicialmente antes de se inscrever, mas tem limites de taxa muito mais baixos, então você é encorajado a se inscrever para sua própria chave de API se planeja usar a API (a inscrição é rápida e fácil). Os limites de taxa para a DEMO_KEY são:

- Limite por hora: 30 solicitações por endereço IP por hora
- Limite diário: 50 solicitações por endereço IP por dia

## Solução adotada:

Para esse projeto, usei a arquitetura MVVMC pelos seguintes motivos:

- Separação de Responsabilidades;
- Gerenciamento de Navegação;
- Reutilização de Código;
- Testabilidade;
- Escalabilidade;
- Facilidade de Manutenção;

## Libs utilizadas:

- Alamofire;
- Kingfisher;
- Lottie;

## Escolhas feitas:

Optei por desenvolver as telas em ViewCode pelos seguintes motivos:

- Controle Total sobre a Interface;
- Consistência e Escalabilidade;
- Reutilização de Componentes;
- Facilidade de Refatoração;
- Melhor Controle sobre a Lógica de Layout;
- Integração com Ferramentas de Versionamento;
- Menos Dependência de Arquivos de Interface;
- Testabilidade;

## Estrutura:
- Models
- Services
- Views
- ViewControllers
- Utils
- Persistence

## Integração com a API:
* URLSession
* Parsing do JSON para um APODModel
* Detectado se o retorno da API contém imagem ou vídeo

## Funcionalidades:
- Imagem e Cache
- Vídeo (usado WKWebView para exibir URLs do YouTube)
- Título, data e descrição
- Indicador de carregamento enquanto os dados são buscados

## Navegação de Datas:
- Adicionado um seletor de data (UIDatePicker)
- Busca a APOD da data escolhida e atualiza a UI

## Favoritos:
- Criado um sistema de persistência (UserDefaults)
- Criado FavoritesViewController para exibir a lista de APODs salvas
- Salvar/Remover favoritos

## Interface do Usuário (UI)
- Criado um layout responsivo para diferentes dispositivos
- Suporte a tema claro/escuro usando traitCollection.userInterfaceStyle
- Mensagens amigáveis para erros e feedback ao usuário

## Desempenho e Otimização
- Cache de imagens usando Kingfisher.
- Gerenciamento eficiente do estado da UI.
- Carregamentos desnecessários reutilizando dados em cache.

## Testes:
- Testes unitários no APODService e demais arquivos usando XCTest.
  
| Coverage | 87% ✅|
|----------|----------|

## Image Example

| Screens | | | | 
|----------|----------|----------|----------|
| <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod1.png" alt="1" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod2.png" alt="2" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod3.png" alt="3" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod4.png" alt="4" width="200"> 
| <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod5.png" alt="5" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod6.png" alt="6" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod7.png" alt="7" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod8.png" alt="8" width="200"> |
| <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod9.png" alt="9" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod10.png" alt="10" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod11.png" alt="11" width="200"> | <img src="https://github.com/edwylugo/AstroDay/blob/develop/prints/apod12.png" alt="12" width="200"> |



## O que foi feito de bônus:
- Remover favoritos;
