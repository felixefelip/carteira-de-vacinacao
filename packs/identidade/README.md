# Identidade

Package responsável por autenticação, contas, pessoas acompanhadas e seleção do perfil ativo.

As classes não usam um namespace Ruby do package. Por exemplo, os modelos públicos são
`User` e `Pessoa`, e não `Identidade::User` ou `Identidade::Pessoa`.

## Dependências

O package depende da infraestrutura compartilhada presente no package raiz.

A fiscalização de dependências permanece temporariamente desativada porque `Pessoa` ainda
possui e cria uma `Caderneta`. Esse acoplamento com Vacinação será removido em uma etapa
posterior da modularização.

