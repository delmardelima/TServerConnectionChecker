# TServerConnectionChecker

TServerConnectionChecker é uma biblioteca em Delphi para verificação de conexão com servidores. Oferece uma maneira simples de testar a disponibilidade de um servidor e avaliar sua resposta.

## Instalação

Adicione a biblioteca ao seu projeto Delphi importando o arquivo uController.ServerConnection.pas.

## Uso

A seguir está um exemplo de como usar a biblioteca para verificar a conexão com um servidor:

### Declaração no projeto
```
uses uController.ServerConnection; 
```
### Exemplo

```
procedure CheckNextIP(var IP: string);
var
  ServerChecker: TServerConnectionChecker;
  ServerChecker2: TServerConnectionChecker;
begin
  IP := '192.168.2.1';

  ServerChecker := TServerConnectionChecker.Create(IP, '80');
  case ServerChecker.Check of
    ssConnected:
      Exit;
    ssDisconnected, ssError:
      begin
        IP := '192.168.2.2';
        ServerChecker2 := TServerConnectionChecker.Create(IP, '80');
        case ServerChecker2.Check of
          ssConnected:
            Exit;
          ssDisconnected, ssError:
            begin
              IP := '127.0.0.1';
            end;
        end;
      end;
  end;
end; 
```

Esta é uma procedure em Delphi que usa a biblioteca TServerConnectionChecker para verificar a conexão com um servidor. A procedure recebe uma variável IP que é inicialmente definida como _IP_SRV_PRINC.

Em seguida, é criada uma instância da classe TServerConnectionChecker para o endereço de IP e porta especificados. A função Check é chamada para verificar a conexão com o servidor e o resultado é avaliado com o case.

Se a conexão for bem-sucedida, a procedure é finalizada. Caso contrário, a variável IP é alterada para _IP_SRV_SEG e uma nova instância da classe TServerConnectionChecker é criada para este novo endereço de IP. O processo de verificação é repetido.

Se a conexão com ambos os endereços de IP falhar, a variável IP é definida como '127.0.0.1'.

Se você tiver dúvidas sobre o uso da classe TServerConnectionChecker, entre em contato conosco pelo WhatsApp (97) 99144-2486. Estamos sempre dispostos a ajudar.

Se você encontrou essa classe útil e gostaria de fazer uma doação, por favor, envie para o PIX delmar.apui@gmail.com. Seu apoio é muito importante para nós e ajuda a mantê-lo atualizado e disponível para todos. Obrigado!
