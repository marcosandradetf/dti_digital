# App de lembretes Dti Digital
### Código escrito em flutter

Alguns pontos cruciais do meu projeto:
1. O backend foi desenvolvido em java/spring.
2. Os lembretes são separados por dias conforme clicados no calendário.
3. O projeto possuí testes unitários.

Além disso, algumas dependências usadas:
- table_calendar
- path_provider
- go_router
- dio

### SDK
- flutter: 3.19.1
- Gradle 7.6.4
- Git
- Java SDK 17

## Requisitos do Ambiente
Certifique-se de ter o seguinte configurado em seu ambiente antes de executar o aplicativo.

### Ambiente de Desenvolvimento
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- [Intellij](https://www.jetbrains.com/idea/download/?fromIDE=&section=windows)

### Configuração do Emulador/Dispositivo Real
Emulador ou dispositivo real para testar o aplicativo. Siga as instruções abaixo para configurar:

- [Configurando um Emulador no Android Studio](https://developer.android.com/studio/run/managing-avds)
- [Conectando um Dispositivo Físico para Teste](https://flutter.dev/docs/get-started/install/windows#set-up-your-android-device)

# Preparando o Ambiente para primeira execucao
- clonar o projeto
```
git clone https://github.com/marcosandradetf/dti_digital.git
```
## Siga os passos para preparar o ambiente do backend para primeira execução após instalar o Java e o Gradle na máquina
### Configurando o IP do Backend no Flutter

**Atenção**, Para se comunicar corretamente com o backend a partir do aplicativo Flutter, você precisa garantir que o IP do backend seja corretamente configurado no código.

Siga as etapas abaixo para configurar o IP do backend:

1. Abra o arquivo lib/data.dart no diretório flutter.

2. Procure pela variável ip e altere o valor atribuído para o IP do seu backend.

``
String ip = "192.168.1.2";
``

Altere para o endereço ipv4 da sua maquina, podendo ser encontrado executando via terminal o comando ipconfig (windows) ou ifconfig (linux, macOs)

3. Salve o arquivo após fazer as alterações.
4. Agora, você pode executar o aplicativo Flutter normalmente.
5. Volte ao terminal e navegue até o diretório do backend
```
cd backend
```
6. Executar o Build
```
./gradlew build
```
7. Executar a Aplicação
```
./gradlew bootRun
```

## Preparando o ambiente flutter para primeira execução
1. **Atenção**: Sem interromper a execucao do backend, abra um novo terminal
2. Navegue até o diretório do projeto:
```
cd dti_digital
```
3. Navegue até o diretório do flutter:
```
cd flutter
```
4. Obtenha as dependencias necessárias
```
flutter pub get
```
5. Executando
```
flutter run
```

## Observações: 
1. Caso obtenha algum erro, o comando irá verificar o ambiente.
Considere executar
```
flutter doctor
```
2. Caso deseje executar em um emulador, siga as instruções anexadas de como configurar um emulador.


## Atualizando Dependências
Para garantir que você está usando as versões mais recentes das dependências, execute:
Obter as dependencias necessárias
```
flutter pub upgrade
```

### Como rodar os testes
**Atenção**: Certifique-se de que o backend já está em execução e Execute o comando:

```
flutter test --update-goldens integration_test/
```


