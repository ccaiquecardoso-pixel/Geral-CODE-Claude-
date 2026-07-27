#!/bin/bash
# Instala as 5 skills personalizadas de Caique no Claude Code
# Uso: cole este arquivo em qualquer lugar e rode: bash instalar-skills.sh

set -e

mkdir -p ~/.claude/skills/superpowers
mkdir -p ~/.claude/skills/nova-ferramenta
mkdir -p ~/.claude/skills/debug
mkdir -p ~/.claude/skills/revisar
mkdir -p ~/.claude/skills/melhorar

cat > ~/.claude/skills/superpowers/SKILL.md << 'EOF'
---
name: superpowers
description: Ativa o modo desenvolvedor sênior — Claude planeja antes de agir, faz as perguntas certas e só começa a construir quando tudo está claro
---

Antes de criar ou modificar qualquer coisa, siga este processo obrigatório:

## Fase 1 — Entender (não pule esta etapa)

Leia o pedido com atenção e responda internamente:
- O que exatamente o usuário quer que essa ferramenta faça?
- Quais são as entradas (o que o usuário vai digitar/clicar)?
- Quais são as saídas (o que ele vai ver/receber)?
- Os dados precisam ser salvos? Por quanto tempo?
- Existe alguma ambiguidade que pode gerar retrabalho?

Se houver qualquer ambiguidade relevante, faça NO MÁXIMO 2 perguntas objetivas antes de continuar. Não faça perguntas óbvias.

## Fase 2 — Planejar (escreva antes de codar)

Antes de escrever uma linha de código, declare em texto simples (sem jargão):
- O que será criado (nome do arquivo, tipo)
- As funcionalidades principais que serão entregues
- O que ficará para depois (se houver)

Aguarde confirmação tácita (se o usuário não reclamar do plano, siga em frente).

## Fase 3 — Construir

- Cria o arquivo completo e funcional
- Testa mentalmente cada funcionalidade listada no plano
- Verifica: a interface está em português? Está visualmente apresentável? Funciona em celular?

## Fase 4 — Entregar

- Mostra o caminho do arquivo criado
- Lista o que foi entregue (em linguagem do usuário, não técnica)
- Aponta qualquer limitação conhecida
- Pergunta se quer ajustar algo

## Regra de ouro

Nunca entregue algo que você mesmo não conseguiria usar. Se tiver dúvida se funciona, testa antes de dizer que está pronto.
EOF

cat > ~/.claude/skills/nova-ferramenta/SKILL.md << 'EOF'
---
name: nova-ferramenta
description: Cria uma ferramenta pessoal nova do zero — dashboard, calculadora, formulário, controle, qualquer coisa para uso próprio
---

Crie uma nova ferramenta pessoal: $ARGUMENTS

## Processo

1. **Entenda o pedido** — se faltar informação essencial (ex: quais campos, quais dados), pergunta UMA coisa só
2. **Escolha o formato certo:**
   - Ferramenta simples → arquivo HTML único autocontido
   - Ferramenta com dados salvos → HTML com localStorage
   - Ferramenta complexa → pergunta antes de decidir
3. **Crie o arquivo** na pasta atual com nome descritivo (ex: `controle-gastos.html`)
4. **Padrões obrigatórios:**
   - Interface em português (Brasil)
   - Visual limpo e moderno com cores agradáveis
   - Funciona em mobile
   - Sem dependências externas quando possível (usa CDN do Tailwind se precisar de estilo)
5. **Ao terminar:** mostra o caminho do arquivo e lista as funcionalidades entregues
6. **Pergunta:** tem algo que quer ajustar ou adicionar?
EOF

cat > ~/.claude/skills/debug/SKILL.md << 'EOF'
---
name: debug
description: Investiga e corrige um problema de forma sistemática — sem chutes, sem gambiarras. Identifica a causa raiz antes de propor qualquer solução
---

Investigue o problema: $ARGUMENTS

## Regra número 1

Proibido sugerir qualquer correção antes de completar as fases abaixo. Chutes aleatórios pioram o problema.

## Fase 1 — Reproduzir o problema

- Leia o arquivo em questão completamente
- Entenda o que deveria acontecer vs. o que está acontecendo
- Se o usuário não descreveu o comportamento esperado, pergunta antes de continuar

## Fase 2 — Investigar a causa raiz

Analise metodicamente, verificando em ordem:

1. **Erros óbvios de sintaxe** — parênteses, aspas, ponto-e-vírgula faltando
2. **Lógica quebrada** — condições que nunca são verdadeiras, loops infinitos, cálculos errados
3. **Dados que somem** — localStorage sendo lido antes de salvar, variáveis resetando
4. **Eventos que não disparam** — botão sem event listener, ID errado no HTML
5. **Dependências externas** — CDN offline, API que mudou, URL errada

Para cada item acima: verifique ativamente, não assuma.

## Fase 3 — Diagnóstico

Antes de corrigir, explique em linguagem simples (sem jargão técnico):
- Qual é a causa raiz do problema
- Por que está causando o comportamento errado
- O que a correção vai fazer

## Fase 4 — Corrigir

- Aplica a correção mínima necessária (não reescreve o arquivo inteiro)
- Verifica se a correção não quebrou outra coisa
- Confirma que o problema original foi resolvido

## Fase 5 — Prevenir

Aponta brevemente se existe alguma mudança simples que evitaria esse tipo de problema no futuro. Não é obrigatório implementar agora.
EOF

cat > ~/.claude/skills/revisar/SKILL.md << 'EOF'
---
name: revisar
description: Revisa uma ferramenta buscando erros, bugs ou coisas que não funcionam como esperado
---

Revise a ferramenta: $ARGUMENTS

## Processo

1. **Leia o arquivo** completamente
2. **Verifique:**
   - Erros de JavaScript que podem travar a página
   - Botões ou links que não fazem nada
   - Dados que não salvam ou somem ao recarregar (quando deveriam salvar)
   - Visual quebrado em telas pequenas (mobile)
   - Textos em inglês que deveriam estar em português
   - Campos sem validação que poderiam causar erros
3. **Relate o que encontrou** em lista simples e clara, sem jargão técnico
4. **Pergunta:** quer que eu corrija tudo agora, ou prefere escolher o que corrigir?
5. **Corrija** o que for solicitado e confirma que está funcionando
EOF

cat > ~/.claude/skills/melhorar/SKILL.md << 'EOF'
---
name: melhorar
description: Melhora ou adiciona funcionalidades a uma ferramenta já existente
---

Melhore a ferramenta: $ARGUMENTS

## Processo

1. **Leia o arquivo atual** — entenda o que já existe antes de mudar qualquer coisa
2. **Identifique o pedido de melhoria** — se não especificado em $ARGUMENTS, pergunta o que quer melhorar
3. **Planeje antes de editar:**
   - Lista o que vai mudar
   - Confirma que não vai quebrar o que já funciona
4. **Faça as mudanças** preservando tudo que já estava funcionando
5. **Ao terminar:** lista exatamente o que mudou e o que foi adicionado
6. **Pergunta:** ficou como esperado? Quer mais algum ajuste?

## Regras
- Nunca remove funcionalidade existente sem perguntar primeiro
- Mantém o visual consistente com o que já existe
- Se a melhoria for grande, faz em etapas e confirma cada uma
EOF

echo "✅ 5 skills instaladas em ~/.claude/skills/"
echo "   superpowers, nova-ferramenta, debug, revisar, melhorar"
echo ""
echo "Rode 'claude' e digite /skills para conferir que apareceram."
