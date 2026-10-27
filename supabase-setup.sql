-- Agenda de Obras: cria as tabelas e as regras de acesso.
-- Cole este texto no Supabase › SQL Editor › New query e carregue em Run.

create table if not exists public.tarefas (
  id           text primary key,
  user_id      uuid not null default auth.uid() references auth.users(id) on delete cascade,
  descricao    text not null,
  cliente      text not null default '',
  obra         text not null default '',
  prazo        date not null,
  hora         text not null default '',
  categoria    text not null check (categoria in ('Obra','Desenvolvimento','Orçamento','Elétrico')),
  prioridade   text not null check (prioridade in ('Flexível','Normal','Prioritário','Urgente')),
  estado       text not null default 'Por iniciar' check (estado in ('Por iniciar','Em curso','Em espera','Concluído')),
  ordem        double precision,
  criada       bigint,
  concluida_em bigint,
  atualizada   timestamptz not null default now()
);

-- Base de dados separada para as tarefas concluídas (mesma estrutura)
create table if not exists public.tarefas_concluidas (
  id           text primary key,
  user_id      uuid not null default auth.uid() references auth.users(id) on delete cascade,
  descricao    text not null,
  cliente      text not null default '',
  obra         text not null default '',
  prazo        date not null,
  hora         text not null default '',
  categoria    text not null,
  prioridade   text not null,
  estado       text not null default 'Concluído',
  ordem        double precision,
  criada       bigint,
  concluida_em bigint,
  atualizada   timestamptz not null default now()
);

create index if not exists tarefas_user_idx on public.tarefas (user_id, prazo);
create index if not exists concluidas_user_idx on public.tarefas_concluidas (user_id, concluida_em);

-- Cada utilizador só vê e altera as suas próprias tarefas
alter table public.tarefas enable row level security;
alter table public.tarefas_concluidas enable row level security;

drop policy if exists "proprias tarefas" on public.tarefas;
create policy "proprias tarefas" on public.tarefas
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "proprias concluidas" on public.tarefas_concluidas;
create policy "proprias concluidas" on public.tarefas_concluidas
  for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

grant select, insert, update, delete on public.tarefas, public.tarefas_concluidas to authenticated;

-- Sincronização em tempo real entre dispositivos
do $$ begin
  alter publication supabase_realtime add table public.tarefas;
exception when duplicate_object then null; end $$;
do $$ begin
  alter publication supabase_realtime add table public.tarefas_concluidas;
exception when duplicate_object then null; end $$;
