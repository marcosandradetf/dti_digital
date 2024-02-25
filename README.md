# App de lembretes Dti Digital
### Código escrito em flutter

Alguns pontos cruciais do meu projeto:
1. O backend será um arquivo JSON local dentro do próprio sistema android.
2. Os lembretes são separados por dias conforme clicados no calendário.
3. O projeto possuí testes unitários.

Além disso, algumas dependências usadas:
- table_calendar
- path_provider
- go_router

### SDK
- flutter: 3.19.1
- Gradle 7.6.4
- Git

## Requisitos do Ambiente
Certifique-se de ter o seguinte configurado em seu ambiente antes de executar o aplicativo.

### Ambiente de Desenvolvimento
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)

### Configuração do Emulador/Dispositivo Real
Emulador ou dispositivo real para testar o aplicativo. Siga as instruções abaixo para configurar:

- [Configurando um Emulador no Android Studio](https://developer.android.com/studio/run/managing-avds)
- [Conectando um Dispositivo Físico para Teste](https://flutter.dev/docs/get-started/install/windows#set-up-your-android-device)

### Preparando o ambiente para primeira execução
clonar o projeto
```
git clone https://github.com/marcosandradetf/dti_digital.git
```
Navegue até o diretório do projeto:
```
cd dti_digital
```
Obtenha as dependencias necessárias
```
flutter pub get
```
Executando
```
flutter run
```

## Atualizando Dependências
Para garantir que você está usando as versões mais recentes das dependências, execute:
Obter as dependencias necessárias
```
flutter pub upgrade
```

### Como rodar os testes
```
flutter test --update-goldens integration_test/
```


