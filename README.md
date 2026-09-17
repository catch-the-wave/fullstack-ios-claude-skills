# Skills — Unified Agent Skill Collection

Единый репозиторий скиллов для AI-агентов (Claude Code, Pi, Codex, Cursor, OpenCode и других).

## Таксономия

```
Skills/
├── product/      # Продукт и стратегия (AJTBD, NMT, ценообразование)
├── design/       # UI/UX, визуальный дизайн, вкус
├── dev/          # iOS, Swift, архитектура, Remotion
├── research/     # Исследования и методологии (TRIZ, UX-аудит)
├── misc/         # Общее (оркестрация, онбординг, искусство)
├── _config/      # Конфиги для агентов
├── _bootstrap.sh # Скрипт настройки нового агента
└── _nmt/         # Next Move Theory (git submodule, опционально)
```

## Установка на новую машину

```bash
# 1. Клонировать
git clone git@github.com:catch-the-wave/fullstack-ios-claude-skills.git ~/Skills
cd ~/Skills

# 2. Подключить NMT (опционально)
git submodule add https://github.com/zamesin/Next-Move-Theory-Canon-and-Skills.git _nmt

# 3. Настроить агентов
bash _bootstrap.sh all
```

## Как агенты находят скиллы

| Агент | Механизм | Статус |
|-------|----------|--------|
| **Claude Code** | Сканирует `~/.claude/skills/` рекурсивно | ✅ Симлинк на Skills |
| **Pi** | Читает `settings.json` с путём к папке | ✅ Настроен |
| **Codex** | Читает `config.toml` с явными путями | ✅ Все 37 enabled |
| **Cursor** | Сканирует `~/.cursor/skills/` | ✅ Симлинк на Skills |
| **OpenCode** | Сканирует skills-директорию | ✅ Симлинк на Skills |

### Codex

Codex использует явные пути в `~/.codex/config.toml`. Конфиг генерируется автоматически:

```bash
cp _config/codex.toml ~/.codex/config.toml
```

Все скиллы должны быть `enabled = true`. Если Codex не видит скилл — проверьте, что путь существует и разрешается через симлинк.

## Обновление

```bash
# Обновить Skills из репозитория
cd ~/Skills && git pull

# Обновить NMT
cd ~/Skills/_nmt && git pull

# Обновить скиллы из их исходных репозиториев (через skills.sh)
npx skills update
```

## Добавление нового скилла

```bash
# 1. Создать в нужной категории
mkdir -p product/my-skill
touch product/my-skill/SKILL.md

# 2. Заполнить frontmatter
cat > product/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: What this skill does and when to use it.
---
EOF

# 3. Обновить конфиг Codex
cd ~/Skills && ./_config/generate-codex-config.sh  # или руками

# 4. Закоммитить
git add product/my-skill
git commit -m "feat: add my-skill"
git push
```

## Формат SKILL.md

Следует [Agent Skills Standard](https://agentskills.io/specification):

```yaml
---
name: my-skill          # lowercase, hyphens, макс 64 символа
description: >-         # макс 1024 символа
  Когда использовать этот скилл и что он делает.
---
```

## Принципы

1. **Один источник истины** — все скиллы лежат в `~/Skills/`, разложены по категориям
2. **Агенты читают через симлинки** — нигде ничего не копируется
3. **Git-история сохраняется** — `git mv` для перемещений, не просто копирование
4. **NMT отдельно** — живёт своей жизнью через git submodule, обновляется независимо
5. **Codex требует явных путей** — это особенность архитектуры Codex, конфиг генерируется автоматически