## Inferência do app E do pseudo-código gerado.
##
## `sig/` na lista de entrada não é opcional: os sidecars de runtime (controller,
## view, Current, Devise) são `.rb` comuns cujo RBS o analyzer infere, e é de lá
## que sai o tipo das classes ERB, dos runners e dos helpers do Devise. Sem isso
## nada do que os geradores abaixo emitem vira tipo.
##
## O destino é o padrão `sig/generated/<caminho-da-fonte>.rbs`, então o RBS do
## pseudo-código aninha (`sig/generated/sig/generated/steep_*_runtime/*.rbs`).
## Feio, mas correto: o Steepfile carrega `sig/` inteiro, e os geradores só
## apagam os próprios `steep_*_runtime/`, nunca o inferido. Um `--output-dir`
## separado resolveria a estética e tornaria `rm -rf sig/generated` seguro.
rbs_infer_all:
	bundle exec rbs_infer app/ lib/ sig/ --output

rbs_collection_update:
	rbs collection update

rbs_rails_generator:
	bundle exec rake rbs_rails:all

rbs_infer_enumerize:
	bundle exec rake rbs_infer:enumerize:all

rbs_infer_carrierwave:
	bundle exec rake rbs_infer:carrierwave:all

## Pseudo-código dos helpers por escopo (`current_user`, `authenticate_user!`, …),
## lido do `devise_for` em config/routes.rb. Emite `.rb`, não `.rbs`: o tipo do
## recurso vem da assinatura do finder do rbs_rails, e o "não-nil sob a guarda"
## vem do halt no corpo — nada é derivado pelo gerador.
rbs_infer_devise:
	bundle exec rake rbs_infer:devise:all

rbs_infer_rails_custom:
	bundle exec rake rbs_infer:rails_custom:all

rbs_infer_module_self_types:
	bundle exec rake rbs_infer:module_self_types:all

rbs_infer_ar_runtime:
	bundle exec rake rbs_infer:ar_runtime:all

## Pseudo-código do que a LINGUAGEM roda numa declaração, irmão dos
## `steep_*_runtime` que modelam o runtime de um FRAMEWORK. `include M` chama
## `M.included(self)`, e essa chamada é a única coisa que diz qual classe é o
## `base` de um hook — `Module#include` é escrito em C, então nenhuma fonte do
## projeto diz isso.
##
## Sem rake task de propósito: o gerador é CORE (`include` é Ruby puro, não
## Rails), então o railtie não o registra e a chamada é direta. Escreve em
## `sig/generated/steep_ruby_runtime/`, cujo RBS sai do `rbs_infer_all`.
rbs_infer_ruby_runtime:
	bundle exec ruby -e "require 'rbs_infer'; require 'rbs_infer/project/ruby_runtime_generator'; RbsInfer::Project::RubyRuntimeGenerator.new(app_dir: '.').generate"

## Inlina a cadeia efetiva de before_action de cada action, com halt check após
## cada elo — é o que carrega os fatos da guarda até a action e até a view.
rbs_infer_controller_runtime:
	bundle exec rake rbs_infer:controller_runtime:all

rbs_infer_current_runtime:
	bundle exec rake rbs_infer:current_runtime:all

## Uma classe por template, com os ivars que ele lê e um `render` por partial —
## a view vira uma classe comum e o RBS dela sai da pipeline normal.
rbs_infer_actionview_runtime:
	bundle exec rake rbs_infer:actionview_runtime:all

## O `has_rich_text` do próprio ActionText, fatiado do gem instalado. O macro
## define três métodos por `class_eval` de uma STRING, e leitor estático nenhum
## entra numa string: `record.content` não é `untyped` hoje, é `NoMethodError` —
## o método não existe para o checker. Faltava só a FONTE, e ela vem no gem.
##
## Com o macro no ar, o que ele escreve em cada call site vira pergunta sobre um
## VALOR: o `:content` do call site chega ao corpo, o heredoc dobra para um
## literal, o `steep check` grava esse literal por call site em
## `sig/generated/.steep_string_evals.yml` e o `StringEvalMacroExpander` o coloca
## na classe que chamou. Os acessores por modelo são portanto INFERIDOS, não
## gerados — saem no RBS do próprio modelo, e só depois de uma volta de
## `rbs_converge`, porque o .yml é saída do steep e entrada do rbs_infer.
##
## Descreve o FRAMEWORK, não o app: é escrito mesmo sem nenhum modelo declarando
## o macro, e fica vazio quando o ActionText não está instalado. Depois do
## rbs_rails, que é quem dá o reader nilable e o builder cuja união tipa o
## acessor.
rbs_infer_actiontext_runtime:
	bundle exec rake rbs_infer:actiontext_runtime:all

## Diretórios órfãos, de geradores que não existem mais. Precisam sair ANTES da
## primeira execução dos geradores novos, senão declaram as mesmas classes duas
## vezes e envenenam o ambiente RBS inteiro:
##
##   sig/rbs_infer_erb/                  -> substituído por steep_actionview_runtime/
##   sig/rbs_infer_devise/               -> substituído por steep_devise_runtime/
##   sig/rbs_infer_current_attributes/   -> gerador removido; os fatos agora são inferidos
##   sig/generated/.expanded/            -> dump do CurrentAttributesExpander, que virou
##                                          o CurrentAttributesRuntimeGenerator
##
## O `.expanded/` é escrito quando um SourceExpander dispara, e hoje só sobraram
## dois (`class_methods do`, `on_load`) — nenhum toca current.rb. Apagar o
## diretório inteiro é seguro justamente por isso: o que ainda for real volta na
## próxima execução do `rbs_infer_all`.
##
## `sig/generated/app/` NÃO entra aqui: continua sendo a saída viva da inferência.
##
## Alvo separado e não incluído em `rbs_generators_all` de propósito: apaga
## coisa, e a decisão é sua.
rbs_clean_stale:
	rm -rf sig/rbs_infer_erb sig/rbs_infer_devise sig/rbs_infer_current_attributes sig/generated/.expanded

rbs_generators_all:
	make rbs_rails_generator
	make rbs_infer_rails_custom
	make rbs_infer_enumerize
	make rbs_infer_carrierwave
	make rbs_infer_devise
	make rbs_infer_module_self_types
	make rbs_infer_ar_runtime
	make rbs_infer_ruby_runtime
	make rbs_infer_controller_runtime
	make rbs_infer_current_runtime
	make rbs_infer_actionview_runtime
	make rbs_infer_actiontext_runtime
	make rbs_infer_all

steep:
	bundle exec steep check

## `.steep_postconditions.yml` é SAÍDA do steep sobre o pseudo-código e ENTRADA
## do rbs_infer. Uma passada só mostra tipos nilable que são atraso, não
## regressão — repita até o `git diff` de sig/ parar de mudar (no dummy do
## rbs_infer leva de 2 a 4 voltas).
rbs_converge:
	make steep || true
	make rbs_infer_all
