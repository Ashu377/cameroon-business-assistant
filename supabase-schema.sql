-- KumbaBiz single-owner cloud workspace.
-- Run once in the Supabase SQL Editor for this project.
-- The publishable key is safe in the website because RLS limits every row
-- to the signed-in owner. Never put a service_role/secret key in this repo.

create table if not exists public.user_workspaces (
  owner_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"business":{"name":"My Business","phone":"","address":""},"products":[],"customers":[],"sales":[],"language":"en"}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint user_workspaces_payload_object check (jsonb_typeof(payload) = 'object')
);

alter table public.user_workspaces enable row level security;

revoke all on table public.user_workspaces from anon;
grant select, insert, update, delete on table public.user_workspaces to authenticated;

drop policy if exists "Users can read their own KumbaBiz workspace" on public.user_workspaces;
create policy "Users can read their own KumbaBiz workspace"
  on public.user_workspaces for select to authenticated
  using ((select auth.uid()) = owner_id);

drop policy if exists "Users can create their own KumbaBiz workspace" on public.user_workspaces;
create policy "Users can create their own KumbaBiz workspace"
  on public.user_workspaces for insert to authenticated
  with check ((select auth.uid()) = owner_id);

drop policy if exists "Users can update their own KumbaBiz workspace" on public.user_workspaces;
create policy "Users can update their own KumbaBiz workspace"
  on public.user_workspaces for update to authenticated
  using ((select auth.uid()) = owner_id)
  with check ((select auth.uid()) = owner_id);

drop policy if exists "Users can delete their own KumbaBiz workspace" on public.user_workspaces;
create policy "Users can delete their own KumbaBiz workspace"
  on public.user_workspaces for delete to authenticated
  using ((select auth.uid()) = owner_id);

create or replace function public.kumbabiz_set_updated_at()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists kumbabiz_user_workspaces_updated_at on public.user_workspaces;
create trigger kumbabiz_user_workspaces_updated_at
  before update on public.user_workspaces
  for each row execute function public.kumbabiz_set_updated_at();
