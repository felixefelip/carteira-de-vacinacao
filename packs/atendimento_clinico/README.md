# Atendimento clínico

Package responsável por agendamentos e, futuramente, consultas, exames, medicamentos e
prescrições.

As classes não usam um namespace Ruby do package. Por exemplo, o modelo público é
`Agendamento`, e não `AtendimentoClinico::Agendamento`.

## Dependências

O package depende da infraestrutura compartilhada do package raiz e das pessoas mantidas
pelo package Identidade. Ele não depende dos domínios de Vacinação ou Financeiro.

O valor guardado no agendamento é a fotografia do valor previsto ou combinado. Quando o
contexto Financeiro for implementado, ele será responsável pelo ciclo financeiro completo.
