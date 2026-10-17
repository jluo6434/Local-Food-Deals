-- Run once in Supabase SQL Editor.
create table if not exists public.restaurants (
 id text primary key,
 owner_id uuid not null references auth.users(id) on delete cascade,
 profile jsonb not null default '{}'::jsonb,
 settings jsonb not null default '{}'::jsonb,
 menu jsonb not null default '[]'::jsonb,
 published boolean not null default true,
 updated_at timestamptz not null default now()
);
create index if not exists restaurants_owner_idx on public.restaurants(owner_id);
alter table public.restaurants enable row level security;
drop policy if exists "Public can read published restaurants" on public.restaurants;
create policy "Public can read published restaurants" on public.restaurants
for select to anon, authenticated using (published = true or owner_id = (select auth.uid()));
drop policy if exists "Owners can create restaurants" on public.restaurants;
create policy "Owners can create restaurants" on public.restaurants
for insert to authenticated with check (owner_id = (select auth.uid()));
drop policy if exists "Owners can update restaurants" on public.restaurants;
create policy "Owners can update restaurants" on public.restaurants
for update to authenticated using (owner_id = (select auth.uid()))
with check (owner_id = (select auth.uid()));
drop policy if exists "Owners can delete restaurants" on public.restaurants;
create policy "Owners can delete restaurants" on public.restaurants
for delete to authenticated using (owner_id = (select auth.uid()));
-- Enable realtime for public restaurant changes.
do $$ begin
 alter publication supabase_realtime add table public.restaurants;
exception when duplicate_object then null;
end $$;
