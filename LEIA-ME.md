# Agenda de Obras — aplicação para Android e Windows

A aplicação fica alojada gratuitamente no GitHub Pages. As tarefas ficam na sua base de dados Supabase, também gratuita.
Instala-se no Android e no Windows como uma aplicação normal: tem ícone próprio, abre em ecrã inteiro e não mostra a barra do navegador.
Tudo sincroniza em tempo real entre dispositivos.

Este processo faz-se uma única vez e demora cerca de 15 minutos.

---

## 1. Criar a base de dados (Supabase)

1. Crie uma conta em https://supabase.com e carregue em **New project**.
   Dê-lhe um nome (por exemplo "agenda-obras"), defina uma palavra-passe para a base de dados e escolha a região **West EU (Ireland)** ou **Central EU (Frankfurt)**.
2. Quando o projeto estiver pronto, abra **SQL Editor › New query**.
   Cole todo o conteúdo do ficheiro `supabase-setup.sql` e carregue em **Run**. Deve aparecer "Success".
3. Crie o seu utilizador em **Authentication › Users › Add user › Create new user**.
   Preencha o email e uma palavra-passe e marque **Auto Confirm User**. Será com estes dados que entra na aplicação.
4. Impeça que outras pessoas criem contas: em **Authentication › Sign In / Providers**, desligue **Allow new users to sign up**.
5. Abra **Project Settings › API** (ou **API Keys**) e copie dois valores:
   - **Project URL**, por exemplo `https://abcdefgh.supabase.co`
   - a chave **anon** / **publishable**. **Nunca use a chave `service_role` / `secret`.**

## 2. Preencher o config.js

Abra o ficheiro `config.js` num editor de texto, como o Bloco de Notas, e cole os dois valores entre as aspas:

```js
window.AGENDA_CONFIG = {
  supabaseUrl: "https://abcdefgh.supabase.co",
  supabaseKey: "eyJhbGciOi...",
};
```

Se preferir não editar o ficheiro, a aplicação pede estes dois valores na primeira abertura em cada dispositivo.

## 3. Publicar a aplicação (GitHub Pages)

1. Crie uma conta em https://github.com e carregue em **New repository**.
   Dê-lhe o nome `agenda-obras`, escolha **Public** e carregue em **Create repository**.
   O código da aplicação fica visível, mas as tarefas não: estão no Supabase, protegidas pelo login.
2. Na página do repositório, carregue em **uploading an existing file**.
   Arraste para lá **todos os ficheiros desta pasta** e carregue em **Commit changes**.
3. Vá a **Settings › Pages**. Em "Branch", escolha **main** e **/ (root)** e carregue em **Save**.
4. Passado um ou dois minutos, a aplicação fica disponível em
   `https://O-SEU-UTILIZADOR.github.io/agenda-obras/`

## 4. Instalar

**Android:** abra o endereço no **Chrome**, toque no menu **⋮** e escolha **Instalar aplicação** (ou "Adicionar ao ecrã principal › Instalar").
A Agenda fica na lista de aplicações, com o seu ícone, e abre sem a barra do navegador.

**Windows:** abra o endereço no **Edge**, carregue no menu **⋯** e escolha **Aplicações › Instalar este site como aplicação**.
O Chrome também serve: use o ícone de instalar na barra de endereço.
A Agenda fica no menu Iniciar e pode ser afixada à barra de tarefas.

Entre com o email e a palavra-passe criados no passo 1.3.

---

## Utilização

- **No telemóvel:** o botão **+ Nova tarefa** abre o formulário. Na vista **Ordem**, use as setas ↑ ↓ para mudar a ordem.
- **Sincronização:** as alterações aparecem nos outros dispositivos em segundos.
- **Sem internet:** a aplicação abre e mostra a última cópia das tarefas. As alterações feitas sem rede não ficam gravadas.
- **Cópias de segurança:** **Exportar cópia** grava um .json com todas as tarefas.
  **Importar** aceita essas cópias e também as da versão local (zip) da agenda.

## Atualizar a aplicação

Para atualizar, substitua os ficheiros no repositório do GitHub. Os dispositivos recebem a versão nova na próxima vez que abrirem a aplicação com internet.
