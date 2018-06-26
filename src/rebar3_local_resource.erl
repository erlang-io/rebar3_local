-module(rebar3_local_resource).

-behaviour(rebar_resource).

-export([download/3, lock/2, make_vsn/1, needs_update/2]).

-define(DEFAULT_EXCLUDED_FILES, ["_build", "rebar.lock", ".rebar", ".rebar3"]).

lock(_Dir, Source) -> Source.

needs_update(_AppDir, _Resource) -> true.

download(AppDir, {local, Path}, _State) ->
  download(AppDir, {local, Path, {exclude, []}}, _State);
download(AppDir, {local, Path, {exclude, Exclusions}}, State) ->
  Files = dep_files(filename:join([rebar_state:dir(State), "local", Path]), Exclusions),
  {rebar_file_utils:cp_r(Files, AppDir), undefined}.

dep_files(FromDir, Exclusions) ->
  {ok, List} = file:list_dir(FromDir),
  lists:filtermap(fun (F) -> file_filter_join(FromDir, F, Exclusions) end, List).

file_filter_join(FromDir, File, Exclusions) ->
  case lists:member(File, Exclusions ++ ?DEFAULT_EXCLUDED_FILES) of
	true -> false;
    false -> {true, filename:join([FromDir, File])}
  end.

make_vsn(AppDir) ->
  [AppInfo] = rebar_app_discover:find_apps([AppDir], all),
  OriginalVsn = rebar_app_info:original_vsn(AppInfo),
  {plain, OriginalVsn}.
