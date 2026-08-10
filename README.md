# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Front-end

O estilo é Tailwind CSS v4, compilado pelo binário standalone do
`tailwindcss-rails` a partir de `app/assets/tailwind/application.css`. A saída
(`app/assets/builds/tailwind.css`) é artefato de build e não vai versionada:

* `bin/dev` — sobe o servidor e o `tailwindcss:watch` juntos (via `Procfile.dev`);
* `bin/rails tailwindcss:build` — compila uma vez, necessário antes de rodar os
  testes num checkout limpo.

Os componentes (`.btn-primary`, `.data-table`, `.badge-success`, `.form-input`, …)
estão declarados na camada `components` desse mesmo arquivo.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
